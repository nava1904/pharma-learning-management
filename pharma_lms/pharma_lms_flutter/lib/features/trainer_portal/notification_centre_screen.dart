// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — NOTIFICATION CENTRE (TRN-NC)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/notifications
// Displays trainer-specific notifications: QA decisions, SOP updates,
// assignment alerts, and system messages.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';
import '../../providers/user_provider.dart';

class NotificationCentreScreen extends ConsumerStatefulWidget {
  const NotificationCentreScreen({super.key});

  @override
  ConsumerState<NotificationCentreScreen> createState() =>
      _NotificationCentreScreenState();
}

class _NotificationCentreScreenState
    extends ConsumerState<NotificationCentreScreen> {
  List<InAppNotification> _notifications = [];
  bool _loading = true;
  String? _error;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _loadNotifications();
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

  List<InAppNotification> get _filteredNotifications {
    if (_filter == 'all') return _notifications;
    return _notifications.where((n) => n.type.contains(_filter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                      '${_notifications.length} notification${_notifications.length == 1 ? '' : 's'}',
                      style: PharmaTypography.body
                          .copyWith(color: PharmaColors.textTertiary),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: _loadNotifications,
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
          const SizedBox(height: PharmaSpacing.lg),

          // Filter chips
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

          // Content
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: PharmaColors.danger),
                            const SizedBox(height: 12),
                            Text('Failed to load notifications',
                                style: PharmaTypography.bodyMedium
                                    .copyWith(color: PharmaColors.danger)),
                            const SizedBox(height: 4),
                            Text(_error!,
                                style: PharmaTypography.caption
                                    .copyWith(color: PharmaColors.textTertiary),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            FilledButton(
                              onPressed: _loadNotifications,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _filteredNotifications.isEmpty
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
