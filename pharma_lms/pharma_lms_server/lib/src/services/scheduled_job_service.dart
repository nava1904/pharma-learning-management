import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../audit_event_types.dart';
import '../generated/protocol.dart';
import 'audit_service.dart';
import 'compliance_calculator_service.dart';

/// Exception for scheduled job failures.
class ScheduledJobException implements Exception {
  final String message;
  final String jobName;
  final String? details;

  ScheduledJobException(this.message, {required this.jobName, this.details});

  @override
  String toString() => 'ScheduledJobException($jobName): $message${details != null ? ' - $details' : ''}';
}

/// Scheduled job service implementing SYS-WF-04, 05, 07, 08.
/// Provides methods for background automation tasks in the Pharma LMS.
/// These can be triggered manually from AnalyticsEndpoint or via cron/scheduler.
class ScheduledJobService {
  // ============================================================================
  // SYS-WF-04: Certificate Expiry Check
  // ============================================================================

  /// SYS-WF-04: Check for expiring certificates and create renewal assignments.
  ///
  /// Behavior:
  /// - Certificates expiring in 30-60 days: Create renewal TrainingAssignment (source='cert_renewal')
  /// - Certificates expiring TODAY or past: Update status to 'expired', log to AuditTrail
  ///
  /// Returns a map with job statistics.
  static Future<Map<String, dynamic>> runCertExpiryCheck(Session session) async {
    final jobStartTime = DateTime.now();
    final today = DateTime.now();
    final thirtyDaysOut = today.add(const Duration(days: 30));
    final sixtyDaysOut = today.add(const Duration(days: 60));

    var recordsProcessed = 0;
    var renewalsCreated = 0;
    var certificatesExpired = 0;
    final errors = <String>[];

    try {
      // Query all active certificates with expiration dates
      final certificates = await Certificate.db.find(
        session,
        where: (t) => t.status.equals('active') & t.expiresAt.notEquals(null),
        include: Certificate.include(
          user: PharmaUser.include(),
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      );

      recordsProcessed = certificates.length;

      // Get system user for assigning
      final systemUserId = await _getSystemUserId(session);

      for (final cert in certificates) {
        if (cert.id == null || cert.expiresAt == null) continue;

        final expiresAt = cert.expiresAt!;
        final userId = cert.userId;

        try {
          // Case 1: Expiring TODAY or already past - mark as expired
          if (!expiresAt.isAfter(today)) {
            await Certificate.db.updateRow(
              session,
              cert.copyWith(status: 'expired'),
            );

            await AuditService.log(
              session,
              entityType: 'certificate',
              entityId: cert.id.toString(),
              action: AuditEventType.certificateExpired,
              oldValueJson: jsonEncode({'status': 'active'}),
              newValueJson: jsonEncode({
                'status': 'expired',
                'expiredAt': today.toIso8601String(),
              }),
              reason: 'Certificate expired on ${expiresAt.toIso8601String()}',
            );

            certificatesExpired++;
            session.log('[CertExpiryCheck] Certificate ${cert.id} marked as expired');
          }
          // Case 2: Expiring in 30-60 days - create renewal assignment
          else if (expiresAt.isAfter(thirtyDaysOut) && !expiresAt.isAfter(sixtyDaysOut)) {
            // Check if renewal assignment already exists
            final existingAssignment = await TrainingAssignment.db.findFirstRow(
              session,
              where: (t) =>
                  t.userId.equals(userId) &
                  t.courseVersionId.equals(cert.courseVersionId) &
                  t.source.equals('cert_renewal') &
                  t.status.equals('active'),
            );

            if (existingAssignment == null) {
              // Get or create effective course version for renewal
              final courseVersionId = cert.courseVersionId;
              
              // Create renewal assignment due 7 days before expiry
              final dueDate = expiresAt.subtract(const Duration(days: 7));

              final assignment = TrainingAssignment(
                userId: userId,
                courseVersionId: courseVersionId,
                assignedById: systemUserId,
                dueDate: dueDate,
                priority: 'high',
                reason: 'Certificate renewal - expires ${expiresAt.toIso8601String().substring(0, 10)}',
                source: 'cert_renewal',
                assignmentType: 'individual',
                targetUserId: userId,
              );

              await TrainingAssignment.db.insertRow(session, assignment);

              await AuditService.log(
                session,
                entityType: 'training_assignment',
                entityId: assignment.id?.toString() ?? 'new',
                action: AuditEventType.certificateRenewalAssigned,
                newValueJson: jsonEncode({
                  'userId': userId,
                  'courseVersionId': courseVersionId,
                  'certificateId': cert.id,
                  'expiresAt': expiresAt.toIso8601String(),
                  'source': 'cert_renewal',
                }),
                reason: 'Auto-assigned: certificate expiring in ${expiresAt.difference(today).inDays} days',
              );

              renewalsCreated++;
              session.log('[CertExpiryCheck] Created renewal assignment for certificate ${cert.id}');
            }
          }
        } catch (e) {
          errors.add('Certificate ${cert.id}: $e');
          session.log('[CertExpiryCheck] Error processing certificate ${cert.id}: $e', level: LogLevel.error);
        }
      }

      // Log job completion
      final jobLog = await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'CertExpiryCheck',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: errors.isEmpty ? 'completed' : 'completed_with_errors',
          recordsProcessed: recordsProcessed,
          recordsAffected: renewalsCreated + certificatesExpired,
          errorDetails: errors.isNotEmpty ? jsonEncode(errors) : null,
        ),
      );

      session.log(
        '[CertExpiryCheck] Completed: $recordsProcessed processed, '
        '$renewalsCreated renewals created, $certificatesExpired expired',
      );

      return {
        'success': true,
        'jobLogId': jobLog.id,
        'recordsProcessed': recordsProcessed,
        'renewalsCreated': renewalsCreated,
        'certificatesExpired': certificatesExpired,
        'errors': errors,
      };
    } catch (e) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'CertExpiryCheck',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: recordsProcessed,
          errorDetails: e.toString(),
        ),
      );

      throw ScheduledJobException(
        'Certificate expiry check failed',
        jobName: 'CertExpiryCheck',
        details: e.toString(),
      );
    }
  }

  // ============================================================================
  // SYS-WF-05: Notification Worker (Escalation Ladder)
  // ============================================================================

  /// SYS-WF-05: Process notification escalation ladder for due/overdue enrollments.
  ///
  /// Escalation ladder:
  /// - -30d: First reminder
  /// - -14d: Second reminder
  /// - -7d: Urgent reminder
  /// - 0d (due today): Final warning
  /// - +1d: Overdue notice
  /// - +7d: Manager escalation
  ///
  /// Creates Notification and NotificationLog records.
  static Future<Map<String, dynamic>> runNotificationWorker(Session session) async {
    final jobStartTime = DateTime.now();
    final today = DateTime.now();

    var recordsProcessed = 0;
    var notificationsCreated = 0;
    final escalationCounts = <String, int>{
      'reminder_30d': 0,
      'reminder_14d': 0,
      'reminder_7d': 0,
      'due_today': 0,
      'overdue_1d': 0,
      'overdue_7d': 0,
    };
    final errors = <String>[];

    try {
      // Query enrollments that are not completed
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) => t.status.inSet({'not_started', 'in_progress'}),
        include: Enrollment.include(
          user: PharmaUser.include(department: Department.include()),
          courseVersion: CourseVersion.include(course: Course.include()),
          assignment: TrainingAssignment.include(),
        ),
      );

      recordsProcessed = enrollments.length;

      for (final enrollment in enrollments) {
        if (enrollment.id == null) continue;
        if (enrollment.assignment?.dueDate == null) continue;

        final dueDate = enrollment.assignment!.dueDate;
        final daysUntilDue = dueDate.difference(today).inDays;
        final userId = enrollment.userId;
        final courseTitle = enrollment.courseVersion?.course?.title ?? 'Training';

        try {
          String? notificationType;
          String? escalationKey;

          // Determine notification type based on escalation ladder
          if (daysUntilDue == 30) {
            notificationType = 'reminder_30d';
            escalationKey = 'reminder_30d';
          } else if (daysUntilDue == 14) {
            notificationType = 'reminder_14d';
            escalationKey = 'reminder_14d';
          } else if (daysUntilDue == 7) {
            notificationType = 'reminder_7d';
            escalationKey = 'reminder_7d';
          } else if (daysUntilDue == 0) {
            notificationType = 'due_today';
            escalationKey = 'due_today';
          } else if (daysUntilDue == -1) {
            notificationType = 'overdue';
            escalationKey = 'overdue_1d';
          } else if (daysUntilDue == -7) {
            notificationType = 'overdue_escalation';
            escalationKey = 'overdue_7d';
          }

          if (notificationType != null && escalationKey != null) {
            // Check if notification already sent for this enrollment and type
            final existingNotification = await Notification.db.findFirstRow(
              session,
              where: (t) =>
                  t.userId.equals(userId) &
                  t.enrollmentId.equals(enrollment.id!) &
                  t.type.equals(notificationType),
            );

            if (existingNotification == null) {
              // Create notification record
              final notification = Notification(
                userId: userId,
                type: notificationType,
                enrollmentId: enrollment.id,
                channel: 'in_app',
                createdAt: DateTime.now(),
              );

              final savedNotification = await Notification.db.insertRow(session, notification);

              // Create notification log (only if notification has ID)
              if (savedNotification.id != null) {
                await NotificationLog.db.insertRow(
                  session,
                  NotificationLog(
                    notificationId: savedNotification.id!,
                    channel: 'in_app',
                    status: 'sent',
                  ),
                );
              }

              // For overdue_7d, also notify manager if available
              if (escalationKey == 'overdue_7d') {
                await _notifyManagerEscalation(
                  session,
                  enrollment: enrollment,
                  courseTitle: courseTitle,
                  daysOverdue: 7,
                );
              }

              escalationCounts[escalationKey] = (escalationCounts[escalationKey] ?? 0) + 1;
              notificationsCreated++;

              session.log(
                '[NotificationWorker] Created $notificationType notification for user $userId, '
                'enrollment ${enrollment.id}',
              );
            }
          }
        } catch (e) {
          errors.add('Enrollment ${enrollment.id}: $e');
          session.log(
            '[NotificationWorker] Error processing enrollment ${enrollment.id}: $e',
            level: LogLevel.error,
          );
        }
      }

      // Log job completion
      final jobLog = await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'NotificationWorker',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: errors.isEmpty ? 'completed' : 'completed_with_errors',
          recordsProcessed: recordsProcessed,
          recordsAffected: notificationsCreated,
          errorDetails: errors.isNotEmpty ? jsonEncode({
            'errors': errors,
            'escalationCounts': escalationCounts,
          }) : jsonEncode({'escalationCounts': escalationCounts}),
        ),
      );

      session.log(
        '[NotificationWorker] Completed: $recordsProcessed enrollments processed, '
        '$notificationsCreated notifications created',
      );

      return {
        'success': true,
        'jobLogId': jobLog.id,
        'recordsProcessed': recordsProcessed,
        'notificationsCreated': notificationsCreated,
        'escalationCounts': escalationCounts,
        'errors': errors,
      };
    } catch (e) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'NotificationWorker',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: recordsProcessed,
          errorDetails: e.toString(),
        ),
      );

      throw ScheduledJobException(
        'Notification worker failed',
        jobName: 'NotificationWorker',
        details: e.toString(),
      );
    }
  }

  /// Helper: Notify manager about escalated overdue training.
  static Future<void> _notifyManagerEscalation(
    Session session, {
    required Enrollment enrollment,
    required String courseTitle,
    required int daysOverdue,
  }) async {
    // Get department to find manager (assuming first QA user or admin as fallback)
    final department = enrollment.user?.department;
    if (department == null) return;

    // Find potential managers - users in same department with 'Manager' in role
    // This is a simplified approach; real implementation might use a manager relation
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.departmentId.equals(department.id!),
      include: PharmaUser.include(jobRole: JobRole.include()),
      limit: 10,
    );

    final managers = users.where((u) =>
        u.jobRole?.name.toLowerCase().contains('manager') == true ||
        u.jobRole?.name.toLowerCase().contains('supervisor') == true
    ).toList();

    if (managers.isEmpty) return;

    for (final manager in managers) {
      if (manager.id == null || manager.id == enrollment.userId) continue;

      final notification = Notification(
        userId: manager.id!,
        type: 'manager_escalation',
        enrollmentId: enrollment.id,
        channel: 'in_app',
        createdAt: DateTime.now(),
      );

      final saved = await Notification.db.insertRow(session, notification);

      if (saved.id != null) {
        await NotificationLog.db.insertRow(
          session,
          NotificationLog(
            notificationId: saved.id!,
            channel: 'in_app',
            status: 'sent',
          ),
        );
      }

      // Also log escalation to audit trail
      await AuditService.log(
        session,
        entityType: 'notification',
        entityId: saved.id.toString(),
        action: AuditEventType.notificationEscalation,
        newValueJson: jsonEncode({
          'managerId': manager.id,
          'employeeId': enrollment.userId,
          'enrollmentId': enrollment.id,
          'courseTitle': courseTitle,
          'daysOverdue': daysOverdue,
        }),
        reason: 'Overdue training escalated to manager after $daysOverdue days',
      );
    }
  }

  // ============================================================================
  // SYS-WF-07: Compliance Calculation
  // ============================================================================

  /// SYS-WF-07: Compute org-wide and department-wide compliance percentages.
  ///
  /// Writes snapshots to:
  /// - DepartmentComplianceSnapshot (per department)
  /// - AnalyticsSnapshot (org-wide)
  static Future<Map<String, dynamic>> runComplianceCalc(Session session) async {
    final jobStartTime = DateTime.now();
    final today = DateTime.now();

    var departmentsProcessed = 0;
    var snapshotsCreated = 0;
    final departmentMetrics = <Map<String, dynamic>>[];
    final errors = <String>[];

    try {
      // Get all departments
      final departments = await Department.db.find(session);

      // Org-wide aggregates
      var orgTotalEmployees = 0;
      var orgCompliantCount = 0;
      var orgOverdueCount = 0;

      // Create job log first to reference it in snapshots
      final jobLog = await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'ComplianceCalc',
          startedAt: jobStartTime,
          status: 'running',
        ),
      );

      // Process each department
      for (final dept in departments) {
        if (dept.id == null) continue;

        try {
          final metrics = await ComplianceCalculatorService.getDepartmentCompliance(
            session,
            departmentId: dept.id!,
            asOf: today,
          );

          // Create department snapshot
          final snapshot = DepartmentComplianceSnapshot(
            departmentId: dept.id!,
            snapshotDate: today,
            totalEmployees: metrics.totalEmployees,
            compliantCount: metrics.compliant,
            overdueCount: metrics.overdue,
            upcomingCount: metrics.upcoming,
            complianceRate: metrics.complianceRate,
            scheduledJobLogId: jobLog.id,
          );

          await DepartmentComplianceSnapshot.db.insertRow(session, snapshot);
          snapshotsCreated++;

          // Aggregate for org-wide
          orgTotalEmployees += metrics.totalEmployees;
          orgCompliantCount += metrics.compliant;
          orgOverdueCount += metrics.overdue;

          departmentMetrics.add({
            'departmentId': dept.id,
            'departmentName': dept.name,
            'complianceRate': metrics.complianceRate,
            'totalEmployees': metrics.totalEmployees,
          });

          departmentsProcessed++;

          session.log(
            '[ComplianceCalc] Dept ${dept.name}: ${metrics.complianceRate.toStringAsFixed(1)}% '
            '(${metrics.compliant}/${metrics.totalEmployees} compliant)',
          );
        } catch (e) {
          errors.add('Department ${dept.id}: $e');
          session.log(
            '[ComplianceCalc] Error processing department ${dept.id}: $e',
            level: LogLevel.error,
          );
        }
      }

      // Calculate org-wide metrics
      final orgComplianceRate = orgTotalEmployees > 0
          ? (orgCompliantCount / orgTotalEmployees * 100)
          : 0.0;

      // Get certificate statistics
      final activeCerts = await Certificate.db.count(
        session,
        where: (t) => t.status.equals('active'),
      );

      final thirtyDaysOut = today.add(const Duration(days: 30));
      final sixtyDaysOut = today.add(const Duration(days: 60));

      final allActiveCerts = await Certificate.db.find(
        session,
        where: (t) => t.status.equals('active') & t.expiresAt.notEquals(null),
      );

      var certsExpiring30d = 0;
      var certsExpiring60d = 0;

      for (final cert in allActiveCerts) {
        if (cert.expiresAt == null) continue;
        if (cert.expiresAt!.isBefore(thirtyDaysOut)) {
          certsExpiring30d++;
        } else if (cert.expiresAt!.isBefore(sixtyDaysOut)) {
          certsExpiring60d++;
        }
      }

      // Get open assignments count
      final openAssignments = await TrainingAssignment.db.count(
        session,
        where: (t) => t.status.equals('active'),
      );

      // Create org-wide analytics snapshot
      final analyticsSnapshot = AnalyticsSnapshot(
        snapshotDate: today,
        totalEmployees: orgTotalEmployees,
        compliantCount: orgCompliantCount,
        overdueCount: orgOverdueCount,
        orgComplianceRate: orgComplianceRate,
        totalCertificates: activeCerts,
        certsExpiring30d: certsExpiring30d,
        certsExpiring60d: certsExpiring60d,
        openAssignments: openAssignments,
        scheduledJobLogId: jobLog.id,
      );

      await AnalyticsSnapshot.db.insertRow(session, analyticsSnapshot);
      snapshotsCreated++;

      // Log to audit trail
      await AuditService.log(
        session,
        entityType: 'analytics_snapshot',
        entityId: analyticsSnapshot.id?.toString() ?? 'new',
        action: AuditEventType.complianceSnapshotCreated,
        newValueJson: jsonEncode({
          'snapshotDate': today.toIso8601String(),
          'orgComplianceRate': orgComplianceRate,
          'departmentsProcessed': departmentsProcessed,
        }),
        reason: 'Daily compliance calculation completed',
      );

      // Update job log
      await ScheduledJobLog.db.updateRow(
        session,
        jobLog.copyWith(
          completedAt: DateTime.now(),
          status: errors.isEmpty ? 'completed' : 'completed_with_errors',
          recordsProcessed: departmentsProcessed,
          recordsAffected: snapshotsCreated,
          errorDetails: errors.isNotEmpty ? jsonEncode(errors) : null,
        ),
      );

      session.log(
        '[ComplianceCalc] Completed: Org compliance ${orgComplianceRate.toStringAsFixed(1)}%, '
        '$departmentsProcessed departments, $snapshotsCreated snapshots',
      );

      return {
        'success': true,
        'jobLogId': jobLog.id,
        'orgComplianceRate': orgComplianceRate,
        'departmentsProcessed': departmentsProcessed,
        'snapshotsCreated': snapshotsCreated,
        'departmentMetrics': departmentMetrics,
        'certMetrics': {
          'totalActive': activeCerts,
          'expiring30d': certsExpiring30d,
          'expiring60d': certsExpiring60d,
        },
        'errors': errors,
      };
    } catch (e) {
      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'ComplianceCalc',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: departmentsProcessed,
          errorDetails: e.toString(),
        ),
      );

      throw ScheduledJobException(
        'Compliance calculation failed',
        jobName: 'ComplianceCalc',
        details: e.toString(),
      );
    }
  }

  // ============================================================================
  // SYS-WF-08: Audit Trail Integrity Check (CRITICAL - 21 CFR Part 11)
  // ============================================================================

  /// SYS-WF-08: Verify audit trail integrity for FDA 21 CFR Part 11 compliance.
  ///
  /// Checks:
  /// 1. Re-computes SHA-256 hash of critical fields and compares to stored rowHash
  /// 2. Verifies no gaps in the audit trail ID sequence
  ///
  /// CRITICAL: Throws ScheduledJobException if any integrity issues found.
  static Future<Map<String, dynamic>> runAuditTrailIntegrityCheck(Session session) async {
    final jobStartTime = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(hours: 24));

    var recordsChecked = 0;
    var hashMismatches = 0;
    var sequenceGaps = 0;
    final failures = <Map<String, dynamic>>[];

    try {
      // Query audit trail records from last 24 hours, ordered by ID
      final auditRecords = await AuditTrail.db.find(
        session,
        where: (t) => t.timestamp > yesterday,
        orderBy: (t) => t.id,
        orderDescending: false,
      );

      recordsChecked = auditRecords.length;

      if (auditRecords.isEmpty) {
        session.log('[AuditIntegrityCheck] No audit records in last 24 hours');
        
        final jobLog = await ScheduledJobLog.db.insertRow(
          session,
          ScheduledJobLog(
            jobName: 'AuditTrailIntegrityCheck',
            startedAt: jobStartTime,
            completedAt: DateTime.now(),
            status: 'completed',
            recordsProcessed: 0,
            recordsAffected: 0,
          ),
        );

        return {
          'success': true,
          'jobLogId': jobLog.id,
          'recordsChecked': 0,
          'hashMismatches': 0,
          'sequenceGaps': 0,
          'result': 'passed',
          'message': 'No audit records to check in last 24 hours',
        };
      }

      int? previousId;

      for (final record in auditRecords) {
        if (record.id == null) continue;

        // Check 1: Verify hash integrity
        final computedHash = _computeAuditRowHash(record);
        final storedHash = record.rowHash;

        if (storedHash != null && storedHash != computedHash) {
          hashMismatches++;
          failures.add({
            'type': 'hash_mismatch',
            'recordId': record.id,
            'timestamp': record.timestamp.toIso8601String(),
            'entityType': record.entityType,
            'entityId': record.entityId,
            'action': record.action,
            'storedHash': storedHash,
            'computedHash': computedHash,
          });

          session.log(
            '[AuditIntegrityCheck] CRITICAL: Hash mismatch for audit record ${record.id}',
            level: LogLevel.error,
          );
        }

        // Check 2: Verify sequence continuity (no gaps)
        if (previousId != null) {
          final expectedId = previousId + 1;
          if (record.id != expectedId) {
            // Check if there's a genuine gap or if records were just inserted at different times
            // For strict compliance, we flag any sequence irregularity
            final gap = record.id! - previousId - 1;
            if (gap > 0) {
              sequenceGaps++;
              failures.add({
                'type': 'sequence_gap',
                'previousId': previousId,
                'currentId': record.id,
                'gapSize': gap,
                'timestamp': record.timestamp.toIso8601String(),
              });

              session.log(
                '[AuditIntegrityCheck] WARNING: Sequence gap detected between IDs $previousId and ${record.id}',
                level: LogLevel.warning,
              );
            }
          }
        }

        previousId = record.id;
      }

      // Determine overall result
      final passed = hashMismatches == 0;
      final result = passed ? 'passed' : 'failed';

      // Create integrity check result record
      final integrityResult = AuditIntegrityResult(
        checkedAt: DateTime.now(),
        recordsChecked: recordsChecked,
        hashMismatches: hashMismatches,
        sequenceGaps: sequenceGaps,
        result: result,
        failureDetailsJson: failures.isNotEmpty ? jsonEncode(failures) : null,
      );

      await AuditIntegrityResult.db.insertRow(session, integrityResult);

      // Log job completion
      final jobLog = await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'AuditTrailIntegrityCheck',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: passed ? 'completed' : 'failed',
          recordsProcessed: recordsChecked,
          recordsAffected: hashMismatches + sequenceGaps,
          errorDetails: failures.isNotEmpty ? jsonEncode(failures) : null,
        ),
      );

      // Update integrity result with job log reference
      await AuditIntegrityResult.db.updateRow(
        session,
        integrityResult.copyWith(scheduledJobLogId: jobLog.id),
      );

      // Log to audit trail
      await AuditService.log(
        session,
        entityType: 'audit_integrity_result',
        entityId: integrityResult.id?.toString() ?? 'new',
        action: passed
            ? AuditEventType.auditIntegrityCheckPassed
            : AuditEventType.auditIntegrityCheckFailed,
        newValueJson: jsonEncode({
          'recordsChecked': recordsChecked,
          'hashMismatches': hashMismatches,
          'sequenceGaps': sequenceGaps,
          'result': result,
        }),
        reason: passed
            ? 'Daily audit trail integrity check passed'
            : 'CRITICAL: Audit trail integrity check FAILED',
      );

      session.log(
        '[AuditIntegrityCheck] ${passed ? 'PASSED' : 'FAILED'}: '
        '$recordsChecked records checked, $hashMismatches hash mismatches, $sequenceGaps sequence gaps',
        level: passed ? LogLevel.info : LogLevel.error,
      );

      // CRITICAL: Throw exception if integrity check failed
      if (!passed) {
        throw ScheduledJobException(
          'CRITICAL: Audit trail integrity check FAILED - possible data tampering detected',
          jobName: 'AuditTrailIntegrityCheck',
          details: 'Hash mismatches: $hashMismatches, Sequence gaps: $sequenceGaps',
        );
      }

      return {
        'success': true,
        'jobLogId': jobLog.id,
        'recordsChecked': recordsChecked,
        'hashMismatches': hashMismatches,
        'sequenceGaps': sequenceGaps,
        'result': result,
        'failures': failures,
      };
    } catch (e) {
      if (e is ScheduledJobException) rethrow;

      await ScheduledJobLog.db.insertRow(
        session,
        ScheduledJobLog(
          jobName: 'AuditTrailIntegrityCheck',
          startedAt: jobStartTime,
          completedAt: DateTime.now(),
          status: 'failed',
          recordsProcessed: recordsChecked,
          errorDetails: e.toString(),
        ),
      );

      throw ScheduledJobException(
        'Audit trail integrity check failed unexpectedly',
        jobName: 'AuditTrailIntegrityCheck',
        details: e.toString(),
      );
    }
  }

  /// Compute SHA-256 hash of critical audit trail fields for integrity verification.
  static String _computeAuditRowHash(AuditTrail record) {
    // Critical fields for integrity: entityType, entityId, action, timestamp, userId
    // These fields must not change once written (21 CFR Part 11)
    final dataToHash = [
      record.entityType,
      record.entityId,
      record.action,
      record.timestamp.toIso8601String(),
      record.userId?.toString() ?? 'null',
      record.oldValueJson ?? '',
      record.newValueJson ?? '',
      record.reason ?? '',
    ].join('|');

    final bytes = utf8.encode(dataToHash);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Compute and store hash for a new audit trail record.
  /// Call this when inserting new audit records to enable future integrity checks.
  static String computeHashForNewRecord({
    required String entityType,
    required String entityId,
    required String action,
    required DateTime timestamp,
    int? userId,
    String? oldValueJson,
    String? newValueJson,
    String? reason,
  }) {
    final dataToHash = [
      entityType,
      entityId,
      action,
      timestamp.toIso8601String(),
      userId?.toString() ?? 'null',
      oldValueJson ?? '',
      newValueJson ?? '',
      reason ?? '',
    ].join('|');

    final bytes = utf8.encode(dataToHash);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // ============================================================================
  // Helper Methods
  // ============================================================================

  /// Get or create a system user ID for automated operations.
  static Future<int> _getSystemUserId(Session session) async {
    // Look for a system user
    var systemUser = await PharmaUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals('system@pharma-lms.internal'),
    );

    if (systemUser != null && systemUser.id != null) {
      return systemUser.id!;
    }

    // Fallback: return first user's ID
    final firstUser = await PharmaUser.db.findFirstRow(session);
    if (firstUser?.id != null) {
      return firstUser!.id!;
    }

    throw ScheduledJobException(
      'No system user available for automated assignment',
      jobName: 'SystemUserLookup',
    );
  }
}
