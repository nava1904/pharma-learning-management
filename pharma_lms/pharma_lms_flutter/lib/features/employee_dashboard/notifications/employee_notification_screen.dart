// =============================================================================
// Vyuh lms -- EMPLOYEE NOTIFICATION CENTRE
// =============================================================================
//
// Route: /employee/notifications
// Full inbox for in-app notifications with action links.
// Backend: notification.getInAppNotifications
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/employee_portal_providers.dart';
import '../widgets/employee_page_scaffold.dart';

class EmployeeNotificationScreen extends ConsumerWidget {
  const EmployeeNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.watch(employeeNotificationListProvider);

    return notifAsync.when(
      loading: () => const EmployeePageLoading(cardCount: 5),
      error: (e, _) => EmployeePageError(
        message: e.toString(),
        onRetry: () => ref.invalidate(employeeNotificationListProvider),
      ),
      data: (notifications) => _NotificationCentreContent(
        notifications: notifications,
      ),
    );
  }
}

class _NotificationCentreContent extends StatefulWidget {
  const _NotificationCentreContent({required this.notifications});
  final List<InAppNotification> notifications;

  @override
  State<_NotificationCentreContent> createState() =>
      _NotificationCentreContentState();
}

class _NotificationCentreContentState
    extends State<_NotificationCentreContent> {
  String _filter = 'all';

  List<InAppNotification> get _filtered {
    if (_filter == 'all') return widget.notifications;
    return widget.notifications.where((n) => n.type == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final total = widget.notifications.length;

    return EmployeePageScaffold(
      title: 'Notifications',
      subtitle: total > 0
          ? '$total notification${total == 1 ? "" : "s"}'
          : 'All caught up!',
      icon: Icons.notifications_rounded,
      scrollable: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Filter Chips --
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All ($total)',
                  value: 'all',
                  current: _filter,
                  onTap: () => setState(() => _filter = 'all'),
                ),
                const SizedBox(width: PharmaSpacing.sm),
                _FilterChip(
                  label: 'Overdue',
                  value: 'overdue',
                  current: _filter,
                  onTap: () => setState(() => _filter = 'overdue'),
                ),
                const SizedBox(width: PharmaSpacing.sm),
                _FilterChip(
                  label: 'Due Soon',
                  value: 'due_soon',
                  current: _filter,
                  onTap: () => setState(() => _filter = 'due_soon'),
                ),
                const SizedBox(width: PharmaSpacing.sm),
                _FilterChip(
                  label: 'Assignments',
                  value: 'assignment',
                  current: _filter,
                  onTap: () => setState(() => _filter = 'assignment'),
                ),
                const SizedBox(width: PharmaSpacing.sm),
                _FilterChip(
                  label: 'Retraining',
                  value: 'retraining',
                  current: _filter,
                  onTap: () => setState(() => _filter = 'retraining'),
                ),
              ],
            ),
          ),
          const SizedBox(height: PharmaSpacing.lg),

          // -- Notification List --
          if (filtered.isEmpty)
            const EmployeePageEmpty(
              title: 'No Notifications',
              subtitle:
                  'Notifications about training assignments, deadlines, and compliance updates will appear here.',
              icon: Icons.notifications_none_outlined,
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: PharmaSpacing.md,
                ),
                itemCount: filtered.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: PharmaSpacing.md),
                itemBuilder: (context, index) {
                  final n = filtered[index];
                  return _NotificationCard(notification: n);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});
  final InAppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PharmaColors.cardBg,
      borderRadius: PharmaRadius.cardRadius,
      child: InkWell(
        borderRadius: PharmaRadius.cardRadius,
        onTap: () {
          final route = _routeForNotification(notification);
          if (route != null) context.go(route);
        },
        child: Container(
          padding: const EdgeInsets.all(PharmaSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
            boxShadow: PharmaShadows.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(PharmaSpacing.md),
                decoration: BoxDecoration(
                  color: _iconColor(notification.type).withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.cardRadius,
                ),
                child: Icon(
                  _iconForType(notification.type),
                  color: _iconColor(notification.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: PharmaSpacing.lg),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.courseTitle,
                      style: PharmaTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: PharmaSpacing.xs),
                    Text(
                      notification.message,
                      style: PharmaTypography.body.copyWith(
                        color: PharmaColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: PharmaSpacing.sm),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PharmaSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _iconColor(notification.type)
                                .withValues(alpha: 0.1),
                            borderRadius: PharmaRadius.pillRadius,
                          ),
                          child: Text(
                            _typeLabel(notification.type),
                            style: PharmaTypography.labelSmall.copyWith(
                              color: _iconColor(notification.type),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: PharmaSpacing.md),
                        Icon(Icons.calendar_today,
                            size: 12, color: PharmaColors.gray400),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${notification.dueDate}',
                          style: PharmaTypography.caption.copyWith(
                            color: PharmaColors.gray400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: PharmaColors.gray400),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'overdue' => Icons.warning_amber_rounded,
      'due_soon' => Icons.schedule,
      'assignment' => Icons.assignment_outlined,
      'completion' => Icons.check_circle_outline,
      'retraining' => Icons.refresh,
      _ => Icons.notifications_outlined,
    };
  }

  Color _iconColor(String type) {
    return switch (type) {
      'overdue' => PharmaColors.danger,
      'due_soon' => PharmaColors.warning,
      'assignment' => PharmaColors.info,
      'completion' => PharmaColors.success,
      'retraining' => PharmaColors.emerald600,
      _ => PharmaColors.gray500,
    };
  }

  String _typeLabel(String type) {
    return switch (type) {
      'overdue' => 'Overdue',
      'due_soon' => 'Due Soon',
      'assignment' => 'Assignment',
      'completion' => 'Completed',
      'retraining' => 'Retraining',
      _ => 'Info',
    };
  }

  String? _routeForNotification(InAppNotification n) {
    if (n.type == 'overdue' || n.type == 'due_soon' || n.type == 'assignment') {
      return '/employee/assigned-training';
    }
    if (n.type == 'completion') return '/employee/training-history';
    if (n.type == 'retraining') return '/employee/documents';
    return null;
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.value,
    required this.current,
    required this.onTap,
  });
  final String label;
  final String value;
  final String current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = value == current;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: PharmaDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: PharmaSpacing.lg,
          vertical: PharmaSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? PharmaColors.emerald600 : PharmaColors.cardBg,
          borderRadius: PharmaRadius.pillRadius,
          border: Border.all(
            color: isActive ? PharmaColors.emerald600 : PharmaColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: PharmaTypography.labelSmall.copyWith(
            color: isActive ? Colors.white : PharmaColors.gray600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
