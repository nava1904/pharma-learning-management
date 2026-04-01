import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';

/// SME collaboration: invites, review comments, resolve workflow.
class SmeEndpoint extends Endpoint {
  Future<List<SmeAssignment>> listAssignmentsForCourse(
    Session session,
    int courseId,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me == null) return [];
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    final course = await Course.db.findById(session, courseId);
    if (course == null || course.organizationId != me.organizationId) return [];
    return SmeAssignment.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
      include: SmeAssignment.include(
        smeUser: PharmaUser.include(),
        invitedBy: PharmaUser.include(),
        courseVersion: CourseVersion.include(),
      ),
      orderBy: (t) => t.invitedAt,
      orderDescending: true,
    );
  }

  Future<SmeAssignment> inviteSme(
    Session session, {
    required int courseId,
    required int smeUserId,
    int? courseVersionId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) throw Exception('Authentication required');
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');
    final course = await Course.db.findById(session, courseId);
    if (course == null) throw Exception('Course not found');
    if (course.organizationId != me!.organizationId) throw Exception('Forbidden');
    final sme = await PharmaUser.db.findById(session, smeUserId);
    if (sme == null || sme.organizationId != me.organizationId) {
      throw Exception('Invalid SME user');
    }
    if (smeUserId == me.id) throw Exception('Cannot invite yourself as SME');

    final existing = await SmeAssignment.db.findFirstRow(
      session,
      where: (t) => t.courseId.equals(courseId) & t.smeUserId.equals(smeUserId),
    );

    final SmeAssignment saved;
    if (existing != null) {
      saved = await SmeAssignment.db.updateRow(
        session,
        existing.copyWith(
          status: 'invited',
          invitedAt: DateTime.now(),
          courseVersionId: courseVersionId,
        ),
      );
    } else {
      saved = await SmeAssignment.db.insertRow(
        session,
        SmeAssignment(
          courseId: courseId,
          smeUserId: smeUserId,
          invitedById: me.id!,
          courseVersionId: courseVersionId,
          status: 'invited',
        ),
      );
    }

    final courseTitle = course.title;
    await Notification.db.insertRow(
      session,
      Notification(
        userId: smeUserId,
        type: 'sme_invite',
        body: 'You were invited to review "$courseTitle" as an SME.',
        channel: 'in_app',
      ),
    );

    return saved;
  }

  Future<List<SmeReviewComment>> listCommentsForCourseVersion(
    Session session,
    int courseVersionId, {
    int? limit,
    int? offset,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me == null) return [];
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');
    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) return [];
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me.organizationId) return [];
    return SmeReviewComment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      include: SmeReviewComment.include(
        author: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
        parentComment: SmeReviewComment.include(author: PharmaUser.include()),
      ),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<SmeReviewComment> addComment(
    Session session, {
    required int courseVersionId,
    required String sectionRef,
    required String body,
    String severity = 'note',
    int? parentCommentId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) throw Exception('Authentication required');
    await RbacHelper.requirePermission(session, resource: 'course', action: 'read');

    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) throw Exception('Course version not found');
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me!.organizationId) {
      throw Exception('Forbidden');
    }

    final isSme = await SmeAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.courseId.equals(course.id!) &
          t.smeUserId.equals(me.id!) &
          t.status.inSet({'invited', 'active'}),
    );
    final canPostAsQa =
        await RbacHelper.hasPermission(session, resource: 'quality_event', action: 'write');
    if (isSme == null && course.createdById != me.id && !canPostAsQa) {
      throw Exception('Only the course owner, invited SME, or QA can comment');
    }

    if (parentCommentId != null) {
      final parent = await SmeReviewComment.db.findById(session, parentCommentId);
      if (parent == null || parent.courseVersionId != courseVersionId) {
        throw Exception('Invalid parent comment');
      }
    }

    final row = await SmeReviewComment.db.insertRow(
      session,
      SmeReviewComment(
        courseVersionId: courseVersionId,
        authorId: me.id!,
        sectionRef: sectionRef,
        severity: severity,
        body: body,
        parentCommentId: parentCommentId,
      ),
    );

    final notifyUserId = course.createdById;
    if (notifyUserId != null &&
        notifyUserId != me.id &&
        (isSme != null || canPostAsQa)) {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: notifyUserId,
          type: 'sme_comment',
          body: 'New review comment on "${course.title}" ($sectionRef).',
          channel: 'in_app',
        ),
      );
    }

    RealtimeHub.instance.broadcast(
      'qa_thread:cv:$courseVersionId',
      {
        'event': 'sme_comment_created',
        'courseVersionId': courseVersionId,
        'payload': {
          'id': row.id,
          'authorId': row.authorId,
          'sectionRef': row.sectionRef,
          'severity': row.severity,
          'body': row.body,
          'parentCommentId': row.parentCommentId,
          'createdAt': row.createdAt.toIso8601String(),
        },
      },
    );

    return row;
  }

  Future<SmeReviewComment> resolveComment(
    Session session, {
    required int commentId,
    String? trainerResponse,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) throw Exception('Authentication required');
    await RbacHelper.requirePermission(session, resource: 'course', action: 'write');

    final comment = await SmeReviewComment.db.findById(session, commentId);
    if (comment == null) throw Exception('Comment not found');

    final cv = await CourseVersion.db.findById(session, comment.courseVersionId);
    if (cv == null) throw Exception('Invalid comment');
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me!.organizationId) {
      throw Exception('Forbidden');
    }
    if (course.createdById != me.id) {
      throw Exception('Only the course owner can resolve SME comments');
    }

    final updated = comment.copyWith(
      resolved: true,
      trainerResponse: trainerResponse,
      resolvedAt: DateTime.now(),
    );
    final saved = await SmeReviewComment.db.updateRow(session, updated);

    final authorId = comment.authorId;
    if (authorId != me.id) {
      await Notification.db.insertRow(
        session,
        Notification(
          userId: authorId,
          type: 'sme_resolved',
          body: 'Trainer resolved your comment on "${course.title}".',
          channel: 'in_app',
        ),
      );
    }

    RealtimeHub.instance.broadcast(
      'qa_thread:cv:${comment.courseVersionId}',
      {
        'event': 'sme_comment_resolved',
        'courseVersionId': comment.courseVersionId,
        'payload': {
          'id': saved.id,
          'resolved': saved.resolved,
          'trainerResponse': saved.trainerResponse,
        },
      },
    );

    return saved;
  }

  /// Mark all SME comments in a course version thread as read for the current user.
  /// Only marks comments authored by OTHER users (not your own).
  Future<int> markCommentsRead(Session session, int courseVersionId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    final uid = me!.id!;

    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) return 0;
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me.organizationId) return 0;

    final unread = await SmeReviewComment.db.find(
      session,
      where: (t) =>
          t.courseVersionId.equals(courseVersionId) &
          t.readAt.equals(null) &
          t.authorId.notEquals(uid),
    );

    final now = DateTime.now();
    var count = 0;
    for (final c in unread) {
      c.readAt = now;
      await SmeReviewComment.db.updateRow(session, c);
      count++;
    }
    return count;
  }
}
