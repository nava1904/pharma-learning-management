// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — NOTIFICATION CENTRE (TRN-NC)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/notifications
// Displays trainer-specific notifications: QA decisions, SOP updates,
// assignment alerts, system messages, and learner ↔ instructor messages.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';
import 'widgets/trainer_page_scaffold.dart';

class NotificationCentreScreen extends ConsumerStatefulWidget {
  const NotificationCentreScreen({super.key});

  @override
  ConsumerState<NotificationCentreScreen> createState() =>
      _NotificationCentreScreenState();
}

class _NotificationCentreScreenState
    extends ConsumerState<NotificationCentreScreen> {
  List<InAppNotification> _notifications = [];
  List<LearnerSupportThreadSummary> _threads = [];
  bool _loading = true;
  bool _loadingThreads = true;
  String? _error;
  String? _threadsError;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    await Future.wait([_loadNotifications(), _loadMessageThreads()]);
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ref.read(currentUserProvider.future);
      if (user?.id != null) {
        final notifs =
            await client.notification.getTrainerNotifications(user!.id!);
        if (mounted) {
          setState(() {
            _notifications = notifs;
            _loading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _error = 'Not authenticated';
            _loading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadMessageThreads() async {
    setState(() {
      _loadingThreads = true;
      _threadsError = null;
    });
    try {
      final list = await client.learnerSupport.listTrainerSupportThreads();
      if (mounted) {
        setState(() {
          _threads = list;
          _loadingThreads = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _threadsError = e.toString();
          _loadingThreads = false;
        });
      }
    }
  }

  List<InAppNotification> get _filteredNotifications {
    if (_filter == 'all') return _notifications;
    return _notifications.where((n) => n.type.contains(_filter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_outlined,
                    color: PharmaColors.emerald600, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification Centre',
                        style: PharmaTypography.headingLarge
                            .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '${_notifications.length} notification${_notifications.length == 1 ? '' : 's'} · ${_threads.length} conversation${_threads.length == 1 ? '' : 's'}',
                        style: PharmaTypography.body
                            .copyWith(color: PharmaColors.textTertiary),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _loadAll,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Refresh'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.emerald600,
                    side: BorderSide(color: PharmaColors.emerald200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PharmaSpacing.md),
            TabBar(
              labelColor: PharmaColors.emerald700,
              unselectedLabelColor: PharmaColors.textSecondary,
              indicatorColor: PharmaColors.emerald600,
              tabs: [
                const Tab(text: 'Notifications'),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Messages'),
                      if (_threads.any((t) => t.unreadForTrainer > 0)) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: PharmaColors.emerald600,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_threads.fold<int>(0, (a, t) => a + t.unreadForTrainer)}',
                            style: PharmaTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: PharmaSpacing.sm),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNotificationsTab(),
                  _buildMessagesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsTab() {
    if (_loading) {
      return const TrainerPageLoading(cardCount: 4);
    }
    if (_error != null) {
      return TrainerPageError(
        message: _error!,
        onRetry: _loadNotifications,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _filterChip('All', 'all'),
            const SizedBox(width: 8),
            _filterChip('QA Decisions', 'qa'),
            const SizedBox(width: 8),
            _filterChip('Assignments', 'assignment'),
            const SizedBox(width: 8),
            _filterChip('SOP Updates', 'sop'),
          ],
        ),
        const SizedBox(height: PharmaSpacing.lg),
        Expanded(
          child: _filteredNotifications.isEmpty
              ? PharmaEmptyState(
                  icon: Icons.notifications_none,
                  title: 'No Notifications',
                  subtitle: 'You\'re all caught up!',
                )
              : PharmaCard(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final n = _filteredNotifications[index];
                      return PharmaNotificationCard(
                        type: n.type,
                        title: n.courseTitle,
                        message: n.message,
                        timestamp: n.dueDate,
                        onTap: () => _onNotificationTap(n),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildMessagesTab() {
    if (_loadingThreads) {
      return const TrainerPageLoading(cardCount: 3);
    }
    if (_threadsError != null) {
      return TrainerPageError(
        message: _threadsError!,
        onRetry: _loadMessageThreads,
      );
    }
    if (_threads.isEmpty) {
      return PharmaEmptyState(
        icon: Icons.forum_outlined,
        title: 'No messages yet',
        subtitle:
            'When learners message you from a course, threads appear here.',
      );
    }
    final fmt = DateFormat.yMMMd().add_jm();
    return PharmaCard(
      padding: EdgeInsets.zero,
      child: ListView.separated(
        itemCount: _threads.length,
        separatorBuilder: (_, _) =>
            Divider(height: 1, color: PharmaColors.borderLight),
        itemBuilder: (context, index) {
          final t = _threads[index];
          final unread = t.unreadForTrainer > 0;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: PharmaSpacing.md, vertical: PharmaSpacing.sm),
            leading: CircleAvatar(
              backgroundColor:
                  unread ? PharmaColors.emerald100 : PharmaColors.pageBg,
              child: Icon(
                Icons.person_outline,
                color: unread ? PharmaColors.emerald700 : PharmaColors.textSecondary,
              ),
            ),
            title: Text(
              t.courseTitle,
              style: PharmaTypography.bodyMedium.copyWith(
                fontWeight: unread ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${t.lastFromName}: ${t.lastMessageBody}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fmt.format(t.lastMessageAt.toLocal()),
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            trailing: unread
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${t.unreadForTrainer}',
                      style: PharmaTypography.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  )
                : Icon(Icons.chevron_right, color: PharmaColors.textTertiary),
            onTap: () async {
              await openLearnerInstructorChat(
                context,
                courseVersionId: t.courseVersionId,
                courseTitle: t.courseTitle,
              );
              if (mounted) await _loadMessageThreads();
            },
          );
        },
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    final selected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _filter = value),
      selectedColor: PharmaColors.emerald100,
      labelStyle: TextStyle(
        color: selected ? PharmaColors.emerald700 : PharmaColors.textSecondary,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        fontSize: 12,
      ),
    );
  }

  void _onNotificationTap(InAppNotification notification) {
    if (notification.assignmentId != null) {
      // Could navigate to assignment details if needed
    }
  }
}
