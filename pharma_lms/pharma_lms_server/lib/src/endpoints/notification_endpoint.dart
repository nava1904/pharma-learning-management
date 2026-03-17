import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rbac_helper.dart';

/// Notification domain endpoint (in-app; no email/push in stub).
class NotificationEndpoint extends Endpoint {
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
      notifications.add(InAppNotification(
        type: n.type,
        courseTitle: 'Notification',
        dueDate: n.createdAt.toIso8601String(),
        message: 'You have a ${n.type} notification',
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
}
