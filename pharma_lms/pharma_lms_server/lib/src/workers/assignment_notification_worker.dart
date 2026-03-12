import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/email_service.dart';

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
      include: TrainingAssignment.include(
        user: PharmaUser.include(),
        courseVersion: CourseVersion.include(course: Course.include()),
      ),
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
        final courseTitle = a.courseVersion?.course?.title ?? 'Training';
        final subject = _subjectForType(notifType, courseTitle);
        final body = _bodyForType(notifType, courseTitle, a.dueDate);
        final email = a.user?.email;
        if (email != null && email.isNotEmpty) {
          unawaited(EmailService.sendNotificationEmail(
            session,
            email: email,
            subject: subject,
            body: body,
          ));
        }
        count++;
      }
    }
    session.log(
      '[AssignmentNotificationWorker] Processed ${assignments.length} assignments, created $count notifications',
    );
  }

  static String _subjectForType(String notifType, String courseTitle) {
    switch (notifType) {
      case 'reminder_30d':
        return 'Pharma LMS: Training reminder – $courseTitle (30 days until due)';
      case 'reminder_14d':
        return 'Pharma LMS: Training reminder – $courseTitle (14 days until due)';
      case 'reminder_7d':
        return 'Pharma LMS: Training reminder – $courseTitle (7 days until due)';
      case 'reminder_3d':
        return 'Pharma LMS: Training reminder – $courseTitle (3 days until due)';
      case 'assignment_due':
        return 'Pharma LMS: Training due today – $courseTitle';
      case 'overdue_1d':
        return 'Pharma LMS: Training overdue – $courseTitle (1 day)';
      case 'overdue_3d':
        return 'Pharma LMS: Training overdue – $courseTitle (3 days)';
      case 'overdue_7d':
        return 'Pharma LMS: Training overdue – $courseTitle (7 days)';
      case 'overdue_14d':
        return 'Pharma LMS: Training overdue – $courseTitle (14 days)';
      default:
        return 'Pharma LMS: Training notification – $courseTitle';
    }
  }

  static String _bodyForType(
    String notifType,
    String courseTitle,
    DateTime dueDate,
  ) {
    final dueStr = dueDate.toIso8601String().split('T').first;
    switch (notifType) {
      case 'reminder_30d':
        return 'Reminder: Your training "$courseTitle" is due in 30 days ($dueStr). Please complete it before the due date.';
      case 'reminder_14d':
        return 'Reminder: Your training "$courseTitle" is due in 14 days ($dueStr). Please complete it before the due date.';
      case 'reminder_7d':
        return 'Reminder: Your training "$courseTitle" is due in 7 days ($dueStr). Please complete it before the due date.';
      case 'reminder_3d':
        return 'Reminder: Your training "$courseTitle" is due in 3 days ($dueStr). Please complete it before the due date.';
      case 'assignment_due':
        return 'Your training "$courseTitle" is due today ($dueStr). Please complete it as soon as possible.';
      case 'overdue_1d':
        return 'Your training "$courseTitle" was due on $dueStr and is now 1 day overdue. Please complete it as soon as possible.';
      case 'overdue_3d':
        return 'Your training "$courseTitle" was due on $dueStr and is now 3 days overdue. Please complete it as soon as possible.';
      case 'overdue_7d':
        return 'Your training "$courseTitle" was due on $dueStr and is now 7 days overdue. Please complete it as soon as possible.';
      case 'overdue_14d':
        return 'Your training "$courseTitle" was due on $dueStr and is now 14 days overdue. Please complete it as soon as possible.';
      default:
        return 'Training notification for "$courseTitle" (due $dueStr).';
    }
  }
}
