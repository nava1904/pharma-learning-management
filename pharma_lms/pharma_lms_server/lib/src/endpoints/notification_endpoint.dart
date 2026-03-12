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
}
