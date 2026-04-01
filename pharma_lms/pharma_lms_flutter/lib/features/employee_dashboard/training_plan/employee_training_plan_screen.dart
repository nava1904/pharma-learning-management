// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE TRAINING PLAN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/training-plan
// Shows the learner's role-based training curriculum, progress per item,
// prerequisites, due dates, and status. All data from real providers.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../design_system/tokens.dart';
import '../../../design_system/components.dart';
import '../../../providers/employee_portal_providers.dart';

class EmployeeTrainingPlanScreen extends ConsumerStatefulWidget {
  const EmployeeTrainingPlanScreen({super.key});

  @override
  ConsumerState<EmployeeTrainingPlanScreen> createState() =>
      _EmployeeTrainingPlanScreenState();
}

class _EmployeeTrainingPlanScreenState extends ConsumerState<EmployeeTrainingPlanScreen> {
  String _filter = 'all'; // all | pending | in_progress | completed | overdue

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(employeeTrainingPlanProvider);

    return planAsync.when(
      loading: () => SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(height: 36, width: 280),
            const SizedBox(height: AppSpacing.s6),
            ...List.generate(5, (_) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s3),
              child: SkeletonLoader(height: 100, borderRadius: AppRadius.br2),
            )),
          ],
        ),
      ),
      error: (e, _) => AppErrorWidget(
        title: 'Unable to Load Training Plan',
        message: e.toString(),
        onRetry: () => ref.invalidate(employeeTrainingPlanProvider),
      ),
      data: (plan) => _PlanContent(
        items: plan,
        filter: _filter,
        onFilterChanged: (f) => setState(() => _filter = f),
      ),
    );
  }
}

class _PlanContent extends StatelessWidget {
  const _PlanContent({
    required this.items,
    required this.filter,
    required this.onFilterChanged,
  });
  final List<TrainingPlanItem> items;
  final String filter;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    // Stats
    final completed = items.where((i) => i.status == 'completed').length;
    final inProgress = items.where((i) => i.status == 'in_progress').length;
    final overdue = items.where((i) => i.status == 'overdue').length;
    final pending = items.where((i) => i.status == 'pending' || i.status == 'not_started').length;
    final total = items.length;
    final pct = total > 0 ? (completed / total * 100).round() : 0;

    // Filtered
    final filtered = filter == 'all'
        ? items
        : filter == 'pending'
            ? items.where((i) => i.status == 'pending' || i.status == 'not_started').toList()
            : items.where((i) => i.status == filter).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('My Training Plan', style: AppTypography.display.copyWith(
            fontSize: 32, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Role-based training curriculum and progress tracker',
            style: AppTypography.body.copyWith(color: AppColors.n500),
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Progress Hero ───
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.s6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.blue, AppColors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppRadius.br3,
              boxShadow: AppShadows.sh2,
            ),
            child: Row(
              children: [
                ProgressRing(
                  percent: total > 0 ? completed / total : 0,
                  size: 80,
                  strokeWidth: 8,
                  color: AppColors.n0,
                  backgroundColor: AppColors.n0.withValues(alpha: 0.2),
                  label: '$pct%',
                ),
                const SizedBox(width: AppSpacing.s6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Curriculum Progress', style: AppTypography.headline.copyWith(
                        color: AppColors.n0, fontSize: 20,
                      )),
                      const SizedBox(height: AppSpacing.s2),
                      Text(
                        '$completed of $total modules completed',
                        style: AppTypography.body.copyWith(color: AppColors.n0.withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s5),

          // ─── Mini Stats ───
          Wrap(
            spacing: AppSpacing.s3,
            runSpacing: AppSpacing.s3,
            children: [
              _MiniStat(label: 'Completed', count: completed, color: AppColors.success),
              _MiniStat(label: 'In Progress', count: inProgress, color: AppColors.blue),
              _MiniStat(label: 'Overdue', count: overdue, color: AppColors.danger),
              _MiniStat(label: 'Pending', count: pending, color: AppColors.n400),
            ],
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Filter Chips ───
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(label: 'All ($total)', value: 'all', selected: filter, onTap: onFilterChanged),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Pending', value: 'pending', selected: filter, onTap: onFilterChanged),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'In Progress', value: 'in_progress', selected: filter, onTap: onFilterChanged),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Completed', value: 'completed', selected: filter, onTap: onFilterChanged),
                const SizedBox(width: AppSpacing.s2),
                _FilterChip(label: 'Overdue', value: 'overdue', selected: filter, onTap: onFilterChanged),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s5),

          // ─── Plan Items ───
          if (filtered.isEmpty)
            AppEmptyState(
              icon: Icons.checklist_outlined,
              title: 'No Items',
              description: 'No training plan items match the selected filter.',
            )
          else
            ...filtered.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _TrainingPlanCard(item: item, index: index + 1);
            }),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.count, required this.color});
  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: AppSpacing.s3),
          Text('$count', style: AppTypography.headline.copyWith(fontSize: 18, color: color)),
          const SizedBox(width: AppSpacing.s2),
          Text(label, style: AppTypography.caption.copyWith(color: AppColors.n500)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String value;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = value == selected;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : AppColors.n0,
          borderRadius: AppRadius.br5,
          border: Border.all(color: isActive ? AppColors.blue : AppColors.n200),
        ),
        child: Text(
          label,
          style: AppTypography.title.copyWith(
            fontSize: 13,
            color: isActive ? AppColors.n0 : AppColors.n600,
          ),
        ),
      ),
    );
  }
}

class _TrainingPlanCard extends StatelessWidget {
  const _TrainingPlanCard({required this.item, required this.index});
  final TrainingPlanItem item;
  final int index;

  Color get _statusColor {
    switch (item.status) {
      case 'completed':
        return AppColors.success;
      case 'in_progress':
        return AppColors.blue;
      case 'overdue':
        return AppColors.danger;
      default:
        return AppColors.n400;
    }
  }

  IconData get _statusIcon {
    switch (item.status) {
      case 'completed':
        return Icons.check_circle;
      case 'in_progress':
        return Icons.play_circle_outline;
      case 'overdue':
        return Icons.error_outline;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  String get _statusLabel {
    switch (item.status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In Progress';
      case 'overdue':
        return 'Overdue';
      case 'not_started':
        return 'Not Started';
      default:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Material(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        child: InkWell(
          borderRadius: AppRadius.br2,
          onTap: item.enrollment?.courseVersionId != null
              ? () => context.go('/employee/course/${item.enrollment!.courseVersionId}')
              : null,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: BoxDecoration(
              borderRadius: AppRadius.br2,
              boxShadow: AppShadows.sh1,
              border: Border(left: BorderSide(color: _statusColor, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step number
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: item.status == 'completed'
                        ? Icon(_statusIcon, color: _statusColor, size: 20)
                        : Text('$index', style: AppTypography.title.copyWith(
                            color: _statusColor, fontSize: 14)),
                  ),
                ),
                const SizedBox(width: AppSpacing.s4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.courseTitle, style: AppTypography.title.copyWith(fontSize: 15)),
                      const SizedBox(height: AppSpacing.s2),

                      // Status pill + due date
                      Wrap(
                        spacing: AppSpacing.s3,
                        runSpacing: AppSpacing.s2,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s2, vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _statusColor.withValues(alpha: 0.1),
                              borderRadius: AppRadius.br5,
                            ),
                            child: Text(_statusLabel,
                                style: AppTypography.caption.copyWith(
                                  color: _statusColor, fontWeight: FontWeight.w600)),
                          ),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today, size: 12, color: AppColors.n400),
                                const SizedBox(width: 4),
                                Text(
                                  'Due: ${DateFormat('MMM d, yyyy').format(item.dueDate)}',
                                  style: AppTypography.caption.copyWith(color: AppColors.n400),
                                ),
                              ],
                            ),
                          if (item.assignment.reason != null && item.assignment.reason!.isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info_outline, size: 12, color: AppColors.n400),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    item.assignment.reason!,
                                    style: AppTypography.caption.copyWith(color: AppColors.n400),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Progress bar
                      if (item.progress > 0 && item.status != 'completed') ...[
                        const SizedBox(height: AppSpacing.s3),
                        ClipRRect(
                          borderRadius: AppRadius.br5,
                          child: LinearProgressIndicator(
                            value: item.progress / 100,
                            minHeight: 6,
                            backgroundColor: AppColors.n100,
                            valueColor: AlwaysStoppedAnimation(_statusColor),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s1),
                        Text('${item.progress.toInt()}% complete',
                            style: AppTypography.caption.copyWith(color: AppColors.n400)),
                      ],
                    ],
                  ),
                ),
                if (item.enrollment?.courseVersionId != null)
                  Icon(Icons.chevron_right, color: AppColors.n400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
