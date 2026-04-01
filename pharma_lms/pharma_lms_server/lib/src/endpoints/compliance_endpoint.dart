import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/compliance_calculator_service.dart';
import '../services/rbac_helper.dart';

/// Compliance Engine domain endpoint.
class ComplianceEndpoint extends Endpoint {
  Future<ComplianceMetrics> getDepartmentCompliance(
    Session session,
    int departmentId, {
    DateTime? asOf,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return ComplianceMetrics(
        totalEmployees: 0,
        compliant: 0,
        overdue: 0,
        upcoming: 0,
        complianceRate: 0.0,
      );
    }
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
    return await ComplianceCalculatorService.getDepartmentCompliance(
      session,
      departmentId: departmentId,
      asOf: asOf,
    );
  }

  Future<UserComplianceMetrics> getUserCompliance(
    Session session,
    int userId, {
    DateTime? asOf,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) {
      return UserComplianceMetrics(
        compliant: true,
        overdueCount: 0,
        upcomingCount: 0,
        complianceRate: 0.0,
        totalCertificates: 0,
      );
    }
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
    return await ComplianceCalculatorService.getUserCompliance(
      session,
      userId: userId,
      asOf: asOf,
    );
  }

  Future<bool> isDepartmentBelowThreshold(
    Session session, {
    required int departmentId,
    required double threshold,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    await RbacHelper.requirePermission(session, resource: 'compliance', action: 'read');
    return await ComplianceCalculatorService.isBelowThreshold(
      session,
      departmentId: departmentId,
      threshold: threshold,
    );
  }

  /// E-signature readiness for the learner dashboard: signed training records,
  /// pending retraining acknowledgement, and assessments awaiting signature.
  Future<List<Map<String, dynamic>>> getEsignatureSummaryForUser(
    Session session,
    int userId,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me == null) return [];
    // In dev/demo mode (or admin) allow access; in prod only self can view.
    if (me.id != null && me.id != userId) {
      final canAdmin = await RbacHelper.hasPermission(
        session, resource: 'compliance', action: 'read');
      if (!canAdmin) return [];
    }

    final out = <Map<String, dynamic>>[];

    final records = await TrainingRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.completedAt,
      orderDescending: true,
      limit: 8,
      include: TrainingRecord.include(
        esignature: ElectronicSignature.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );
    for (final r in records) {
      final es = r.esignature;
      out.add({
        'kind': 'signed',
        'courseTitle': r.courseVersion?.course?.title ?? 'Training',
        'signedAt':
            es?.timestamp.toIso8601String() ?? r.completedAt.toIso8601String(),
        'integrityHash': es?.integrityHash,
      });
    }

    final needAck = await Enrollment.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.retrainingChangeSummary.notEquals(null) &
          t.acknowledgedAt.equals(null),
      include: Enrollment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
      limit: 10,
    );
    for (final e in needAck) {
      out.add({
        'kind': 'pending_ack',
        'courseTitle': e.courseVersion?.course?.title ?? 'Course',
        'dueDate': null,
      });
    }

    final attempts = await AssessmentAttempt.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.completedAt.notEquals(null),
      orderBy: (t) => t.completedAt,
      orderDescending: true,
      limit: 15,
      include: AssessmentAttempt.include(
        enrollment: Enrollment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      ),
    );
    for (final a in attempts) {
      if (a.id == null) continue;
      final sig = await ElectronicSignature.db.findFirstRow(
        session,
        where: (s) =>
            s.userId.equals(userId) &
            s.entityType.equals('assessment_attempt') &
            s.entityId.equals(a.id!.toString()) &
            s.isValid.equals(true),
      );
      if (sig != null) continue;
      final title =
          a.enrollment?.courseVersion?.course?.title ?? 'Assessment';
      out.add({
        'kind': 'pending_signature',
        'courseTitle': title,
        'attemptId': a.id,
        'completedAt': a.completedAt?.toIso8601String(),
      });
    }

    return out;
  }
}
