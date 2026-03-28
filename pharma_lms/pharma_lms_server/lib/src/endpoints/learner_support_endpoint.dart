import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';

/// Learner ↔ course owner (trainer) messaging for a course version.
class LearnerSupportEndpoint extends Endpoint {
  Future<List<LearnerTrainerMessage>> listThread(
    Session session,
    int courseVersionId,
  ) async {
    if (!await _canAccessThread(session, courseVersionId)) return [];
    return LearnerTrainerMessage.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      orderBy: (t) => t.createdAt,
      include: LearnerTrainerMessage.include(
        fromUser: PharmaUser.include(),
        toUser: PharmaUser.include(),
      ),
    );
  }

  Future<LearnerTrainerMessage?> sendMessage(
    Session session, {
    required int courseVersionId,
    required String body,
    int? parentMessageId,
    int? toUserId,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return null;

    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) return null;
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me!.organizationId) return null;

    final ownerId = course.createdById;
    if (ownerId == null) return null;

    final enrolled = await Enrollment.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(me.id!) & t.courseVersionId.equals(courseVersionId),
    );
    final isOwner = ownerId == me.id;
    final isBatchInstructor = await _isBatchInstructorForVersion(session, courseVersionId, me.id!);

    if (!isOwner && !isBatchInstructor && enrolled == null) return null;

    int toUid;
    if (isOwner || isBatchInstructor) {
      if (parentMessageId != null) {
        final parent = await LearnerTrainerMessage.db.findById(session, parentMessageId);
        if (parent == null || parent.courseVersionId != courseVersionId) return null;
        toUid = parent.fromUserId == me.id! ? parent.toUserId : parent.fromUserId;
      } else if (toUserId != null) {
        final targetEnrolled = await Enrollment.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(toUserId) & t.courseVersionId.equals(courseVersionId),
        );
        if (targetEnrolled == null) return null;
        toUid = toUserId;
      } else {
        return null;
      }
    } else {
      toUid = ownerId;
      if (parentMessageId != null) {
        final parent = await LearnerTrainerMessage.db.findById(session, parentMessageId);
        if (parent == null || parent.courseVersionId != courseVersionId) return null;
      }
    }

    if (toUid == me.id) return null;

    final row = await LearnerTrainerMessage.db.insertRow(
      session,
      LearnerTrainerMessage(
        courseVersionId: courseVersionId,
        fromUserId: me.id!,
        toUserId: toUid,
        body: body,
        parentMessageId: parentMessageId,
      ),
    );

    await Notification.db.insertRow(
      session,
      Notification(
        userId: toUid,
        type: 'learner_trainer_message',
        body: 'New message regarding "${course.title}".',
        channel: 'in_app',
      ),
    );

    RealtimeHub.instance.broadcast(
      'learner_trainer:cv:$courseVersionId',
      {
        'event': 'learner_trainer_message_created',
        'courseVersionId': courseVersionId,
        'payload': {
          'id': row.id,
          'fromUserId': row.fromUserId,
          'toUserId': row.toUserId,
          'body': row.body,
          'parentMessageId': row.parentMessageId,
          'createdAt': row.createdAt.toIso8601String(),
        },
      },
    );

    return row;
  }

  Future<bool> _canAccessThread(Session session, int courseVersionId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return false;
    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) return false;
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != me!.organizationId) return false;

    final enrolled = await Enrollment.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(me.id!) & t.courseVersionId.equals(courseVersionId),
    );
    if (enrolled != null) return true;
    if (course.createdById == me.id) return true;
    return _isBatchInstructorForVersion(session, courseVersionId, me.id!);
  }

  Future<bool> _isBatchInstructorForVersion(
    Session session,
    int courseVersionId,
    int userId,
  ) async {
    final hit = await TrainingBatch.db.findFirstRow(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId) & t.instructorId.equals(userId),
    );
    return hit != null;
  }

  /// Inbox for course owners and batch instructors: one row per course version that has messages.
  Future<List<LearnerSupportThreadSummary>> listTrainerSupportThreads(
    Session session,
  ) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final trainerId = me!.id!;
    final orgId = me.organizationId;

    final ownedCourses = await Course.db.find(
      session,
      where: (t) => t.createdById.equals(trainerId) & t.organizationId.equals(orgId),
    );
    final ownedCourseIds = ownedCourses.map((c) => c.id!).toSet();

    final batches = await TrainingBatch.db.find(
      session,
      where: (t) => t.instructorId.equals(trainerId),
    );
    final batchVersionIds = batches.map((b) => b.courseVersionId).toSet();

    final versionIds = <int>{};
    final courseByVersionId = <int, Course>{};

    if (ownedCourseIds.isNotEmpty) {
      final vers = await CourseVersion.db.find(
        session,
        where: (t) => t.courseId.inSet(ownedCourseIds),
      );
      for (final v in vers) {
        final vid = v.id;
        if (vid == null) continue;
        versionIds.add(vid);
        final c = ownedCourses.firstWhere((x) => x.id == v.courseId);
        courseByVersionId[vid] = c;
      }
    }

    for (final vid in batchVersionIds) {
      if (versionIds.contains(vid)) continue;
      final cv = await CourseVersion.db.findById(session, vid);
      if (cv == null) continue;
      final course = await Course.db.findById(session, cv.courseId);
      if (course == null || course.organizationId != orgId) continue;
      versionIds.add(vid);
      courseByVersionId[vid] = course;
    }

    if (versionIds.isEmpty) return [];

    final all = await LearnerTrainerMessage.db.find(
      session,
      where: (t) => t.courseVersionId.inSet(versionIds),
      include: LearnerTrainerMessage.include(fromUser: PharmaUser.include()),
    );

    if (all.isEmpty) return [];

    final byVid = <int, List<LearnerTrainerMessage>>{};
    for (final m in all) {
      byVid.putIfAbsent(m.courseVersionId, () => []).add(m);
    }

    final out = <LearnerSupportThreadSummary>[];
    for (final entry in byVid.entries) {
      final vid = entry.key;
      final msgs = entry.value;
      msgs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final last = msgs.first;
      final course = courseByVersionId[vid];
      if (course == null) continue;
      var fromName = last.fromUser != null
          ? '${last.fromUser!.firstName} ${last.fromUser!.lastName}'.trim()
          : '';
      if (fromName.isEmpty) fromName = 'User ${last.fromUserId}';
      final unread = msgs
          .where((m) => m.toUserId == trainerId && m.readAt == null)
          .length;
      out.add(
        LearnerSupportThreadSummary(
          courseVersionId: vid,
          courseId: course.id!,
          courseTitle: course.title,
          lastMessageBody: last.body,
          lastMessageAt: last.createdAt,
          lastFromUserId: last.fromUserId,
          lastFromName: fromName,
          messageCount: msgs.length,
          unreadForTrainer: unread,
        ),
      );
    }
    out.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return out;
  }

  /// Marks messages addressed to the current user in this thread as read (learner or trainer).
  Future<int> markThreadMessagesRead(Session session, int courseVersionId) async {
    if (!await _canAccessThread(session, courseVersionId)) return 0;
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    final uid = me!.id!;
    final rows = await LearnerTrainerMessage.db.find(
      session,
      where: (t) =>
          t.courseVersionId.equals(courseVersionId) &
          t.toUserId.equals(uid) &
          t.readAt.equals(null),
    );
    final now = DateTime.now();
    var n = 0;
    for (final r in rows) {
      r.readAt = now;
      await LearnerTrainerMessage.db.updateRow(session, r);
      n++;
    }
    return n;
  }
}
