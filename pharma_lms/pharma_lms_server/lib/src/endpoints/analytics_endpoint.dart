import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/analytics/course_analytics.dart';
import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';

/// Analytics & Reporting domain endpoint.
class AnalyticsEndpoint extends Endpoint {
  /// Course analytics - pass rate and score distribution from TrainingRecord.
  Future<CourseAnalytics> getCourseAnalytics(
    Session session,
    int courseVersionId,
  ) async {
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
      if (score <= 20) buckets['0-20'] = buckets['0-20']! + 1;
      else if (score <= 40) buckets['21-40'] = buckets['21-40']! + 1;
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
      'recentJobs': jobLogs
          .map((j) => {
                'jobName': j.jobName,
                'startedAt': j.startedAt.toIso8601String(),
                'status': j.status,
              })
          .toList(),
    };
  }

  /// Department compliance summary.
  Future<List<DepartmentComplianceSummary>> getDepartmentComplianceSummary(
    Session session,
  ) async {
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
    return await ReportDefinition.db.find(session);
  }

  Future<List<Dashboard>> listDashboards(
    Session session, {
    int? roleId,
  }) async {
    var results = await Dashboard.db.find(session);
    if (roleId != null) {
      results = results.where((d) => d.roleId == roleId).toList();
    }
    return results;
  }

  Future<List<SlaBreach>> getOpenSlaBreaches(Session session) async {
    final breaches = await SlaBreach.db.find(session);
    return breaches.where((b) => b.resolvedAt == null).toList();
  }

  /// Non-compliant employees (overdue training).
  Future<List<PharmaUser>> getNonCompliantEmployees(
    Session session, {
    int? departmentId,
  }) async {
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
    return await CourseVersion.db.count(
      session,
      where: (t) => t.status.equals('pending_approval'),
    );
  }

  /// SOP retraining queue - documents with training_required, employees not retrained.
  Future<List<Map<String, dynamic>>> getSopRetrainingQueue(
    Session session,
  ) async {
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
    final policies = await SlaPolicy.db.find(session);
    final breaches = await SlaBreach.db.find(session);
    final openBreaches = breaches.where((b) => b.resolvedAt == null).toList();
    return {
      'policyCount': policies.length,
      'totalBreaches': breaches.length,
      'openBreachCount': openBreaches.length,
    };
  }

  /// Recent activity for employee (last 5 training actions).
  Future<List<Map<String, dynamic>>> getRecentActivity(
    Session session,
    int userId,
  ) async {
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
        filtered.add({
          'action': e.status == 'completed'
              ? 'TrainingCompleted'
              : e.startedAt != null
                  ? 'EnrollmentStarted'
                  : 'EnrollmentCreated',
          'entityType': 'enrollment',
          'timestamp': (e.completedAt ?? e.startedAt ?? e.id ?? 0).toString(),
          'courseTitle': e.courseVersion?.course?.title,
        });
      }
    }
    return filtered;
  }
}
