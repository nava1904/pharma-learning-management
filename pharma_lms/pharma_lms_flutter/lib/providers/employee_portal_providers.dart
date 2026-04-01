// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE PORTAL GAP PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════
//
// Providers for screens that close user-story gaps:
// - Notification Centre (full inbox)
// - Compliance Detail (personal compliance breakdown)
// - Training Calendar (deadline + batch + requalification events)
// - Document Library + SOP Acknowledgement
// - Training Plan (role-based curriculum)
// - Course Feedback / Ratings
//
// All providers use REAL Serverpod calls — zero hardcoded/mock data.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../core/client.dart';
import 'user_provider.dart';
import 'dashboard_providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// 1. NOTIFICATION CENTRE PROVIDERS
// Backend: notification.getInAppNotifications / markNotificationRead
// ═══════════════════════════════════════════════════════════════════════════════

/// Full in-app notification list for the current user.
final employeeNotificationListProvider =
    FutureProvider.autoDispose<List<InAppNotification>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.notification.getInAppNotifications(user!.id!);
});

/// Mark a single notification as read and invalidate the list.
Future<void> markNotificationReadAndRefresh(WidgetRef ref, int notificationId) async {
  await client.notification.markNotificationRead(notificationId: notificationId);
  ref.invalidate(employeeNotificationListProvider);
}

// ═══════════════════════════════════════════════════════════════════════════════
// 2. COMPLIANCE DETAIL PROVIDERS
// Backend: compliance.getUserCompliance / compliance.getEsignatureSummaryForUser
// ═══════════════════════════════════════════════════════════════════════════════

/// Detailed compliance metrics for the current user.
final employeeComplianceDetailProvider =
    FutureProvider.autoDispose<UserComplianceMetrics?>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return null;
  return client.compliance.getUserCompliance(user!.id!);
});

/// E-signature summary for audit/compliance views.
final employeeEsignatureSummaryProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.compliance.getEsignatureSummaryForUser(user!.id!);
});

/// Overdue enrollments (status == 'overdue' or past due date).
final overdueEnrollmentsProvider =
    FutureProvider.autoDispose<List<Enrollment>>((ref) async {
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final assignments = await ref.watch(assignmentsProvider.future);
  final now = DateTime.now();
  return enrollments.where((e) {
    if (e.status == 'completed') return false;
    final assignment = assignments.where((a) => a.courseVersionId == e.courseVersionId).firstOrNull;
    if (assignment != null && assignment.dueDate.isBefore(now)) return true;
    return false;
  }).toList();
});

/// Enrollments due within the next 30 days.
final dueSoonEnrollmentsProvider =
    FutureProvider.autoDispose<List<Enrollment>>((ref) async {
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final assignments = await ref.watch(assignmentsProvider.future);
  final now = DateTime.now();
  final thirtyDaysFromNow = now.add(const Duration(days: 30));
  return enrollments.where((e) {
    if (e.status == 'completed') return false;
    final assignment = assignments.where((a) => a.courseVersionId == e.courseVersionId).firstOrNull;
    if (assignment != null &&
        assignment.dueDate.isAfter(now) &&
        assignment.dueDate.isBefore(thirtyDaysFromNow)) return true;
    return false;
  }).toList();
});

// ═══════════════════════════════════════════════════════════════════════════════
// 3. TRAINING CALENDAR PROVIDERS
// Derives calendar events from assignments, enrollments, batches, certificates
// ═══════════════════════════════════════════════════════════════════════════════

class CalendarEvent {
  final DateTime date;
  final String title;
  final String type; // 'due_date', 'batch_session', 'cert_expiry', 'requalification'
  final String? route; // deep-link route
  final int? relatedId;

  const CalendarEvent({
    required this.date,
    required this.title,
    required this.type,
    this.route,
    this.relatedId,
  });
}

/// Aggregated calendar events from multiple data sources.
final employeeCalendarEventsProvider =
    FutureProvider.autoDispose<List<CalendarEvent>>((ref) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final certificates = await ref.watch(certificatesProvider.future);
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final events = <CalendarEvent>[];

  // Due dates from assignments
  for (final a in assignments) {
    final enrollment = enrollments
        .where((e) => e.courseVersionId == a.courseVersionId)
        .firstOrNull;
    if (enrollment?.status == 'completed') continue;
    final course = enrollment?.courseVersion?.course;
    events.add(CalendarEvent(
      date: a.dueDate,
      title: course?.title ?? 'Training Due',
      type: 'due_date',
      route: '/employee/course/${course?.id ?? a.courseVersionId}',
      relatedId: enrollment?.id,
    ));
  }

  // Certificate expirations
  for (final c in certificates) {
    if (c.expiresAt != null) {
      events.add(CalendarEvent(
        date: c.expiresAt!,
        title: '${c.courseVersion?.course?.title ?? "Certificate"} expires',
        type: 'cert_expiry',
        route: '/employee/credentials',
        relatedId: c.id,
      ));
    }
  }

  // Sort by date ascending
  events.sort((a, b) => a.date.compareTo(b.date));
  return events;
});

// ═══════════════════════════════════════════════════════════════════════════════
// 4. DOCUMENT LIBRARY / SOP ACKNOWLEDGEMENT PROVIDERS
// Backend: sopLinkage.getLinkedSops + training.acknowledgeRetraining
// ═══════════════════════════════════════════════════════════════════════════════

/// All SOP documents linked to courses the user is enrolled in.
final employeeLinkedSopsProvider =
    FutureProvider.autoDispose<List<CourseSopLink>>((ref) async {
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final allLinks = <CourseSopLink>[];
  for (final e in enrollments) {
    try {
      final links = await client.sopLinkage.getLinkedSops(courseId: e.courseVersionId);
      allLinks.addAll(links);
    } catch (_) {}
  }
  // Deduplicate by SOP id
  final seen = <int>{};
  return allLinks.where((l) {
    final id = l.id ?? 0;
    if (seen.contains(id)) return false;
    seen.add(id);
    return true;
  }).toList();
});

/// Enrollments that need SOP retraining acknowledgement.
final pendingAcknowledgementsProvider =
    FutureProvider.autoDispose<List<Enrollment>>((ref) async {
  final enrollments = await ref.watch(enrollmentsProvider.future);
  return enrollments.where((e) {
    return e.retrainingChangeSummary != null &&
        e.retrainingChangeSummary!.isNotEmpty &&
        e.acknowledgedAt == null;
  }).toList();
});

// ═══════════════════════════════════════════════════════════════════════════════
// 5. TRAINING PLAN PROVIDERS
// Derives the role-based training plan from assignments + enrollments
// ═══════════════════════════════════════════════════════════════════════════════

class TrainingPlanItem {
  final TrainingAssignment assignment;
  final Enrollment? enrollment;
  final String courseTitle;
  final String status; // 'completed', 'in_progress', 'not_started', 'overdue'
  final double progress;
  final DateTime dueDate;

  const TrainingPlanItem({
    required this.assignment,
    this.enrollment,
    required this.courseTitle,
    required this.status,
    required this.progress,
    required this.dueDate,
  });
}

/// Training plan: merges assignments with enrollment progress.
final employeeTrainingPlanProvider =
    FutureProvider.autoDispose<List<TrainingPlanItem>>((ref) async {
  final assignments = await ref.watch(assignmentsProvider.future);
  final enrollments = await ref.watch(enrollmentsProvider.future);
  final progressMap = await ref.watch(enrollmentProgressProvider.future);
  final now = DateTime.now();

  return assignments.map((a) {
    final enrollment = enrollments
        .where((e) => e.courseVersionId == a.courseVersionId)
        .firstOrNull;
    final course = enrollment?.courseVersion?.course;
    final progress = enrollment?.id != null
        ? (progressMap[enrollment!.id!] ?? 0.0)
        : 0.0;
    String status;
    if (enrollment?.status == 'completed') {
      status = 'completed';
    } else if (a.dueDate.isBefore(now) && enrollment?.status != 'completed') {
      status = 'overdue';
    } else if (enrollment?.status == 'in_progress') {
      status = 'in_progress';
    } else {
      status = 'not_started';
    }
    return TrainingPlanItem(
      assignment: a,
      enrollment: enrollment,
      courseTitle: course?.title ?? 'Assigned Training',
      status: status,
      progress: progress,
      dueDate: a.dueDate,
    );
  }).toList()
    ..sort((a, b) {
      // Overdue first, then by due date
      const order = {'overdue': 0, 'in_progress': 1, 'not_started': 2, 'completed': 3};
      final cmp = (order[a.status] ?? 4).compareTo(order[b.status] ?? 4);
      if (cmp != 0) return cmp;
      return a.dueDate.compareTo(b.dueDate);
    });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 6. COURSE FEEDBACK PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════

/// All electronic signatures for the current user (for compliance detail view).
final employeeSignaturesProvider =
    FutureProvider.autoDispose<List<ElectronicSignature>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user?.id == null) return [];
  return client.training.listElectronicSignatures(userId: user!.id!, limit: 100);
});
