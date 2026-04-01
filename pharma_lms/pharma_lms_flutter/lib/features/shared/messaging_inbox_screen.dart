import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material, Notification;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/auth_provider.dart';
import '../../providers/messaging_providers.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';

/// Unified messaging inbox — works for employees, trainers, and QA reviewers.
/// Displays tabs for:
/// - Instructor Messages (learner↔trainer threads)
/// - QA Review (SME review threads) — only shown for trainers/QA roles
/// - Notifications (in-app notifications)
class MessagingInboxScreen extends ConsumerStatefulWidget {
  const MessagingInboxScreen({super.key});

  @override
  ConsumerState<MessagingInboxScreen> createState() => _MessagingInboxScreenState();
}

class _MessagingInboxScreenState extends ConsumerState<MessagingInboxScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTrainerOrQa = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshAll() {
    ref.invalidate(messagingUnreadCountsProvider);
    ref.invalidate(trainerInboxProvider);
    ref.invalidate(trainerQaInboxProvider);
    ref.invalidate(learnerInboxProvider);
    ref.invalidate(qaReviewerInboxProvider);
    ref.invalidate(unreadNotificationCountProvider);
    ref.invalidate(notificationsProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currentUserProvider);
    final unreadAsync = ref.watch(messagingUnreadCountsProvider);
    final selectedRole = ref.watch(selectedRoleProvider);

    final ltUnread = unreadAsync.valueOrNull?.learnerTrainer ?? 0;
    final qaUnread = unreadAsync.valueOrNull?.qaReview ?? 0;
    _isTrainerOrQa = selectedRole == AppRole.trainer ||
        selectedRole == AppRole.qa ||
        selectedRole == AppRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshAll,
            tooltip: 'Refresh',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 18),
                  const SizedBox(width: 6),
                  const Text('Messages'),
                  if (ltUnread > 0) ...[
                    const SizedBox(width: 6),
                    _UnreadBadge(count: ltUnread),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.rate_review_outlined, size: 18),
                  const SizedBox(width: 6),
                  const Text('QA Review'),
                  if (qaUnread > 0) ...[
                    const SizedBox(width: 6),
                    _UnreadBadge(count: qaUnread),
                  ],
                ],
              ),
            ),
            const Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_outlined, size: 18),
                  SizedBox(width: 6),
                  Text('Notifications'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _LearnerTrainerInboxTab(isTrainer: _isTrainerOrQa, onRefresh: _refreshAll),
          _QaReviewInboxTab(isTrainer: _isTrainerOrQa, onRefresh: _refreshAll),
          _NotificationsTab(onRefresh: _refreshAll),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Tab 1: Learner ↔ Trainer Messages
// ──────────────────────────────────────────────────────────────────

class _LearnerTrainerInboxTab extends ConsumerWidget {
  const _LearnerTrainerInboxTab({required this.isTrainer, required this.onRefresh});
  final bool isTrainer;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inboxAsync = isTrainer
        ? ref.watch(trainerInboxProvider)
        : ref.watch(learnerInboxProvider);

    return inboxAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error loading messages', style: PharmaTypography.body),
            const SizedBox(height: 8),
            FilledButton(onPressed: onRefresh, child: const Text('Retry')),
          ],
        ),
      ),
      data: (threads) {
        if (threads.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chat_bubble_outline, size: 64, color: PharmaColors.textTertiary),
                const SizedBox(height: 12),
                Text(
                  'No message threads yet',
                  style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.textTertiary),
                ),
                const SizedBox(height: 4),
                Text(
                  isTrainer
                      ? 'Learner messages will appear here when they contact you.'
                      : 'Messages with your instructors will appear here.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: ListView.builder(
            padding: const EdgeInsets.all(PharmaSpacing.md),
            itemCount: threads.length,
            itemBuilder: (context, i) {
              final thread = threads[i];
              return _LearnerThreadCard(
                thread: thread,
                onTap: () async {
                  await openLearnerInstructorChat(
                    context,
                    courseVersionId: thread.courseVersionId,
                    courseTitle: thread.courseTitle,
                  );
                  onRefresh();
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _LearnerThreadCard extends StatelessWidget {
  const _LearnerThreadCard({required this.thread, required this.onTap});
  final LearnerSupportThreadSummary thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasUnread = thread.unreadForTrainer > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.sm),
      elevation: hasUnread ? 2 : 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: hasUnread
            ? BorderSide(color: PharmaColors.emerald600, width: 1.5)
            : BorderSide(color: PharmaColors.border, width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: hasUnread ? PharmaColors.emerald600 : PharmaColors.pageBg,
                child: Icon(
                  Icons.chat_bubble,
                  color: hasUnread ? Colors.white : PharmaColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.courseTitle,
                      style: PharmaTypography.body.copyWith(
                        fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${thread.lastFromName}: ${thread.lastMessageBody}',
                      style: PharmaTypography.caption.copyWith(
                        color: hasUnread ? PharmaColors.textPrimary : PharmaColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(thread.lastMessageAt),
                    style: PharmaTypography.caption.copyWith(
                      color: hasUnread ? PharmaColors.emerald600 : PharmaColors.textTertiary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (hasUnread) _UnreadBadge(count: thread.unreadForTrainer),
                  if (!hasUnread)
                    Text(
                      '${thread.messageCount} msgs',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Tab 2: QA / SME Review
// ──────────────────────────────────────────────────────────────────

class _QaReviewInboxTab extends ConsumerWidget {
  const _QaReviewInboxTab({required this.isTrainer, required this.onRefresh});
  final bool isTrainer;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inboxAsync = isTrainer
        ? ref.watch(trainerQaInboxProvider)
        : ref.watch(qaReviewerInboxProvider);

    return inboxAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error loading QA threads', style: PharmaTypography.body),
            const SizedBox(height: 8),
            FilledButton(onPressed: onRefresh, child: const Text('Retry')),
          ],
        ),
      ),
      data: (threads) {
        if (threads.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.rate_review_outlined, size: 64, color: PharmaColors.textTertiary),
                const SizedBox(height: 12),
                Text(
                  'No QA review threads',
                  style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.textTertiary),
                ),
                const SizedBox(height: 4),
                Text(
                  isTrainer
                      ? 'SME/QA review comments on your courses will appear here.'
                      : 'Courses assigned to you for review will appear here.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: ListView.builder(
            padding: const EdgeInsets.all(PharmaSpacing.md),
            itemCount: threads.length,
            itemBuilder: (context, i) {
              final thread = threads[i];
              return _QaThreadCard(
                thread: thread,
                onTap: () async {
                  await openCourseQaThreadForVersion(
                    context,
                    courseVersionId: thread.courseVersionId,
                    courseTitle: thread.courseTitle,
                  );
                  onRefresh();
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _QaThreadCard extends StatelessWidget {
  const _QaThreadCard({required this.thread, required this.onTap});
  final SmeThreadSummary thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasUnread = thread.unreadCount > 0;
    final hasUnresolved = thread.unresolvedCount > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.sm),
      elevation: hasUnread ? 2 : 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: hasUnread
            ? BorderSide(color: PharmaColors.warning, width: 1.5)
            : BorderSide(color: PharmaColors.border, width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(PharmaSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: hasUnresolved ? PharmaColors.warning : PharmaColors.emerald600,
                child: Icon(
                  hasUnresolved ? Icons.rate_review : Icons.check_circle,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.courseTitle,
                      style: PharmaTypography.body.copyWith(
                        fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${thread.lastFromName}: ${thread.lastCommentBody}',
                      style: PharmaTypography.caption.copyWith(
                        color: hasUnread ? PharmaColors.textPrimary : PharmaColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (hasUnresolved)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, size: 14, color: PharmaColors.warning),
                            const SizedBox(width: 4),
                            Text(
                              '${thread.unresolvedCount} unresolved',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(thread.lastCommentAt),
                    style: PharmaTypography.caption.copyWith(
                      color: hasUnread ? PharmaColors.warning : PharmaColors.textTertiary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (hasUnread) _UnreadBadge(count: thread.unreadCount, color: PharmaColors.warning),
                  if (!hasUnread)
                    Text(
                      '${thread.commentCount} comments',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Tab 3: Notifications
// ──────────────────────────────────────────────────────────────────

class _NotificationsTab extends ConsumerWidget {
  const _NotificationsTab({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.watch(notificationsProvider);

    return notifAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error loading notifications', style: PharmaTypography.body),
          ],
        ),
      ),
      data: (notifications) {
        if (notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications_none, size: 64, color: PharmaColors.textTertiary),
                const SizedBox(height: 12),
                Text(
                  'No notifications',
                  style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.textTertiary),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.md,
                vertical: PharmaSpacing.sm,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    await client.messaging.markAllNotificationsRead();
                    onRefresh();
                  },
                  icon: const Icon(Icons.done_all, size: 16),
                  label: const Text('Mark all read'),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => onRefresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
                  itemCount: notifications.length,
                  itemBuilder: (context, i) {
                    final n = notifications[i];
                    return _NotificationCard(
                      body: n.body ?? 'Notification',
                      type: n.type,
                      createdAt: n.createdAt,
                      isRead: n.readAt != null,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.body,
    required this.type,
    this.createdAt,
    required this.isRead,
  });
  final String body;
  final String type;
  final DateTime? createdAt;
  final bool isRead;

  IconData get _icon {
    switch (type) {
      case 'sme_invite':
        return Icons.person_add;
      case 'sme_comment':
        return Icons.rate_review;
      case 'sme_resolved':
        return Icons.check_circle;
      case 'learner_trainer_message':
        return Icons.chat_bubble;
      case 'assignment':
        return Icons.assignment;
      case 'reminder_30d':
      case 'reminder_14d':
      case 'reminder_7d':
      case 'reminder_3d':
        return Icons.alarm;
      case 'overdue':
        return Icons.warning;
      case 'compliance_alert':
        return Icons.shield;
      default:
        return Icons.notifications;
    }
  }

  Color get _iconColor {
    switch (type) {
      case 'overdue':
      case 'compliance_alert':
        return PharmaColors.danger;
      case 'sme_resolved':
        return PharmaColors.emerald600;
      case 'reminder_3d':
        return PharmaColors.warning;
      default:
        return PharmaColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.xs),
      elevation: isRead ? 0 : 1,
      color: isRead ? null : PharmaColors.emerald50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: PharmaColors.border, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.sm),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: _iconColor.withValues(alpha: 0.12),
              child: Icon(_icon, size: 18, color: _iconColor),
            ),
            const SizedBox(width: PharmaSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    body,
                    style: PharmaTypography.body.copyWith(
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (createdAt != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _formatTime(createdAt!),
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: PharmaColors.emerald600,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// Shared widgets
// ──────────────────────────────────────────────────────────────────

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count, this.color});
  final int count;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color ?? PharmaColors.emerald600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

String _formatTime(DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return DateFormat.MMMd().format(dt.toLocal());
}
