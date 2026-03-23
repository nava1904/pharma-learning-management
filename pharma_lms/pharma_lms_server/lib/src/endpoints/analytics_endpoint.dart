import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';
import '../services/rbac_helper.dart';
import '../services/scheduled_job_service.dart';

/// Analytics & Reporting domain endpoint.
class AnalyticsEndpoint extends Endpoint {
  /// Course analytics - pass rate and score distribution from TrainingRecord.
  Future<CourseAnalytics> getCourseAnalytics(
    Session session,
    int courseVersionId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return CourseAnalytics(
        courseVersionId: courseVersionId,
        passRate: 0.0,
        totalAttempts: 0,
        passedCount: 0,
        scoreDistributionJson: '{}',
      );
    }
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) {
      return CourseAnalytics(
        courseVersionId: courseVersionId,
        passRate: 0.0,
        totalAttempts: 0,
        passedCount: 0,
        scoreDistributionJson: '{}',
      );
    }
    final records = await TrainingRecord.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    final assessment = await Assessment.db.findFirstRow(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    final passingScore = assessment?.passingScore ?? 80;

    var passedCount = 0;
    final buckets = <String, int>{
      '0-20': 0,
      '21-40': 0,
      '41-60': 0,
      '61-80': 0,
      '81-100': 0,
    };

    for (final r in records) {
      final score = r.score ?? 0;
      if (score >= passingScore) passedCount++;
      if (score <= 20) {
        buckets['0-20'] = buckets['0-20']! + 1;
      } else if (score <= 40) buckets['21-40'] = buckets['21-40']! + 1;
      else if (score <= 60) buckets['41-60'] = buckets['41-60']! + 1;
      else if (score <= 80) buckets['61-80'] = buckets['61-80']! + 1;
      else buckets['81-100'] = buckets['81-100']! + 1;
    }

    final total = records.length;
    final passRate = total > 0 ? passedCount / total : 0.0;

    return CourseAnalytics(
      courseVersionId: courseVersionId,
      passRate: passRate,
      totalAttempts: total,
      passedCount: passedCount,
      scoreDistributionJson: jsonEncode(buckets),
    );
  }

  /// Training completion rate by department.
  Future<Map<String, double>> getTrainingCompletionRate(
    Session session, {
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return {};
    final departments = await Department.db.find(session);
    final result = <String, double>{};

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      result[dept.name] = metrics.complianceRate;
    }
    return result;
  }

  /// IT-02: System health - job status, DLQ count, DB connectivity.
  Future<Map<String, dynamic>> getSystemHealth(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return {'databaseConnected': false, 'dlqCount': 0, 'kafkaConsumerLag': 0, 'recentJobs': <Map<String, dynamic>>[]};
    }
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) {
      return {'databaseConnected': false, 'dlqCount': 0, 'kafkaConsumerLag': 0, 'recentJobs': <Map<String, dynamic>>[]};
    }
    var dbOk = true;
    try {
      await AuditTrail.db.find(session, limit: 1);
    } catch (_) {
      dbOk = false;
    }
    var dlqCount = 0;
    try {
      dlqCount = await DeadLetterQueue.db.count(
        session,
        where: (t) => t.manuallyResolved.equals(false),
      );
    } catch (_) {}
    final jobLogs = await ScheduledJobLog.db.find(
      session,
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: 5,
    );
    return {
      'databaseConnected': dbOk,
      'dlqCount': dlqCount,
      'kafkaConsumerLag': 0,
      'recentJobs': jobLogs
          .map((j) => {
                'jobName': j.jobName,
                'startedAt': j.startedAt.toIso8601String(),
                'completedAt': j.completedAt?.toIso8601String(),
                'status': j.status,
                'recordsProcessed': j.recordsProcessed,
              })
          .toList(),
    };
  }

  /// IT-WF-04: Manual trigger for background jobs.
  /// Supported jobNames: CertExpiryCheck, NotificationWorker, ComplianceCalc, AuditTrailIntegrityCheck
  Future<Map<String, dynamic>> triggerManualJob(
    Session session, {
    required String jobName,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'write');
    
    switch (jobName) {
      case 'CertExpiryCheck':
        return await ScheduledJobService.runCertExpiryCheck(session);
      case 'NotificationWorker':
        return await ScheduledJobService.runNotificationWorker(session);
      case 'ComplianceCalc':
        return await ScheduledJobService.runComplianceCalc(session);
      case 'AuditTrailIntegrityCheck':
        return await ScheduledJobService.runAuditTrailIntegrityCheck(session);
      default:
        // Legacy: just log the trigger
        await ScheduledJobLog.db.insertRow(
          session,
          ScheduledJobLog(
            jobName: jobName,
            status: 'triggered',
            recordsProcessed: 0,
          ),
        );
        return {'success': true, 'jobName': jobName, 'message': 'Job triggered (legacy mode)'};
    }
  }

  /// SYS-WF-04: Run certificate expiry check job.
  /// Creates renewal assignments for certificates expiring in 30-60 days.
  /// Marks expired certificates and logs to audit trail.
  Future<Map<String, dynamic>> runCertExpiryCheck(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'write');
    return await ScheduledJobService.runCertExpiryCheck(session);
  }

  /// SYS-WF-05: Run notification worker job.
  /// Processes escalation ladder for due/overdue enrollments.
  Future<Map<String, dynamic>> runNotificationWorker(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'write');
    return await ScheduledJobService.runNotificationWorker(session);
  }

  /// SYS-WF-07: Run compliance calculation job.
  /// Computes org-wide and dept-wide compliance, writes snapshots.
  Future<Map<String, dynamic>> runComplianceCalc(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'write');
    return await ScheduledJobService.runComplianceCalc(session);
  }

  /// SYS-WF-08: Run audit trail integrity check (CRITICAL - 21 CFR Part 11).
  /// Verifies SHA-256 hashes and sequence continuity.
  /// Throws exception if integrity issues found.
  Future<Map<String, dynamic>> runAuditTrailIntegrityCheck(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'write');
    return await ScheduledJobService.runAuditTrailIntegrityCheck(session);
  }

  /// Department compliance summary.
  Future<List<DepartmentComplianceSummary>> getDepartmentComplianceSummary(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final departments = await Department.db.find(session);
    final result = <DepartmentComplianceSummary>[];

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      result.add(DepartmentComplianceSummary(
        departmentId: dept.id,
        departmentName: dept.name,
        totalEmployees: metrics.totalEmployees,
        compliant: metrics.compliant,
        overdue: metrics.overdue,
        upcoming: metrics.upcoming,
        complianceRate: metrics.complianceRate,
      ));
    }
    return result;
  }

  /// Certification expiry risk - count of certs expiring in next 30 days.
  Future<int> getCertificationExpiryRiskCount(
    Session session, {
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0;
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return 0;
    final now = DateTime.now();
    final threshold = now.add(const Duration(days: 30));

    final certs = await Certificate.db.find(session);
    var count = 0;
    for (final cert in certs) {
      if (cert.expiresAt != null &&
          cert.expiresAt!.isAfter(now) &&
          cert.expiresAt!.isBefore(threshold)) {
        count++;
      }
    }
    return count;
  }

  /// Audit readiness score - based on compliance and audit trail completeness.
  Future<AuditReadinessScore> getAuditReadinessScore(
    Session session, {
    int? organizationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return AuditReadinessScore(
        complianceScore: 0.0,
        auditTrailActive: false,
        departmentCount: 0,
        overallScore: 0.0,
      );
    }
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    final departments = await Department.db.find(session);
    var totalCompliance = 0.0;
    var deptCount = 0;

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      totalCompliance += metrics.complianceRate;
      deptCount++;
    }

    final avgCompliance = deptCount > 0 ? totalCompliance / deptCount : 0.0;
    final auditTrailCount = await AuditTrail.db.find(session, limit: 1);
    final hasAuditTrail = auditTrailCount.isNotEmpty;

    return AuditReadinessScore(
      complianceScore: avgCompliance,
      auditTrailActive: hasAuditTrail,
      departmentCount: deptCount,
      overallScore: avgCompliance * (hasAuditTrail ? 1.0 : 0.9),
    );
  }

  Future<List<ReportDefinition>> listReportDefinitions(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    return await ReportDefinition.db.find(session);
  }

  Future<List<Dashboard>> listDashboards(
    Session session, {
    int? roleId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    var results = await Dashboard.db.find(session);
    if (roleId != null) {
      results = results.where((d) => d.roleId == roleId).toList();
    }
    return results;
  }

  Future<List<SlaBreach>> getOpenSlaBreaches(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final breaches = await SlaBreach.db.find(session);
    return breaches.where((b) => b.resolvedAt == null).toList();
  }

  /// Non-compliant employees (overdue training).
  Future<List<PharmaUser>> getNonCompliantEmployees(
    Session session, {
    int? departmentId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => t.dueDate < DateTime.now(),
    );
    final overdueUserIds = <int>{};
    for (final a in assignments) {
      final enc = await Enrollment.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(a.userId) &
            t.courseVersionId.equals(a.courseVersionId) &
            t.status.notEquals('completed'),
      );
      if (enc != null) overdueUserIds.add(a.userId);
    }
    if (overdueUserIds.isEmpty) return [];
    var users = await PharmaUser.db.find(
      session,
      where: (t) => t.id.inSet(overdueUserIds.toSet()),
      include: PharmaUser.include(department: Department.include()),
    );
    if (departmentId != null) {
      users = users.where((u) => u.departmentId == departmentId).toList();
    }
    return users;
  }

  /// Upcoming certificate expirations by department (30/60/90 days).
  Future<Map<String, List<Certificate>>> getUpcomingExpirationsByDepartment(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return {};
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return {};
    final now = DateTime.now();
    final day90 = now.add(const Duration(days: 90));

    final certs = await Certificate.db.find(
      session,
      where: (t) => t.status.equals('active'),
      include: Certificate.include(
        user: PharmaUser.include(department: Department.include()),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    final expiring = certs.where((c) {
      if (c.expiresAt == null) return false;
      return c.expiresAt!.isAfter(now) && c.expiresAt!.isBefore(day90);
    }).toList();
    final byDept = <String, List<Certificate>>{};
    for (final c in expiring) {
      final deptName = c.user?.department?.name ?? 'Unknown';
      byDept.putIfAbsent(deptName, () => []).add(c);
    }
    return byDept;
  }

  /// Recent training assignments (last 10).
  Future<List<TrainingAssignment>> getRecentAssignments(
    Session session, {
    int limit = 10,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    return await TrainingAssignment.db.find(
      session,
      orderBy: (t) => t.assignedAt,
      orderDescending: true,
      limit: limit,
      include: TrainingAssignment.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
  }

  /// Open CAPAs requiring training (not yet completed).
  Future<List<Capa>> getOpenCapasRequiringTraining(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final capas = await Capa.db.find(
      session,
      where: (t) =>
          t.trainingRequired.equals(true) &
          t.status.notEquals('Closed'),
      include: Capa.include(
        qualityEvent: QualityEvent.include(),
        trainingAssignment: TrainingAssignment.include(),
      ),
    );
    return capas.where((c) => c.trainingAssignmentId != null).toList();
  }

  /// Pending QA approvals count (course versions).
  Future<int> getPendingQaApprovalsCount(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0;
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return 0;
    return await CourseVersion.db.count(
      session,
      where: (t) => t.status.equals('pending_approval'),
    );
  }

  /// SOP retraining queue - documents with training_required, employees not retrained.
  Future<List<Map<String, dynamic>>> getSopRetrainingQueue(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final docs = await Document.db.find(
      session,
      where: (t) => t.trainingRequiredByQa.equals('training_required'),
    );
    final result = <Map<String, dynamic>>[];
    for (final doc in docs) {
      result.add({
        'documentId': doc.id,
        'title': doc.title,
        'documentNumber': doc.documentNumber,
      });
    }
    return result;
  }

  /// DLQ failures count (for system alerts).
  Future<int> getDlqFailureCount(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0;
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return 0;
    try {
      final count = await DeadLetterQueue.db.count(
        session,
        where: (t) => t.manuallyResolved.equals(false),
      );
      return count;
    } catch (_) {
      return 0;
    }
  }

  /// ANA-02: Training vs deviation correlation - departments/courses with deviation count vs training completion, CAPA effectiveness rate.
  Future<Map<String, dynamic>> getTrainingVsDeviationCorrelation(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return {'byDepartment': <Map<String, dynamic>>[], 'capaEffectivenessRate': 0.0, 'totalCapas': 0, 'closedCapas': 0};
    }
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    final departments = await Department.db.find(session);
    final deptData = <Map<String, dynamic>>[];
    final allCapas = await Capa.db.find(session);
    final closedCapas = allCapas.where((c) => c.status == 'Closed').length;
    final capaEffectiveness =
        allCapas.isNotEmpty ? closedCapas / allCapas.length : 0.0;

    for (final dept in departments) {
      if (dept.id == null) continue;
      final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
        session,
        departmentId: dept.id!,
      );
      deptData.add({
        'departmentName': dept.name,
        'departmentId': dept.id,
        'complianceRate': metrics.complianceRate,
      });
    }
    return {
      'byDepartment': deptData,
      'capaEffectivenessRate': capaEffectiveness,
      'totalCapas': allCapas.length,
      'closedCapas': closedCapas,
    };
  }

  /// QA-07: Compliance vs deviation overlay - training completion vs deviation count by department.
  Future<Map<String, dynamic>> getComplianceDeviationOverlay(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return {'departmentCompliance': <Map<String, dynamic>>[], 'highRiskDepartments': <Map<String, dynamic>>[], 'totalDeviations': 0};
    }
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    final summary = await getDepartmentComplianceSummary(session);
    final capas = await Capa.db.find(
      session,
      include: Capa.include(qualityEvent: QualityEvent.include()),
    );
    final highRisk = <Map<String, dynamic>>[];
    for (final s in summary) {
      if (s.complianceRate < 0.8) {
        highRisk.add({
          'departmentName': s.departmentName,
          'departmentId': s.departmentId,
          'complianceRate': s.complianceRate,
          'overdue': s.overdue,
        });
      }
    }
    return {
      'departmentCompliance': summary
          .map((s) => {
                'departmentName': s.departmentName,
                'complianceRate': s.complianceRate,
                'overdue': s.overdue,
              })
          .toList(),
      'highRiskDepartments': highRisk,
      'totalDeviations': capas.length,
    };
  }

  /// ANA-03: SLA policy status and breach count.
  Future<Map<String, dynamic>> getSlaSummary(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return {'policyCount': 0, 'totalBreaches': 0, 'openBreachCount': 0};
    }
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    final policies = await SlaPolicy.db.find(session);
    final breaches = await SlaBreach.db.find(session);
    final openBreaches = breaches.where((b) => b.resolvedAt == null).toList();
    return {
      'policyCount': policies.length,
      'totalBreaches': breaches.length,
      'openBreachCount': openBreaches.length,
    };
  }

  /// 12-month compliance trend (FR-12-01 AC-05). Uses current snapshot per month.
  Future<List<Map<String, dynamic>>> getComplianceTrend(
    Session session, {
    int months = 12,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final now = DateTime.now();
    final result = <Map<String, dynamic>>[];
    final summary = await getDepartmentComplianceSummary(session);
    final avgRate = summary.isEmpty
        ? 0.0
        : summary.map((s) => s.complianceRate).reduce((a, b) => a + b) /
            summary.length;
    for (var i = months - 1; i >= 0; i--) {
      var m = now.month - i;
      var y = now.year;
      while (m < 1) {
        m += 12;
        y--;
      }
      result.add({
        'month': '$y-${m.toString().padLeft(2, '0')}',
        'complianceRate': avgRate,
      });
    }
    return result;
  }

  /// SOP retraining velocity - % employees retrained per SOP within 30 days (FR-12-01 AC-04).
  Future<double> getSopRetrainingVelocity(Session session) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0.0;
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return 0.0;
    final enrollments = await Enrollment.db.find(session);
    final withRetraining =
        enrollments.where((e) => e.retrainingChangeSummary != null).toList();
    if (withRetraining.isEmpty) return 1.0;
    final total = await PharmaUser.db.count(session);
    if (total == 0) return 1.0;
    final retrained =
        withRetraining.where((e) => e.acknowledgedAt != null).length;
    return retrained / withRetraining.length;
  }

  /// Real-time analytics stream. Poll-based: yields every 30s with fresh metrics.
  /// Channel: 'compliance', 'dept:{deptId}', 'course:{courseVersionId}', 'audit_readiness'.
  Stream<AnalyticsEvent> streamAnalytics(
    Session session,
    String channel,
  ) async* {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return;
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return;
    const pollInterval = Duration(seconds: 30);
    while (true) {
      try {
        final now = DateTime.now();
        if (channel == 'compliance') {
          final completion = await getTrainingCompletionRate(session);
          final certRisk = await getCertificationExpiryRiskCount(session);
          final breaches = await getOpenSlaBreaches(session);
          yield AnalyticsEvent(
            channel: channel,
            eventType: 'compliance_update',
            payloadJson: jsonEncode({
              'completionRates': completion,
              'certExpiryRiskCount': certRisk,
              'openSlaBreachCount': breaches.length,
            }),
            occurredAt: now,
          );
        } else if (channel.startsWith('dept:')) {
          final deptId = int.tryParse(channel.substring(5));
          if (deptId != null) {
            final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
              session,
              departmentId: deptId,
            );
            final overdue = await getNonCompliantEmployees(session, departmentId: deptId);
            yield AnalyticsEvent(
              channel: channel,
              eventType: 'dept_update',
              payloadJson: jsonEncode({
                'complianceRate': metrics.complianceRate,
                'overdueCount': overdue.length,
              }),
              occurredAt: now,
            );
          }
        } else if (channel.startsWith('course:')) {
          final cvId = int.tryParse(channel.substring(7));
          if (cvId != null) {
            final analytics = await getCourseAnalytics(session, cvId);
            yield AnalyticsEvent(
              channel: channel,
              eventType: 'course_pass_rate',
              payloadJson: jsonEncode({
                'passRate': analytics.passRate,
                'totalAttempts': analytics.totalAttempts,
                'passedCount': analytics.passedCount,
              }),
              occurredAt: now,
            );
          }
        } else if (channel == 'audit_readiness') {
          final readiness = await getAuditReadinessScore(session);
          yield AnalyticsEvent(
            channel: channel,
            eventType: 'audit_readiness',
            payloadJson: jsonEncode({
              'overallScore': readiness.overallScore,
              'complianceScore': readiness.complianceScore,
              'auditTrailActive': readiness.auditTrailActive,
            }),
            occurredAt: now,
          );
        }
      } catch (_) {
        // Yield error event or skip - client will retry on next poll
      }
      await Future<void>.delayed(pollInterval);
    }
  }

  /// Recent activity for employee (last 5 training actions).
  Future<List<Map<String, dynamic>>> getRecentActivity(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'analytics', action: 'read')) return [];
    final trail = await AuditTrail.db.find(
      session,
      where: (t) =>
          t.entityType.inSet({
            'training_record',
            'enrollment',
            'certificate',
            'assessment_attempt',
          }),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: 20,
    );
    final filtered = <Map<String, dynamic>>[];
    for (final t in trail) {
      final newVal = t.newValueJson;
      if (newVal != null && newVal.contains('"userId":$userId')) {
        filtered.add({
          'action': t.action,
          'entityType': t.entityType,
          'timestamp': t.timestamp.toIso8601String(),
        });
        if (filtered.length >= 5) break;
      }
    }
    if (filtered.length < 5) {
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.startedAt,
        orderDescending: true,
        limit: 5,
        include: Enrollment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      );
      for (final e in enrollments) {
        if (filtered.length >= 5) break;
        final ts = e.completedAt ?? e.startedAt;
        filtered.add({
          'action': e.status == 'completed'
              ? 'TrainingCompleted'
              : e.startedAt != null
                  ? 'EnrollmentStarted'
                  : 'EnrollmentCreated',
          'entityType': 'enrollment',
          'timestamp': ts?.toIso8601String() ?? DateTime.now().toIso8601String(),
          'courseTitle': e.courseVersion?.course?.title,
        });
      }
    }
    return filtered;
  }

  /// Get the count of open quality events.
  Future<int> getOpenQualityEventsCount(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    return await QualityEvent.db.count(session, where: (t) => t.status.equals('open'));
  }

  /// Get SLA breaches.
  Future<List<SlaBreach>> getSlaBreaches(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    return await SlaBreach.db.find(session);
  }

  /// Get monthly training hours for a user (last 5 months) for the Dashboard chart.
  Future<List<Map<String, dynamic>>> getMonthlyTrainingHours(
    Session session,
    int userId,
  ) async {
    // 1. Verify authentication (allow demo mode)
    try {
      final user = await RbacHelper.getCurrentPharmaUser(session);
      if (user == null) {
        // Demo mode fallback - still allow the query
      }
    } catch (_) {
      // Demo mode - continue
    }

    // 2. Fetch all material progress for the user where time has been spent
    final progresses = await MaterialProgress.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.timeSpentSeconds.notEquals(null),
    );

    final now = DateTime.now();
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final monthlyHours = <String, double>{};
    
    // 3. Initialize the last 5 months with 0.0 hours so the chart always has x-axis labels
    for (var i = 4; i >= 0; i--) {
      final d = DateTime(now.year, now.month - i);
      final monthKey = monthNames[d.month - 1];
      monthlyHours[monthKey] = 0.0;
    }

    // 4. Aggregate the timeSpentSeconds into the correct month bucket
    for (final p in progresses) {
      final date = p.completedAt ?? p.lastHeartbeat ?? now;
      final monthKey = monthNames[date.month - 1];
      
      if (monthlyHours.containsKey(monthKey)) {
        // Convert seconds to hours
        final hours = (p.timeSpentSeconds ?? 0) / 3600.0;
        monthlyHours[monthKey] = (monthlyHours[monthKey]!) + hours;
      }
    }

    // 5. Return as a list of maps for easy consumption by fl_chart in Flutter
    return monthlyHours.entries
        .map((e) => {'month': e.key, 'hours': e.value})
        .toList();
  }

  /// Get weekly learning progress for a user (last 6 weeks) for the Dashboard area chart.
  Future<List<Map<String, dynamic>>> getWeeklyLearningProgress(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    // Fetch enrollments for the user
    final enrollments = await Enrollment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final now = DateTime.now();
    final weeklyProgress = <String, int>{};
    
    // Initialize last 6 weeks
    for (var i = 5; i >= 0; i--) {
      // weekStart calculation available for future date range filtering
      final weekKey = 'Week ${6 - i}';
      weeklyProgress[weekKey] = 0;
    }

    // Count completions per week
    for (final e in enrollments) {
      if (e.completedAt != null) {
        final weeksAgo = now.difference(e.completedAt!).inDays ~/ 7;
        if (weeksAgo >= 0 && weeksAgo < 6) {
          final weekKey = 'Week ${6 - weeksAgo}';
          weeklyProgress[weekKey] = (weeklyProgress[weekKey] ?? 0) + 1;
        }
      }
    }

    // Convert to cumulative progress
    var cumulative = 0;
    final result = <Map<String, dynamic>>[];
    for (final entry in weeklyProgress.entries) {
      cumulative += entry.value;
      result.add({
        'week': entry.key,
        'completed': cumulative,
        'total': enrollments.length,
      });
    }

    return result;
  }

  /// Get user's average quiz score from all completed assessments.
  Future<double> getUserAverageQuizScore(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    final attempts = await AssessmentAttempt.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.completedAt.notEquals(null),
    );

    if (attempts.isEmpty) return 0.0;

    final totalScore = attempts.fold<int>(0, (sum, a) => sum + (a.score ?? 0));
    return totalScore / attempts.length;
  }

  /// Get user's learning streak (consecutive days of activity).
  Future<int> getUserLearningStreak(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    // Get material progress with activity
    final progresses = await MaterialProgress.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.lastHeartbeat,
      orderDescending: true,
    );

    if (progresses.isEmpty) return 0;

    // Calculate streak
    var streak = 0;
    var lastDate = DateTime.now();
    
    for (final p in progresses) {
      final activityDate = p.lastHeartbeat ?? p.completedAt;
      if (activityDate == null) continue;
      
      final dayDiff = lastDate.difference(activityDate).inDays;
      if (dayDiff <= 1) {
        streak++;
        lastDate = activityDate;
      } else {
        break;
      }
    }

    return streak;
  }

  /// Get upcoming due dates for a user's training assignments.
  Future<List<Map<String, dynamic>>> getUpcomingDueDates(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    final now = DateTime.now();
    final thirtyDaysOut = now.add(const Duration(days: 30));

    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => 
          t.userId.equals(userId) & 
          (t.dueDate < thirtyDaysOut) &
          t.status.notEquals('completed') &
          t.status.notEquals('cancelled'),
      include: TrainingAssignment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
      orderBy: (t) => t.dueDate,
    );

    return assignments.map((a) {
      final daysUntilDue = a.dueDate.difference(now).inDays;
      return {
        'assignmentId': a.id,
        'courseTitle': a.courseVersion?.course?.title ?? 'Unknown Course',
        'dueDate': a.dueDate.toIso8601String(),
        'daysUntilDue': daysUntilDue,
        'priority': a.priority,
        'isOverdue': daysUntilDue < 0,
      };
    }).toList();
  }

  /// Get compliance alerts for a user (SOP retraining, overdue, expiring certs).
  Future<List<Map<String, dynamic>>> getComplianceAlerts(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    final alerts = <Map<String, dynamic>>[];
    final now = DateTime.now();

    // 1. SOP Retraining alerts (enrollments with retrainingChangeSummary not acknowledged)
    final retrainingEnrollments = await Enrollment.db.find(
      session,
      where: (t) => 
          t.userId.equals(userId) & 
          t.retrainingChangeSummary.notEquals(null) &
          t.acknowledgedAt.equals(null),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );

    for (final e in retrainingEnrollments) {
      alerts.add({
        'type': 'sop_retraining',
        'severity': 'high',
        'title': 'SOP Retraining Required',
        'message': 'Document update requires re-acknowledgement for ${e.courseVersion?.course?.title ?? "a course"}',
        'entityId': e.id,
        'entityType': 'enrollment',
      });
    }

    // 2. Overdue training alerts
    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => 
          t.userId.equals(userId) & 
          (t.dueDate < now) &
          t.status.notEquals('completed') &
          t.status.notEquals('cancelled'),
      include: TrainingAssignment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );

    for (final a in assignments) {
      final daysOverdue = now.difference(a.dueDate).inDays;
      alerts.add({
        'type': 'overdue',
        'severity': daysOverdue > 7 ? 'critical' : 'high',
        'title': 'Overdue Training',
        'message': '${a.courseVersion?.course?.title ?? "Training"} is $daysOverdue days overdue',
        'entityId': a.id,
        'entityType': 'assignment',
        'daysOverdue': daysOverdue,
      });
    }

    // 3. Expiring certificates (within 30 days)
    final thirtyDaysOut = now.add(const Duration(days: 30));
    final certificates = await Certificate.db.find(
      session,
      where: (t) => 
          t.userId.equals(userId) & 
          t.status.equals('active'),
      include: Certificate.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );

    for (final c in certificates) {
      if (c.expiresAt != null && c.expiresAt!.isAfter(now) && c.expiresAt!.isBefore(thirtyDaysOut)) {
        final daysUntilExpiry = c.expiresAt!.difference(now).inDays;
        alerts.add({
          'type': 'cert_expiring',
          'severity': daysUntilExpiry < 7 ? 'high' : 'medium',
          'title': 'Certificate Expiring',
          'message': '${c.courseVersion?.course?.title ?? "Certificate"} expires in $daysUntilExpiry days',
          'entityId': c.id,
          'entityType': 'certificate',
          'daysUntilExpiry': daysUntilExpiry,
        });
      }
    }

    // Sort by severity
    alerts.sort((a, b) {
      const severityOrder = {'critical': 0, 'high': 1, 'medium': 2, 'low': 3};
      return (severityOrder[a['severity']] ?? 3).compareTo(severityOrder[b['severity']] ?? 3);
    });

    return alerts;
  }

  /// Export course analytics as CSV.
  Future<String> exportCourseAnalyticsCsv(
    Session session, {
    required int courseVersionId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    
    final records = await TrainingRecord.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: TrainingRecord.include(
        user: PharmaUser.include(),
      ),
    );
    
    final buffer = StringBuffer();
    buffer.writeln('User Email,User Name,Score,Passed,Completed At');
    
    final assessment = await Assessment.db.findFirstRow(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
    );
    final passingScore = assessment?.passingScore ?? 80;
    
    for (final r in records) {
      final email = r.user?.email ?? '';
      final userName = '${r.user?.firstName ?? ''} ${r.user?.lastName ?? ''}'.trim();
      final score = r.score ?? 0;
      final passed = score >= passingScore ? 'Yes' : 'No';
      final completedAt = r.completedAt.toIso8601String() ?? '';
      buffer.writeln('$email,$userName,$score,$passed,$completedAt');
    }
    
    return buffer.toString();
  }

  /// Export learner progress as CSV.
  Future<String> exportLearnerProgressCsv(
    Session session, {
    int? organizationId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'analytics', action: 'read');
    
    final enrollments = await Enrollment.db.find(
      session,
      include: Enrollment.include(
        user: PharmaUser.include(department: Department.include()),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    
    final buffer = StringBuffer();
    buffer.writeln('Employee,Email,Department,Course,Version,Status,Started,Completed');
    
    for (final e in enrollments) {
      final userName = '${e.user?.firstName ?? ''} ${e.user?.lastName ?? ''}'.trim();
      final email = e.user?.email ?? '';
      final dept = e.user?.department?.name ?? '';
      final course = e.courseVersion?.course?.title ?? '';
      final version = e.courseVersion?.version ?? '';
      final status = e.status;
      final started = e.startedAt?.toIso8601String() ?? '';
      final completed = e.completedAt?.toIso8601String() ?? '';
      buffer.writeln('$userName,$email,$dept,$course,$version,$status,$started,$completed');
    }
    
    return buffer.toString();
  }

  /// Get employee dashboard summary (combines multiple data sources for efficiency).
  Future<Map<String, dynamic>> getEmployeeDashboardSummary(
    Session session,
    int userId,
  ) async {
    try {
      await RbacHelper.getCurrentPharmaUser(session);
    } catch (_) {
      // Demo mode - continue
    }

    // Fetch all data in parallel for performance
    final enrollmentsFuture = Enrollment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    
    final assignmentsFuture = TrainingAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    
    final certificatesFuture = Certificate.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    
    final attemptsFuture = AssessmentAttempt.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.completedAt.notEquals(null),
    );
    
    final monthlyHoursFuture = getMonthlyTrainingHours(session, userId);
    final alertsFuture = getComplianceAlerts(session, userId);

    // Wait for all futures
    final results = await Future.wait([
      enrollmentsFuture,
      assignmentsFuture,
      certificatesFuture,
      attemptsFuture,
      monthlyHoursFuture,
      alertsFuture,
    ]);

    final enrollments = results[0] as List<Enrollment>;
    final assignments = results[1] as List<TrainingAssignment>;
    final certificates = results[2] as List<Certificate>;
    final attempts = results[3] as List<AssessmentAttempt>;
    final monthlyHours = results[4] as List<Map<String, dynamic>>;
    final alerts = results[5] as List<Map<String, dynamic>>;

    // Calculate metrics
    final inProgress = enrollments.where((e) => e.status == 'in_progress').length;
    final completed = enrollments.where((e) => e.status == 'completed').length;
    final toDo = enrollments.where((e) => e.status == 'assigned' || e.status == 'not_started').length;
    
    final avgScore = attempts.isEmpty 
        ? 0.0 
        : attempts.fold<int>(0, (sum, a) => sum + (a.score ?? 0)) / attempts.length;

    final totalHours = monthlyHours.fold<double>(0.0, (sum, m) => sum + ((m['hours'] as num?)?.toDouble() ?? 0.0));

    final now = DateTime.now();
    final overdueCount = assignments.where((a) => 
        a.dueDate.isBefore(now) && 
        a.status != 'completed' && 
        a.status != 'cancelled'
    ).length;

    final activeCerts = certificates.where((c) => c.status == 'active').length;

    return {
      'totalEnrolled': inProgress + toDo,
      'inProgress': inProgress,
      'completed': completed,
      'toDo': toDo,
      'averageQuizScore': avgScore,
      'totalHoursThisYear': totalHours,
      'overdueCount': overdueCount,
      'activeCertificates': activeCerts,
      'monthlyHours': monthlyHours,
      'alerts': alerts,
      'alertCount': alerts.length,
    };
  }
}
