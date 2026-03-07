import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Finds assignments due in 7 days with status not_started; for in-app display.
/// In production would insert into notification table or OutboxMessage for push.
class AssignmentNotificationWorker {
  /// Run notification check - assignments due in 7 days.
  static Future<void> run(Session session) async {
    final now = DateTime.now();
    final threshold = now.add(const Duration(days: 7));

    final assignments = await TrainingAssignment.db.find(session);
    var count = 0;
    for (final a in assignments) {
      if (a.dueDate.isAfter(now) && a.dueDate.isBefore(threshold)) {
        final enrollments = await Enrollment.db.find(
          session,
          where: (t) =>
              t.userId.equals(a.userId) &
              t.courseVersionId.equals(a.courseVersionId),
        );
        final notStarted = enrollments.isEmpty ||
            enrollments.every((e) => e.status == 'not_started');
        if (notStarted) count++;
      }
    }
    session.log('[AssignmentNotificationWorker] Found $count assignments due in 7 days');
  }
}
