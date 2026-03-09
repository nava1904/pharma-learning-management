import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Full assignment notification ladder (SYS-03).
/// Ladder: -30d, -14d, -7d, -3d, due, +1d, +3d, +7d, +14d overdue.
class AssignmentNotificationWorker {
  static const _ladder = [
    (-30, 'reminder_30d'),
    (-14, 'reminder_14d'),
    (-7, 'reminder_7d'),
    (-3, 'reminder_3d'),
    (0, 'assignment_due'),
    (1, 'overdue_1d'),
    (3, 'overdue_3d'),
    (7, 'overdue_7d'),
    (14, 'overdue_14d'),
  ];

  /// Run notification check - full ladder.
  static Future<void> run(Session session) async {
    final now = DateTime.now();
    final assignments = await TrainingAssignment.db.find(
      session,
      where: (t) => t.status.equals('active'),
    );

    var count = 0;
    for (final a in assignments) {
      final daysUntilDue = a.dueDate.difference(now).inDays;

      for (final entry in _ladder) {
        final targetDays = entry.$1;
        final notifType = entry.$2;
        final matches = targetDays <= 0
            ? daysUntilDue == targetDays
            : daysUntilDue == -targetDays;
        if (!matches) continue;

        final enrollments = await Enrollment.db.find(
          session,
          where: (t) =>
              t.userId.equals(a.userId) &
              t.courseVersionId.equals(a.courseVersionId),
        );
        final notStarted = enrollments.isEmpty ||
            enrollments.every((e) => e.status == 'not_started');
        if (targetDays > 0 && !notStarted) continue;

        final enrollmentId = enrollments.isNotEmpty ? enrollments.first.id : null;
        final recent = await Notification.db.find(
          session,
          where: (t) =>
              t.userId.equals(a.userId) &
              t.type.equals(notifType),
          limit: 5,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );
        final lastSent = recent.isNotEmpty ? recent.first.createdAt : null;
        if (lastSent != null && now.difference(lastSent).inHours < 24) {
          continue;
        }

        await Notification.db.insertRow(
          session,
          Notification(
            userId: a.userId,
            type: notifType,
            enrollmentId: enrollmentId,
            channel: 'in_app',
          ),
        );
        count++;
      }
    }
    session.log(
      '[AssignmentNotificationWorker] Processed ${assignments.length} assignments, created $count notifications',
    );
  }
}
