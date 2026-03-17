import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/client.dart';
import 'user_provider.dart';
import 'dashboard_providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — REAL-TIME NOTIFICATION PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════
//
// Fetches in-app notifications from Serverpod backend:
//   - Overdue training assignments
//   - Due-soon training (within 7 days)
//   - Certificate expiry alerts (within 30/60/90 days)
//   - Training assigned notifications
//   - Assessment completion events
//
// Auto-refreshes every 60 seconds for real-time tracking.
// ═══════════════════════════════════════════════════════════════════════════════

/// Combined notification item for the UI (assignments + certificates + events).
class NotificationItem {
  final String id;
  final String type; // 'overdue', 'due_soon', 'cert_expiring', 'training_assigned', 'assessment_complete', 'sop_update'
  final String title;
  final String message;
  final String? dueDate;
  final DateTime timestamp;
  final bool isRead;
  final String severity; // 'critical', 'warning', 'info'
  final int? assignmentId;
  final int? certificateId;

  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.dueDate,
    required this.timestamp,
    this.isRead = false,
    required this.severity,
    this.assignmentId,
    this.certificateId,
  });
}

/// Provider that fetches real notifications from the backend.
/// Auto-refreshes every 60 seconds for real-time tracking.
final notificationsProvider = FutureProvider.autoDispose<List<NotificationItem>>((ref) async {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user?.id == null) return [];

  final notifications = <NotificationItem>[];

  // 1. Fetch assignment-based notifications (overdue + due soon)
  try {
    final inAppNotifs = await client.notification.getInAppNotifications(user!.id!);
    for (final n in inAppNotifs) {
      notifications.add(NotificationItem(
        id: 'assignment_${n.assignmentId ?? 0}',
        type: n.type,
        title: n.courseTitle,
        message: n.message,
        dueDate: n.dueDate,
        timestamp: DateTime.now(),
        severity: n.type == 'overdue' ? 'critical' : 'warning',
        assignmentId: n.assignmentId,
      ));
    }
  } catch (_) {}

  // 2. Fetch certificate expiry notifications
  try {
    final certificates = ref.watch(certificatesProvider).valueOrNull ?? [];
    final now = DateTime.now();
    for (final cert in certificates) {
      if (cert.status == 'active' && cert.expiresAt != null) {
        final daysUntilExpiry = cert.expiresAt!.difference(now).inDays;
        final courseTitle = cert.courseVersion?.course?.title ?? 'Certificate #${cert.id}';
        
        if (daysUntilExpiry <= 0) {
          notifications.add(NotificationItem(
            id: 'cert_expired_${cert.id}',
            type: 'cert_expiring',
            title: 'Certificate Expired',
            message: '$courseTitle certificate has expired. Retraining required.',
            dueDate: cert.expiresAt?.toIso8601String(),
            timestamp: now,
            severity: 'critical',
            certificateId: cert.id,
          ));
        } else if (daysUntilExpiry <= 30) {
          notifications.add(NotificationItem(
            id: 'cert_expiring_30_${cert.id}',
            type: 'cert_expiring',
            title: 'Certificate Expiring Soon',
            message: '$courseTitle expires in $daysUntilExpiry day${daysUntilExpiry == 1 ? '' : 's'}.',
            dueDate: cert.expiresAt?.toIso8601String(),
            timestamp: now,
            severity: 'critical',
            certificateId: cert.id,
          ));
        } else if (daysUntilExpiry <= 60) {
          notifications.add(NotificationItem(
            id: 'cert_expiring_60_${cert.id}',
            type: 'cert_expiring',
            title: 'Certificate Expiring',
            message: '$courseTitle expires in $daysUntilExpiry days.',
            dueDate: cert.expiresAt?.toIso8601String(),
            timestamp: now,
            severity: 'warning',
            certificateId: cert.id,
          ));
        } else if (daysUntilExpiry <= 90) {
          notifications.add(NotificationItem(
            id: 'cert_expiring_90_${cert.id}',
            type: 'cert_expiring',
            title: 'Certificate Renewal Notice',
            message: '$courseTitle expires in $daysUntilExpiry days. Plan retraining.',
            dueDate: cert.expiresAt?.toIso8601String(),
            timestamp: now,
            severity: 'info',
            certificateId: cert.id,
          ));
        }
      }
    }
  } catch (_) {}

  // 3. Fetch new training assignments (not yet started)
  try {
    final assignments = ref.watch(assignmentsProvider).valueOrNull ?? [];
    final enrollments = ref.watch(enrollmentsProvider).valueOrNull ?? [];
    final enrolledCvIds = enrollments.map((e) => e.courseVersionId).toSet();
    
    for (final a in assignments) {
      // Notify about new assignments not yet enrolled
      final courseTitle = a.courseVersion?.course?.title ?? 'Training';
      final isEnrolled = enrolledCvIds.contains(a.courseVersionId);
      
      if (!isEnrolled) {
        notifications.add(NotificationItem(
          id: 'new_assignment_${a.id}',
          type: 'training_assigned',
          title: 'New Training Assigned',
          message: '$courseTitle has been assigned to you.',
          dueDate: a.dueDate.toIso8601String(),
          timestamp: a.assignedAt,
          severity: 'info',
          assignmentId: a.id,
        ));
      }
    }
  } catch (_) {}

  // Sort: critical first, then by timestamp descending
  notifications.sort((a, b) {
    final severityOrder = {'critical': 0, 'warning': 1, 'info': 2};
    final severityCompare = (severityOrder[a.severity] ?? 3).compareTo(severityOrder[b.severity] ?? 3);
    if (severityCompare != 0) return severityCompare;
    return b.timestamp.compareTo(a.timestamp);
  });

  return notifications;
});

/// Unread notification count for the badge.
final unreadNotificationCountProvider = Provider<int>((ref) {
  final notifs = ref.watch(notificationsProvider).valueOrNull ?? [];
  return notifs.where((n) => !n.isRead).length;
});

/// Auto-refresh timer — invalidates notifications every 60 seconds.
final notificationRefreshTimerProvider = Provider.autoDispose<Timer>((ref) {
  final timer = Timer.periodic(const Duration(seconds: 60), (_) {
    ref.invalidate(notificationsProvider);
  });
  ref.onDispose(() => timer.cancel());
  return timer;
});
