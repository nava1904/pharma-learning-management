import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';
import '../services/realtime_hub.dart';

/// Notification domain endpoint (in-app; no email/push in stub).
class NotificationEndpoint extends Endpoint {

  /// Get all persisted notifications for a user (admin, broadcast, etc).
  Future<List<Notification>> getUserNotifications(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    // No permission check: all users can see their own notifications
    return await Notification.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 50,
    );
  }
  /// Get in-app notifications: assignment due, overdue from TrainingAssignment.
  Future<List<InAppNotification>> getInAppNotifications(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      include: TrainingAssignment.include(
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
    );

    final now = DateTime.now();
    final dueSoon = now.add(const Duration(days: 7));
    final notifications = <InAppNotification>[];

    for (final a in assignments) {
      final enrollments = await Enrollment.db.find(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.courseVersionId.equals(a.courseVersionId),
      );
      final completed = enrollments.any((e) => e.status == 'completed');
      if (completed) continue;

      final due = a.dueDate;
      final courseTitle = a.courseVersion?.course?.title ?? 'Course';

      if (due.isBefore(now)) {
        notifications.add(InAppNotification(
          type: 'overdue',
          assignmentId: a.id,
          courseTitle: courseTitle,
          dueDate: due.toIso8601String(),
          message: 'Training overdue: $courseTitle',
        ));
      } else if (due.isBefore(dueSoon)) {
        notifications.add(InAppNotification(
          type: 'due_soon',
          assignmentId: a.id,
          courseTitle: courseTitle,
          dueDate: due.toIso8601String(),
          message: 'Due soon: $courseTitle',
        ));
      }
    }

    return notifications;
  }

  /// Get trainer-specific notifications (QA decisions, SOP updates, assignment alerts).
  Future<List<InAppNotification>> getTrainerNotifications(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'training', action: 'read')) return [];
    
    final notifications = <InAppNotification>[];
    
    final courses = await Course.db.find(
      session,
      where: (t) => t.createdById.equals(userId),
    );
    
    for (final course in courses) {
      final versions = await CourseVersion.db.find(
        session,
        where: (t) => t.courseId.equals(course.id!),
        orderBy: (t) => t.id,
        orderDescending: true,
        limit: 1,
      );
      
      for (final v in versions) {
        if (v.status == 'effective') {
          notifications.add(InAppNotification(
            type: 'qa_approved',
            courseTitle: course.title,
            dueDate: DateTime.now().toIso8601String(),
            message: 'Course "${course.title}" v${v.version} has been approved and published',
          ));
        } else if (v.status == 'needs_revision') {
          notifications.add(InAppNotification(
            type: 'qa_returned',
            courseTitle: course.title,
            dueDate: DateTime.now().toIso8601String(),
            message: 'Course "${course.title}" v${v.version} returned for changes',
          ));
        }
      }
    }
    
    final persistedNotifications = await Notification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.readAt.equals(null),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 20,
    );
    
    for (final n in persistedNotifications) {
      final msg = (n.body != null && n.body!.isNotEmpty)
          ? n.body!
          : switch (n.type) {
              'sme_invite' => 'SME review: you were invited to review a course.',
              'sme_comment' => 'New SME comment on your course.',
              'sme_resolved' => 'An SME comment was resolved by the trainer.',
              _ => 'You have a ${n.type} notification',
            };
      notifications.add(InAppNotification(
        type: n.type,
        courseTitle: 'Notification',
        dueDate: n.createdAt.toIso8601String(),
        message: msg,
      ));
    }
    
    return notifications;
  }

  /// Mark a notification as read.
  Future<bool> markNotificationRead(
    Session session, {
    required int notificationId,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return false;
    final notification = await Notification.db.findById(session, notificationId);
    if (notification == null) return false;
    
    final updated = notification.copyWith(readAt: DateTime.now());
    await Notification.db.updateRow(session, updated);
    return true;
  }

  /// Get count of unread notifications for badge display.
  Future<int> getUnreadCount(
    Session session,
    int userId,
  ) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return 0;
    return await Notification.db.count(
      session,
      where: (t) => t.userId.equals(userId) & t.readAt.equals(null),
    );
  }

  /// List all notifications for an organization (Admin Portal).
  Future<List<Notification>> listNotifications(
    Session session, {
    required int organizationId,
    String? type,
    String? channel,
    String? deliveryStatus,
    int? limit,
  }) async {
    if (await RbacHelper.getCurrentPharmaUser(session) == null) return [];
    if (!await RbacHelper.hasPermission(session, resource: 'notification', action: 'read')) return [];
    
    // Get all users in the organization first
    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );
    final userIds = users.map((u) => u.id!).toList();
    
    if (userIds.isEmpty) return [];
    
    // Build where expression
    var whereExpr = Notification.t.userId.inSet(userIds.toSet());
    
    if (type != null && type.isNotEmpty) {
      whereExpr = whereExpr & Notification.t.type.equals(type);
    }
    
    if (channel != null && channel.isNotEmpty) {
      whereExpr = whereExpr & Notification.t.channel.equals(channel);
    }
    
    if (deliveryStatus != null && deliveryStatus.isNotEmpty) {
      whereExpr = whereExpr & Notification.t.deliveryStatus.equals(deliveryStatus);
    }
    
    return await Notification.db.find(
      session,
      where: (t) => whereExpr,
      include: Notification.include(
        user: PharmaUser.include(),
        enrollment: Enrollment.include(
          courseVersion: CourseVersion.include(course: Course.include()),
        ),
      ),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit ?? 100,
    );
  }

  /// Create one in-app notification per user in the organization (admin broadcast).
  Future<int> broadcastInAppToOrganization(
    Session session, {
    required int organizationId,
    required String message,
    String type = 'admin_broadcast',
  }) async {
    await RbacHelper.requirePermission(session, resource: 'users', action: 'update');
    final body = message.trim();
    if (body.isEmpty) throw Exception('Message is required');

    final users = await PharmaUser.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
    );

    var count = 0;
    for (final u in users) {
      final id = u.id;
      if (id == null) continue;
      await Notification.db.insertRow(
        session,
        Notification(
          userId: id,
          type: type,
          body: body,
          deliveryStatus: 'queued',
          channel: 'in_app',
        ),
      );
      // Push realtime notification so user sees it instantly
      RealtimeHub.instance.broadcast('notifications:user:$id', {
        'event': 'notification',
        'type': type,
        'message': body,
        'ts': DateTime.now().toUtc().toIso8601String(),
      });
      count++;
    }
    return count;
  }
}
