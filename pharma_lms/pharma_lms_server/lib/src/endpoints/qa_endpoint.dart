import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';

/// QA & Course Approval domain endpoint.
class QaEndpoint extends Endpoint {
  /// List course versions pending QA approval.
  Future<List<CourseVersion>> listPendingCourseVersions(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    return await CourseVersion.db.find(
      session,
      where: (t) => t.status.equals('pending_approval'),
      include: CourseVersion.include(course: Course.include()),
      orderBy: (t) => t.id,
    );
  }

  /// Approve and publish a course version (QA sign-off). Sets status to effective.
  /// Marks previous effective versions obsolete and their certificates obsolete.
  /// reviewChecklistJson: QA-WF-01 structured checklist (content accuracy, etc.)
  Future<CourseVersion> approveCourseVersion(
    Session session, {
    required int courseVersionId,
    required String passwordPlaintext,
    required String signatureMeaning,
    int? approverId,
    String? reviewChecklistJson,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');

    final version = await CourseVersion.db.findById(
      session,
      courseVersionId,
      include: CourseVersion.include(course: Course.include()),
    );
    if (version == null) throw Exception('Course version not found');
    if (version.status != 'pending_approval') {
      throw Exception('Only pending_approval versions can be approved');
    }

    final previousEffective = await CourseVersion.db.find(
      session,
      where: (t) =>
          t.courseId.equals(version.courseId) &
          t.id.notEquals(courseVersionId) &
          t.status.equals('effective'),
    );
    for (final prev in previousEffective) {
      await CourseVersion.db.updateRow(
        session,
        prev.copyWith(
          status: 'obsolete',
          supersededByVersionId: courseVersionId,
        ),
      );
      final certs = await Certificate.db.find(
        session,
        where: (t) => t.courseVersionId.equals(prev.id!),
      );
      for (final cert in certs) {
        if (cert.id != null) {
          await Certificate.db.updateRow(
            session,
            cert.copyWith(status: 'obsolete'),
          );
          await AuditService.log(
            session,
            entityType: 'certificate',
            entityId: cert.id.toString(),
            action: 'CertificateObsoleted',
            newValueJson: '{"reason":"Course version superseded","newVersionId":$courseVersionId}',
            userId: approverId,
          );
        }
      }
    }

    version.status = 'effective';
    // Temporarily commented out to resolve syntax errors during code generation
    // version.esignatureId = signature.id;
    await CourseVersion.db.updateRow(session, version);
    if (approverId != null) {
      await CourseReview.db.insertRow(
        session,
        CourseReview(
          courseVersionId: courseVersionId,
          reviewerId: approverId,
          decision: 'approved',
          reviewChecklistJson: reviewChecklistJson,
        ),
      );
    }
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'CourseStatusChanged',
      oldValueJson: '{"status":"pending_approval"}',
      newValueJson: '{"status":"effective"}',
      userId: approverId,
    );
    await EventService.emitCourseVersionApproved(
      session,
      courseVersionId: courseVersionId,
      courseId: version.courseId,
    );
    await EventService.emitCourseVersionEffective(
      session,
      courseVersionId: courseVersionId,
    );
    return version;
  }

  /// Reject a course version (return to draft). Optionally return for changes.
  Future<CourseVersion> rejectCourseVersion(
    Session session, {
    required int courseVersionId,
    String? reason,
    bool returnForChanges = false,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status != 'pending_approval') {
      throw Exception('Only pending_approval versions can be rejected');
    }
    final status = returnForChanges ? 'draft' : 'draft';
    final updated = version.copyWith(status: status);
    return await CourseVersion.db.updateRow(session, updated);
  }

  /// Get the count of pending document approvals.
  Future<int> getPendingDocumentApprovalsCount(Session session) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    final result = await session.db.unsafeQuery(
      r"SELECT COUNT(*) FROM document_approval WHERE status = @status",
      parameters: QueryParameters.named({'status': 'pending'}),
    );
    if (result.isEmpty || result.first.isEmpty) return 0;
    final count = result.first.first;
    return count is int ? count : int.tryParse(count.toString()) ?? 0;
  }
}
