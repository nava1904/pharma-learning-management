import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

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

  /// Approve a course version (QA sign-off).
  Future<CourseVersion> approveCourseVersion(
    Session session, {
    required int courseVersionId,
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
    final updated = version.copyWith(status: 'approved');
    return await CourseVersion.db.updateRow(session, updated);
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
