import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pharma_lms_client/pharma_lms_client.dart' as lms show Notification;

import '../core/client.dart';
import '../providers/user_provider.dart';

// ──────────────────────────────────────────────────────────────────
// Unread counts (for badges)
// ──────────────────────────────────────────────────────────────────

/// Typed unread counts across all messaging channels.
final messagingUnreadCountsProvider =
    FutureProvider.autoDispose<MessagingUnreadCounts>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getUnreadCounts();
  } catch (_) {
    return MessagingUnreadCounts(learnerTrainer: 0, qaReview: 0, total: 0);
  }
});

/// Total unread notification count.
final unreadNotificationCountProvider =
    FutureProvider.autoDispose<int>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getUnreadNotificationCount();
  } catch (_) {
    return 0;
  }
});

// ──────────────────────────────────────────────────────────────────
// Trainer inbox
// ──────────────────────────────────────────────────────────────────

/// Trainer learner-support inbox (paginated).
final trainerInboxProvider =
    FutureProvider.autoDispose<List<LearnerSupportThreadSummary>>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getTrainerInbox(limit: 20, offset: 0);
  } catch (_) {
    return [];
  }
});

/// Trainer QA review inbox (paginated).
final trainerQaInboxProvider =
    FutureProvider.autoDispose<List<SmeThreadSummary>>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getQaInbox(limit: 20, offset: 0);
  } catch (_) {
    return [];
  }
});

// ──────────────────────────────────────────────────────────────────
// Learner inbox
// ──────────────────────────────────────────────────────────────────

/// Learner (employee) message inbox (paginated).
final learnerInboxProvider =
    FutureProvider.autoDispose<List<LearnerSupportThreadSummary>>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getLearnerInbox(limit: 20, offset: 0);
  } catch (_) {
    return [];
  }
});

// ──────────────────────────────────────────────────────────────────
// QA reviewer inbox
// ──────────────────────────────────────────────────────────────────

/// QA reviewer (SME) inbox (paginated).
final qaReviewerInboxProvider =
    FutureProvider.autoDispose<List<SmeThreadSummary>>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getQaReviewerInbox(limit: 20, offset: 0);
  } catch (_) {
    return [];
  }
});

// ──────────────────────────────────────────────────────────────────
// Notifications
// ──────────────────────────────────────────────────────────────────

/// Paginated notifications — returns typed Notification list.
final notificationsProvider =
    FutureProvider.autoDispose<List<lms.Notification>>((ref) async {
  ref.watch(currentUserProvider);
  try {
    return await client.messaging.getNotifications(limit: 20, offset: 0);
  } catch (_) {
    return [];
  }
});
