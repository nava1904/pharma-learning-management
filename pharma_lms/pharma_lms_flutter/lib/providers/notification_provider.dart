import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/client.dart';
import '../core/lms_realtime.dart';
import 'user_provider.dart';
import 'dashboard_providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — REAL-TIME NOTIFICATION PROVIDER (WebSocket + Polling Fallback)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Fetches in-app notifications from Serverpod backend:
//   - Overdue training assignments
//   - Due-soon training (within 7 days)
//   - Certificate expiry alerts (within 30/60/90 days)
//   - Training assigned notifications
//   - Assessment completion events
//
// PRIMARY: WebSocket push via LmsRealtime (sub-second latency).
// FALLBACK: Polls every 30 seconds if WebSocket is unavailable.
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

  // 1b. Fetch admin/broadcast notifications (persisted Notification table)
  try {
    final userNotifs = await client.notification.getUserNotifications(user!.id!);
    for (final n in userNotifs) {
      notifications.add(NotificationItem(
        id: 'admin_${n.id ?? 0}',
        type: n.type,
        title: n.type == 'admin_broadcast' ? 'Announcement' : n.type,
        message: n.body ?? '',
        dueDate: null,
        timestamp: n.createdAt,
        severity: 'info',
        assignmentId: null,
        certificateId: null,
        isRead: n.readAt != null,
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

/// Connects to the WebSocket and subscribes to `notifications:user:<id>`.
/// On each push event, invalidates [notificationsProvider] for instant refresh.
/// Falls back to 30-second polling if WebSocket fails to connect.
final notificationRealtimeProvider = Provider.autoDispose<void>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user?.id == null) return;

  final userId = user!.id!;
  StreamSubscription<Map<String, dynamic>>? wsSub;
  Timer? pollTimer;
  bool wsConnected = false;

  // Try WebSocket first
  () async {
    try {
      await LmsRealtime.ensureConnected();
      LmsRealtime.subscribeRooms(['notifications:user:$userId']);
      wsConnected = true;

      wsSub = LmsRealtime.events.listen((event) {
        final eventType = event['event'] as String?;
        if (eventType == 'notification') {
          // Instant refresh on push notification
          ref.invalidate(notificationsProvider);

        }
      });
    } catch (e) {

    }

    // Polling fallback: 30s if WebSocket connected (light keep-alive), or primary if not
    final interval = wsConnected
        ? const Duration(seconds: 60)  // WS connected: light polling as backup
        : const Duration(seconds: 30); // WS failed: aggressive polling
    pollTimer = Timer.periodic(interval, (_) {
      ref.invalidate(notificationsProvider);
    });
  }();

  ref.onDispose(() {
    wsSub?.cancel();
    pollTimer?.cancel();
    if (wsConnected) {
      LmsRealtime.unsubscribeRooms(['notifications:user:$userId']);
    }
  });
});

/// Auto-refresh timer — invalidates notifications every 30 seconds (fallback).
/// DEPRECATED in favor of [notificationRealtimeProvider] — kept for backward compat.
final notificationRefreshTimerProvider = Provider.autoDispose<Timer>((ref) {
  // Ensure realtime provider is active
  ref.watch(notificationRealtimeProvider);
  final timer = Timer.periodic(const Duration(seconds: 30), (_) {
    ref.invalidate(notificationsProvider);
  });
  ref.onDispose(() => timer.cancel());
  return timer;
});
