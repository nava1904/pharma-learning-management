import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';

/// QA & Course Approval domain endpoint.
class QaEndpoint extends Endpoint {
  /// List course versions pending QA approval.
  Future<List<CourseVersion>> listPendingCourseVersions(
    Session session,
  ) async {
    return await CourseVersion.db.find(
      session,
      where: (t) => t.status.equals('pending_approval'),
      include: CourseVersion.include(course: Course.include()),
      orderBy: (t) => t.id,
    );
  }

  /// Approve and publish a course version (QA sign-off). Sets status to effective.
  /// Marks previous effective versions obsolete and their certificates obsolete.
  Future<CourseVersion> approveCourseVersion(
    Session session, {
    required int courseVersionId,
    int? approverId,
  }) async {
    final version = await CourseVersion.db.findById(
      session,
      courseVersionId,
      include: CourseVersion.include(course: Course.include()),
    );
    if (version == null) throw Exception('Course version not found');
    if (version.status != 'pending_approval') {
      throw Exception('Only pending_approval versions can be approved');
    }
    if (version.courseId == null) throw Exception('Course version has no course');

    final previousEffective = await CourseVersion.db.find(
      session,
      where: (t) =>
          t.courseId.equals(version.courseId!) &
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

    final updated = version.copyWith(status: 'effective');
    final result = await CourseVersion.db.updateRow(session, updated);
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'CourseStatusChanged',
      oldValueJson: '{"status":"pending_approval"}',
      newValueJson: '{"status":"effective"}',
      userId: approverId,
    );
    return result;
  }

  /// Reject a course version (return to draft).
  Future<CourseVersion> rejectCourseVersion(
    Session session, {
    required int courseVersionId,
    String? reason,
  }) async {
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (version.status != 'pending_approval') {
      throw Exception('Only pending_approval versions can be rejected');
    }
    final updated = version.copyWith(status: 'draft');
    return await CourseVersion.db.updateRow(session, updated);
  }
}
