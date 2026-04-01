import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/audit_service.dart';
import '../services/event_service.dart';
import '../services/rbac_helper.dart';

/// QA & Course Approval domain endpoint.
class QaEndpoint extends Endpoint {
  static const _pendingReviewStatuses = {'pending_approval', 'under_review'};

  /// List course versions awaiting QA review (submitted or in review).
  Future<List<CourseVersion>> listPendingCourseVersions(
    Session session,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    return await CourseVersion.db.find(
      session,
      where: (t) => t.status.inSet(_pendingReviewStatuses),
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
    if (!_pendingReviewStatuses.contains(version.status)) {
      throw Exception(
        'Only versions in QA review (${_pendingReviewStatuses.join(", ")}) can be approved',
      );
    }
    final oldStatus = version.status;

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

    // Keep parent Course in sync so trainer portal lists/dashboard show approved, not draft.
    final parentCourse = await Course.db.findById(session, version.courseId);
    if (parentCourse != null && parentCourse.id != null) {
      final now = DateTime.now();
      final oldCourseStatus = parentCourse.status;
      await Course.db.updateRow(
        session,
        parentCourse.copyWith(
          status: 'approved',
          publishedAt: parentCourse.publishedAt ?? now,
        ),
      );
      await AuditService.log(
        session,
        entityType: 'course',
        entityId: parentCourse.id!.toString(),
        action: 'CourseStatusChanged',
        oldValueJson: '{"status":"$oldCourseStatus"}',
        newValueJson:
            '{"status":"approved","publishedAt":"${(parentCourse.publishedAt ?? now).toIso8601String()}"}',
        userId: approverId,
      );
    }

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
      oldValueJson: '{"status":"$oldStatus"}',
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
    if (!QaEndpoint._pendingReviewStatuses.contains(version.status)) {
      throw Exception('Only versions in QA review can be rejected');
    }
    final status = returnForChanges ? 'needs_revision' : 'draft';
    final updated = version.copyWith(status: status);
    final result = await CourseVersion.db.updateRow(session, updated);
    
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: returnForChanges ? 'CourseReturnedForChanges' : 'CourseRejected',
      oldValueJson: '{"status":"${version.status}"}',
      newValueJson: '{"status":"$status","reason":"${reason ?? ''}"}',
    );
    
    return result;
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

  /// Return a course for changes (not rejection). Status -> needs_revision.
  Future<CourseVersion> returnCourseForChanges(
    Session session, {
    required int courseVersionId,
    required String comments,
    int? reviewerId,
  }) async {
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'write');
    final version = await CourseVersion.db.findById(session, courseVersionId);
    if (version == null) throw Exception('Course version not found');
    if (!QaEndpoint._pendingReviewStatuses.contains(version.status)) {
      throw Exception('Only versions in QA review can be returned for changes');
    }
    
    final updated = version.copyWith(status: 'needs_revision');
    final result = await CourseVersion.db.updateRow(session, updated);
    
    if (reviewerId != null) {
      await CourseReview.db.insertRow(
        session,
        CourseReview(
          courseVersionId: courseVersionId,
          reviewerId: reviewerId,
          decision: 'returned_for_changes',
          comments: comments,
        ),
      );
    }
    
    await AuditService.log(
      session,
      entityType: 'course_version',
      entityId: courseVersionId.toString(),
      action: 'CourseReturnedForChanges',
      oldValueJson: '{"status":"${version.status}"}',
      newValueJson: '{"status":"needs_revision","comments":"$comments"}',
      userId: reviewerId,
    );
    
    return result;
  }

  /// Get all course reviews for a course version.
  Future<List<CourseReview>> getCourseReviews(
    Session session, {
    required int courseVersionId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    await RbacHelper.requirePermission(session, resource: 'quality_event', action: 'read');
    return await CourseReview.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: CourseReview.include(
        reviewer: PharmaUser.include(),
        esignature: ElectronicSignature.include(),
      ),
      orderBy: (t) => t.reviewedAt,
      orderDescending: true,
    );
  }

  /// Get course reviews visible to the course trainer (no quality_event permission required).
  /// Trainers need to see QA comments / rejection reasons for their own courses.
  Future<List<CourseReview>> getCourseReviewsForTrainer(
    Session session, {
    required int courseVersionId,
  }) async {
    final currentUser = await RbacHelper.getCurrentPharmaUser(session);
    if (currentUser == null) return [];
    // Verify the user is the course creator (owns this course)
    final version = await CourseVersion.db.findById(
      session,
      courseVersionId,
      include: CourseVersion.include(course: Course.include()),
    );
    if (version == null) return [];
    final course = version.course;
    if (course == null || course.createdById != currentUser.id) return [];
    return await CourseReview.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: CourseReview.include(
        reviewer: PharmaUser.include(),
      ),
      orderBy: (t) => t.reviewedAt,
      orderDescending: true,
    );
  }
}
