// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE NOTIFICATION CENTRE
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/notifications
// Full inbox for in-app notifications with action links.
// Uses: AppColors/AppTypography tokens from the unified design system.
// Backend: notification.getInAppNotifications
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/tokens.dart';
import '../../../design_system/components.dart';
import '../../../providers/employee_portal_providers.dart';

class EmployeeNotificationScreen extends ConsumerWidget {
  const EmployeeNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifAsync = ref.watch(employeeNotificationListProvider);

    return notifAsync.when(
      loading: () => _buildLoading(),
      error: (e, _) => AppErrorWidget(
        title: 'Unable to Load Notifications',
        message: e.toString(),
        onRetry: () => ref.invalidate(employeeNotificationListProvider),
      ),
      data: (notifications) => _NotificationCentreContent(
        notifications: notifications,
      ),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(height: 36, width: 240),
          const SizedBox(height: AppSpacing.s6),
          ...List.generate(5, (_) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s4),
            child: SkeletonLoader(height: 80, borderRadius: AppRadius.br2),
          )),
        ],
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
  String _filter = 'all'; // 'all' or filter by type

  List<InAppNotification> get _filtered {
    if (_filter == 'all') return widget.notifications;
    return widget.notifications.where((n) => n.type == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final total = widget.notifications.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Notifications', style: AppTypography.display.copyWith(
            fontSize: 32, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.s2),
          Text(
            total > 0
                ? '$total notification${total == 1 ? "" : "s"}'
                : 'All caught up!',
            style: AppTypography.body.copyWith(color: AppColors.n500),
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Filter Chips ───
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(label: 'All ($total)', value: 'all', current: _filter,
                    onTap: () => setState(() => _filter = 'all')),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Overdue', value: 'overdue', current: _filter,
                    onTap: () => setState(() => _filter = 'overdue')),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Due Soon', value: 'due_soon', current: _filter,
                    onTap: () => setState(() => _filter = 'due_soon')),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Assignments', value: 'assignment', current: _filter,
                    onTap: () => setState(() => _filter = 'assignment')),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Retraining', value: 'retraining', current: _filter,
                    onTap: () => setState(() => _filter = 'retraining')),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Notification List ───
          if (filtered.isEmpty)
            AppEmptyState(
              icon: Icons.notifications_none_outlined,
              title: 'No Notifications',
              description: 'Notifications about training assignments, deadlines, and compliance updates will appear here.',
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s3),
              itemBuilder: (context, index) {
                final n = filtered[index];
                return _NotificationCard(notification: n);
              },
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
      color: AppColors.n0,
      borderRadius: AppRadius.br2,
      child: InkWell(
        borderRadius: AppRadius.br2,
        onTap: () {
          final route = _routeForNotification(notification);
          if (route != null) context.go(route);
        },
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br2,
            border: Border.all(color: AppColors.n200),
            boxShadow: AppShadows.sh1,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(AppSpacing.s3),
                decoration: BoxDecoration(
                  color: _iconColor(notification.type).withValues(alpha: 0.1),
                  borderRadius: AppRadius.br2,
                ),
                child: Icon(
                  _iconForType(notification.type),
                  color: _iconColor(notification.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.s4),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.courseTitle,
                      style: AppTypography.title.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppSpacing.s1),
                    Text(
                      notification.message,
                      style: AppTypography.body.copyWith(color: AppColors.n500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: 2),
                          decoration: BoxDecoration(
                            color: _iconColor(notification.type).withValues(alpha: 0.1),
                            borderRadius: AppRadius.br5,
                          ),
                          child: Text(
                            _typeLabel(notification.type),
                            style: AppTypography.caption.copyWith(
                              color: _iconColor(notification.type),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s3),
                        Icon(Icons.calendar_today, size: 12, color: AppColors.n400),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${notification.dueDate}',
                          style: AppTypography.caption.copyWith(color: AppColors.n400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.n400),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'overdue':
        return Icons.warning_amber_rounded;
      case 'due_soon':
        return Icons.schedule;
      case 'assignment':
        return Icons.assignment_outlined;
      case 'completion':
        return Icons.check_circle_outline;
      case 'retraining':
        return Icons.refresh;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _iconColor(String type) {
    switch (type) {
      case 'overdue':
        return AppColors.danger;
      case 'due_soon':
        return AppColors.warning;
      case 'assignment':
        return AppColors.blue;
      case 'completion':
        return AppColors.success;
      case 'retraining':
        return AppColors.teal;
      default:
        return AppColors.n500;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'overdue':
        return 'Overdue';
      case 'due_soon':
        return 'Due Soon';
      case 'assignment':
        return 'Assignment';
      case 'completion':
        return 'Completed';
      case 'retraining':
        return 'Retraining';
      default:
        return 'Info';
    }
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : AppColors.n0,
          borderRadius: AppRadius.br5,
          border: Border.all(color: isActive ? AppColors.blue : AppColors.n200),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isActive ? AppColors.n0 : AppColors.n600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
