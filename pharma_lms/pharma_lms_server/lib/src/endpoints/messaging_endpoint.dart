import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Unified messaging endpoint providing inbox aggregation, unread counts,
/// and paginated access across both learner↔trainer and trainer↔QA channels.
///
/// All methods return properly typed Serverpod protocol objects — no
/// Map<String,dynamic> returns, so the client deserializes everything correctly.
class MessagingEndpoint extends Endpoint {
  // ──────────────────────────────────────────────────────────────────
  // Unified unread counts (badge numbers)
  // ──────────────────────────────────────────────────────────────────

  /// Returns typed unread counts across all messaging channels.
  Future<MessagingUnreadCounts> getUnreadCounts(Session session) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) {
      return MessagingUnreadCounts(learnerTrainer: 0, qaReview: 0, total: 0);
    }
    final uid = me!.id!;

    final ltUnread = await LearnerTrainerMessage.db.count(
      session,
      where: (t) => t.toUserId.equals(uid) & t.readAt.equals(null),
    );

    final qaUnread =
        await _countUnreadQaComments(session, uid, me.organizationId);

    return MessagingUnreadCounts(
      learnerTrainer: ltUnread,
      qaReview: qaUnread,
      total: ltUnread + qaUnread,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // Learner ↔ Trainer paginated thread
  // ──────────────────────────────────────────────────────────────────

  /// Paginated message list for a course version thread.
  Future<List<LearnerTrainerMessage>> getThreadMessages(
    Session session, {
    required int courseVersionId,
    int limit = 50,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];

    if (!await _canAccessThread(
        session, courseVersionId, me!.id!, me.organizationId)) {
      return [];
    }

    return LearnerTrainerMessage.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: LearnerTrainerMessage.include(
        fromUser: PharmaUser.include(),
        toUser: PharmaUser.include(),
      ),
      limit: limit,
      offset: offset,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // Trainer inbox
  // ──────────────────────────────────────────────────────────────────

  /// Paginated inbox for trainers: one summary per course version with messages.
  Future<List<LearnerSupportThreadSummary>> getTrainerInbox(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final trainerId = me!.id!;
    final orgId = me.organizationId;

    final versionIds = await _getTrainerVersionIds(session, trainerId, orgId);
    if (versionIds.isEmpty) return [];

    final allMessages = await LearnerTrainerMessage.db.find(
      session,
      where: (t) => t.courseVersionId.inSet(versionIds),
      include: LearnerTrainerMessage.include(fromUser: PharmaUser.include()),
    );

    if (allMessages.isEmpty) return [];

    final byVid = <int, List<LearnerTrainerMessage>>{};
    for (final m in allMessages) {
      byVid.putIfAbsent(m.courseVersionId, () => []).add(m);
    }

    final courseByVersionId =
        await _batchLoadCoursesForVersions(session, byVid.keys.toSet());

    final summaries = <LearnerSupportThreadSummary>[];
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

      final unread =
          msgs.where((m) => m.toUserId == trainerId && m.readAt == null).length;

      summaries.add(LearnerSupportThreadSummary(
        courseVersionId: vid,
        courseId: course.id!,
        courseTitle: course.title,
        lastMessageBody: last.body,
        lastMessageAt: last.createdAt,
        lastFromUserId: last.fromUserId,
        lastFromName: fromName,
        messageCount: msgs.length,
        unreadForTrainer: unread,
      ));
    }

    summaries.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    if (offset >= summaries.length) return [];
    return summaries.skip(offset).take(limit).toList();
  }

  // ──────────────────────────────────────────────────────────────────
  // Learner inbox
  // ──────────────────────────────────────────────────────────────────

  /// Paginated inbox for learners.
  Future<List<LearnerSupportThreadSummary>> getLearnerInbox(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final uid = me!.id!;

    final myMessages = await LearnerTrainerMessage.db.find(
      session,
      where: (t) => t.fromUserId.equals(uid) | t.toUserId.equals(uid),
      include: LearnerTrainerMessage.include(fromUser: PharmaUser.include()),
    );

    if (myMessages.isEmpty) return [];

    final byVid = <int, List<LearnerTrainerMessage>>{};
    for (final m in myMessages) {
      byVid.putIfAbsent(m.courseVersionId, () => []).add(m);
    }

    final courseByVersionId =
        await _batchLoadCoursesForVersions(session, byVid.keys.toSet());

    final summaries = <LearnerSupportThreadSummary>[];
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

      final unread =
          msgs.where((m) => m.toUserId == uid && m.readAt == null).length;

      summaries.add(LearnerSupportThreadSummary(
        courseVersionId: vid,
        courseId: course.id!,
        courseTitle: course.title,
        lastMessageBody: last.body,
        lastMessageAt: last.createdAt,
        lastFromUserId: last.fromUserId,
        lastFromName: fromName,
        messageCount: msgs.length,
        unreadForTrainer: unread,
      ));
    }

    summaries.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    if (offset >= summaries.length) return [];
    return summaries.skip(offset).take(limit).toList();
  }

  // ──────────────────────────────────────────────────────────────────
  // QA/SME inbox (for trainers)
  // ──────────────────────────────────────────────────────────────────

  /// Paginated QA/SME review thread inbox for trainers.
  Future<List<SmeThreadSummary>> getQaInbox(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final uid = me!.id!;
    final orgId = me.organizationId;

    final ownedCourses = await Course.db.find(
      session,
      where: (t) =>
          t.createdById.equals(uid) & t.organizationId.equals(orgId),
    );
    final courseIds = ownedCourses.map((c) => c.id!).toSet();
    if (courseIds.isEmpty) return [];

    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.inSet(courseIds),
    );
    final versionIds = versions.map((v) => v.id!).toSet();
    if (versionIds.isEmpty) return [];

    final allComments = await SmeReviewComment.db.find(
      session,
      where: (t) => t.courseVersionId.inSet(versionIds),
      include: SmeReviewComment.include(author: PharmaUser.include()),
    );

    if (allComments.isEmpty) return [];

    return _buildSmeThreadSummaries(
        allComments, versions, ownedCourses, uid, offset, limit);
  }

  /// QA/SME inbox for QA reviewers.
  Future<List<SmeThreadSummary>> getQaReviewerInbox(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];
    final uid = me!.id!;

    final assignments = await SmeAssignment.db.find(
      session,
      where: (t) =>
          t.smeUserId.equals(uid) & t.status.inSet({'invited', 'active'}),
    );

    final courseIds = assignments.map((a) => a.courseId).toSet();
    if (courseIds.isEmpty) return [];

    final courses = await Course.db.find(
      session,
      where: (t) => t.id.inSet(courseIds),
    );

    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.inSet(courseIds),
    );
    final versionIds = versions.map((v) => v.id!).toSet();
    if (versionIds.isEmpty) return [];

    final allComments = await SmeReviewComment.db.find(
      session,
      where: (t) => t.courseVersionId.inSet(versionIds),
      include: SmeReviewComment.include(author: PharmaUser.include()),
    );

    if (allComments.isEmpty) return [];

    return _buildSmeThreadSummaries(
        allComments, versions, courses, uid, offset, limit);
  }

  // ──────────────────────────────────────────────────────────────────
  // QA/SME paginated comments
  // ──────────────────────────────────────────────────────────────────

  /// Paginated QA/SME comment list for a course version.
  Future<List<SmeReviewComment>> getQaThreadComments(
    Session session, {
    required int courseVersionId,
    int limit = 50,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];

    return SmeReviewComment.db.find(
      session,
      where: (t) => t.courseVersionId.equals(courseVersionId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: SmeReviewComment.include(
        author: PharmaUser.include(),
        parentComment:
            SmeReviewComment.include(author: PharmaUser.include()),
      ),
      limit: limit,
      offset: offset,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // Batch mark-read operations
  // ──────────────────────────────────────────────────────────────────

  /// Mark all QA comments in a thread as read for the current user.
  Future<int> markQaThreadRead(Session session, int courseVersionId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    final uid = me!.id!;

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

  /// Mark all learner↔trainer messages in a thread as read.
  Future<int> markLearnerThreadRead(
      Session session, int courseVersionId) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    final uid = me!.id!;

    final unread = await LearnerTrainerMessage.db.find(
      session,
      where: (t) =>
          t.courseVersionId.equals(courseVersionId) &
          t.toUserId.equals(uid) &
          t.readAt.equals(null),
    );

    final now = DateTime.now();
    var count = 0;
    for (final m in unread) {
      m.readAt = now;
      await LearnerTrainerMessage.db.updateRow(session, m);
      count++;
    }
    return count;
  }

  // ──────────────────────────────────────────────────────────────────
  // Notification badge counts
  // ──────────────────────────────────────────────────────────────────

  /// Returns unread in-app notification count.
  Future<int> getUnreadNotificationCount(Session session) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    return Notification.db.count(
      session,
      where: (t) =>
          t.userId.equals(me!.id!) &
          t.readAt.equals(null) &
          t.channel.equals('in_app'),
    );
  }

  /// Paginated notification list.
  Future<List<Notification>> getNotifications(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return [];

    return Notification.db.find(
      session,
      where: (t) =>
          t.userId.equals(me!.id!) & t.channel.equals('in_app'),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Mark all in-app notifications as read.
  Future<int> markAllNotificationsRead(Session session) async {
    final me = await RbacHelper.getCurrentPharmaUser(session);
    if (me?.id == null) return 0;
    final uid = me!.id!;

    final rows = await Notification.db.find(
      session,
      where: (t) =>
          t.userId.equals(uid) &
          t.readAt.equals(null) &
          t.channel.equals('in_app'),
    );
    final now = DateTime.now();
    var count = 0;
    for (final n in rows) {
      n.readAt = now;
      await Notification.db.updateRow(session, n);
      count++;
    }
    return count;
  }

  // ──────────────────────────────────────────────────────────────────
  // Private helpers
  // ──────────────────────────────────────────────────────────────────

  List<SmeThreadSummary> _buildSmeThreadSummaries(
    List<SmeReviewComment> allComments,
    List<CourseVersion> versions,
    List<Course> courses,
    int currentUserId,
    int offset,
    int limit,
  ) {
    final courseMap = {for (final c in courses) c.id!: c};
    final versionToCourse = <int, Course>{};
    for (final v in versions) {
      final vid = v.id;
      if (vid == null) continue;
      final course = courseMap[v.courseId];
      if (course != null) versionToCourse[vid] = course;
    }

    final byVid = <int, List<SmeReviewComment>>{};
    for (final c in allComments) {
      byVid.putIfAbsent(c.courseVersionId, () => []).add(c);
    }

    final summaries = <SmeThreadSummary>[];
    for (final entry in byVid.entries) {
      final vid = entry.key;
      final comments = entry.value;
      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final last = comments.first;
      final course = versionToCourse[vid];
      if (course == null) continue;

      final author = last.author;
      var fromName = author != null
          ? '${author.firstName} ${author.lastName}'.trim()
          : '';
      if (fromName.isEmpty) fromName = 'User ${last.authorId}';

      final unresolved = comments.where((c) => !c.resolved).length;
      final unread = comments
          .where((c) => c.authorId != currentUserId && c.readAt == null)
          .length;

      summaries.add(SmeThreadSummary(
        courseVersionId: vid,
        courseId: course.id!,
        courseTitle: course.title,
        lastCommentBody: last.body,
        lastCommentAt: last.createdAt,
        lastFromUserId: last.authorId,
        lastFromName: fromName,
        commentCount: comments.length,
        unresolvedCount: unresolved,
        unreadCount: unread,
      ));
    }

    summaries.sort((a, b) => b.lastCommentAt.compareTo(a.lastCommentAt));
    if (offset >= summaries.length) return [];
    return summaries.skip(offset).take(limit).toList();
  }

  Future<bool> _canAccessThread(
    Session session,
    int courseVersionId,
    int userId,
    int orgId,
  ) async {
    final cv = await CourseVersion.db.findById(session, courseVersionId);
    if (cv == null) return false;
    final course = await Course.db.findById(session, cv.courseId);
    if (course == null || course.organizationId != orgId) return false;
    if (course.createdById == userId) return true;
    final enrolled = await Enrollment.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.courseVersionId.equals(courseVersionId),
    );
    if (enrolled != null) return true;
    final batch = await TrainingBatch.db.findFirstRow(
      session,
      where: (t) =>
          t.courseVersionId.equals(courseVersionId) &
          t.instructorId.equals(userId),
    );
    return batch != null;
  }

  Future<Set<int>> _getTrainerVersionIds(
      Session session, int trainerId, int orgId) async {
    final versionIds = <int>{};
    final ownedCourses = await Course.db.find(
      session,
      where: (t) =>
          t.createdById.equals(trainerId) & t.organizationId.equals(orgId),
    );
    final ownedCourseIds = ownedCourses.map((c) => c.id!).toSet();
    if (ownedCourseIds.isNotEmpty) {
      final versions = await CourseVersion.db.find(
        session,
        where: (t) => t.courseId.inSet(ownedCourseIds),
      );
      for (final v in versions) {
        if (v.id != null) versionIds.add(v.id!);
      }
    }
    final batches = await TrainingBatch.db.find(
      session,
      where: (t) => t.instructorId.equals(trainerId),
    );
    for (final b in batches) {
      versionIds.add(b.courseVersionId);
    }
    return versionIds;
  }

  Future<Map<int, Course>> _batchLoadCoursesForVersions(
    Session session,
    Set<int> versionIds,
  ) async {
    if (versionIds.isEmpty) return {};
    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.id.inSet(versionIds),
    );
    final courseIds = versions.map((v) => v.courseId).toSet();
    if (courseIds.isEmpty) return {};
    final courses = await Course.db.find(
      session,
      where: (t) => t.id.inSet(courseIds),
    );
    final courseMap = {for (final c in courses) c.id!: c};
    final result = <int, Course>{};
    for (final v in versions) {
      final vid = v.id;
      if (vid == null) continue;
      final course = courseMap[v.courseId];
      if (course != null) result[vid] = course;
    }
    return result;
  }

  Future<int> _countUnreadQaComments(
      Session session, int userId, int orgId) async {
    final ownedCourses = await Course.db.find(
      session,
      where: (t) =>
          t.createdById.equals(userId) & t.organizationId.equals(orgId),
    );
    final courseIds = ownedCourses.map((c) => c.id!).toSet();
    final smeAssignments = await SmeAssignment.db.find(
      session,
      where: (t) =>
          t.smeUserId.equals(userId) &
          t.status.inSet({'invited', 'active'}),
    );
    courseIds.addAll(smeAssignments.map((a) => a.courseId));
    if (courseIds.isEmpty) return 0;
    final versions = await CourseVersion.db.find(
      session,
      where: (t) => t.courseId.inSet(courseIds),
    );
    final versionIds = versions.map((v) => v.id!).toSet();
    if (versionIds.isEmpty) return 0;
    return SmeReviewComment.db.count(
      session,
      where: (t) =>
          t.courseVersionId.inSet(versionIds) &
          t.authorId.notEquals(userId) &
          t.readAt.equals(null),
    );
  }
}
