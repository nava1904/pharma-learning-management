import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/employee_batch_providers.dart';
import '../../../providers/employee_batch_announcements_provider.dart';

/// Master–detail ILT dashboard: roster from [training_batch_participant] only.
class EmployeeMyBatchesDashboardScreen extends ConsumerStatefulWidget {
  const EmployeeMyBatchesDashboardScreen({super.key});

  @override
  ConsumerState<EmployeeMyBatchesDashboardScreen> createState() =>
      _EmployeeMyBatchesDashboardScreenState();
}

class _EmployeeMyBatchesDashboardScreenState extends ConsumerState<EmployeeMyBatchesDashboardScreen> {
  int? _selectedBatchId;

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(employeeBatchesProvider);

    return batchesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (batches) {
        if (batches.isEmpty) {
          return _EmptyBatches(onRefresh: () => ref.invalidate(employeeBatchesProvider));
        }
        final selectedBatchId = _selectedBatchId != null &&
                batches.any((b) => b.id == _selectedBatchId)
            ? _selectedBatchId!
            : batches.first.id!;
        final selected = batches.firstWhere((b) => b.id == selectedBatchId);

        return LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 900;
            if (!wide) {
              return _MobileBatchLayout(
                batches: batches,
                selected: selected,
                onSelect: (id) => setState(() => _selectedBatchId = id),
                onRefresh: () {
                  ref.invalidate(employeeBatchesProvider);
                  ref.invalidate(employeeBatchParticipantsProvider(selectedBatchId));
                  ref.invalidate(employeeBatchCohortProgressProvider(selectedBatchId));
                },
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 220,
                  child: _BatchSidebarList(
                    batches: batches,
                    selectedId: selectedBatchId,
                    onSelect: (id) => setState(() => _selectedBatchId = id),
                  ),
                ),
                Container(width: 1, color: PharmaColors.borderLight),
                Expanded(
                  child: _BatchMainPanel(
                    batch: selected,
                    batchId: selected.id!,
                  ),
                ),
                Container(width: 1, color: PharmaColors.borderLight),
                SizedBox(
                  width: 280,
                  child: _BatchRightPanel(batch: selected, batchId: selected.id!),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _EmptyBatches extends StatelessWidget {
  const _EmptyBatches({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.groups_outlined, size: 56, color: PharmaColors.gray400),
            const SizedBox(height: PharmaSpacing.md),
            Text('No cohort batches', style: PharmaTypography.headingMedium),
            const SizedBox(height: PharmaSpacing.sm),
            Text(
              'When you are added to an instructor-led batch, it will appear here.',
              textAlign: TextAlign.center,
              style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
            ),
            const SizedBox(height: PharmaSpacing.lg),
            OutlinedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatchSidebarList extends StatelessWidget {
  const _BatchSidebarList({
    required this.batches,
    required this.selectedId,
    required this.onSelect,
  });

  final List<TrainingBatch> batches;
  final int? selectedId;
  final void Function(int id) onSelect;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: PharmaColors.gray50,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.md, horizontal: PharmaSpacing.sm),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(PharmaSpacing.md, 0, PharmaSpacing.md, PharmaSpacing.sm),
            child: Text('My Batches', style: PharmaTypography.headingSmall),
          ),
          ...batches.map((b) {
            final sel = b.id == selectedId;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Material(
                color: sel ? PharmaColors.infoBg : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onSelect(b.id!),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Text(
                      b.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PharmaTypography.labelSmall.copyWith(
                        fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                        color: sel ? PharmaColors.info : PharmaColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _BatchMainPanel extends ConsumerWidget {
  const _BatchMainPanel({required this.batch, required this.batchId});

  final TrainingBatch batch;
  final int batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final df = DateFormat('MMM d, yyyy');
    final cohortAsync = ref.watch(employeeBatchCohortProgressProvider(batchId));
    final enrollmentsAsync = ref.watch(employeeUserEnrollmentsProvider);
    final assignmentsAsync = ref.watch(employeeUserAssignmentsProvider);

    final courseTitle = batch.courseVersion?.course?.title ?? 'Training course';
    final courseId = batch.courseVersion?.course?.id;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${batch.name} — dashboard', style: PharmaTypography.headingLarge),
          const SizedBox(height: PharmaSpacing.lg),
          Text('Batch to-do', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          cohortAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const SizedBox.shrink(),
            data: (cohort) => enrollmentsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (enrollments) => assignmentsAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, _) => const SizedBox.shrink(),
                        data: (assignList) {
                          final enrollment = enrollments.cast<Enrollment?>().firstWhere(
                                (e) => e?.courseVersionId == batch.courseVersionId,
                                orElse: () => null,
                              );
                          TrainingAssignment? match;
                          for (final a in assignList) {
                            if (a.courseVersionId == batch.courseVersionId) {
                              match = a;
                              break;
                            }
                          }
                          final due = match?.dueDate ?? batch.endDate;
                          final completedL =
                              int.tryParse(cohort['myCompletedLessons']?.toString() ?? '') ?? 0;
                          final totalL = int.tryParse(cohort['myTotalLessons']?.toString() ?? '') ?? 0;
                          final status = enrollment?.status ?? 'not_started';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _TaskCard(
                                title: 'Complete training: $courseTitle',
                                dueLabel: 'Due: ${df.format(due)}',
                                statusLabel: _enrollmentStatusLabel(status),
                                actionLabel: status == 'completed' ? 'Review' : 'Continue',
                                priorityHigh: match?.priority == 'high',
                                onAction: courseId != null
                                    ? () => context.push(
                                          '/employee/course/$courseId',
                                          extra: {
                                            'courseVersionId':
                                                batch.courseVersionId.toString(),
                                            'enrollmentId':
                                                enrollment?.id?.toString(),
                                          },
                                        )
                                    : null,
                              ),
                              const SizedBox(height: PharmaSpacing.sm),
                              _TaskCard(
                                title: 'Instructor-led session',
                                dueLabel:
                                    '${df.format(batch.startDate)} — ${df.format(batch.endDate)}',
                                statusLabel:
                                    batch.status == 'in_progress' || batch.status == 'active'
                                        ? 'In progress'
                                        : batch.status == 'scheduled'
                                            ? 'Scheduled'
                                            : batch.status,
                                actionLabel: 'Details',
                                priorityHigh: false,
                                onAction: () => context.push('/employee/sessions/$batchId'),
                              ),
                              const SizedBox(height: PharmaSpacing.lg),
                              Text(
                                totalL > 0
                                    ? '$completedL / $totalL lessons complete'
                                    : 'Lesson progress pending',
                                style: PharmaTypography.caption
                                    .copyWith(color: PharmaColors.textSecondary),
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: totalL > 0 ? completedL / totalL : 0,
                                  minHeight: 6,
                                  backgroundColor: PharmaColors.gray200,
                                  valueColor:
                                      AlwaysStoppedAnimation(PharmaColors.primary),
                                ),
                              ),
                              const SizedBox(height: PharmaSpacing.xl),
                              Text('Shared course progress',
                                  style: PharmaTypography.headingMedium),
                              const SizedBox(height: PharmaSpacing.sm),
                              _DualBarRow(
                                label: courseTitle,
                                selfPct:
                                    double.tryParse(cohort['myProgressPct']?.toString() ?? '') ?? 0,
                                cohortPct: double.tryParse(cohort['cohortAverageProgressPct']?.toString() ?? '') ?? 0,
                              ),
                            ],
                          );
                        },
                      ),
                ),
          ),
        ],
      ),
    );
  }
}

String _enrollmentStatusLabel(String status) {
  switch (status) {
    case 'completed':
      return 'Completed';
    case 'in_progress':
      return 'In progress';
    case 'overdue':
      return 'Overdue';
    default:
      return 'Not started';
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.title,
    required this.dueLabel,
    required this.statusLabel,
    required this.actionLabel,
    required this.priorityHigh,
    this.onAction,
  });

  final String title;
  final String dueLabel;
  final String statusLabel;
  final String actionLabel;
  final bool priorityHigh;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (priorityHigh)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: PharmaColors.danger.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'High priority',
                      style: PharmaTypography.caption.copyWith(
                        color: PharmaColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Text(title, style: PharmaTypography.body.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(dueLabel, style: PharmaTypography.caption),
                Text('Status: $statusLabel', style: PharmaTypography.caption),
              ],
            ),
          ),
          if (onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}

class _DualBarRow extends StatelessWidget {
  const _DualBarRow({
    required this.label,
    required this.selfPct,
    required this.cohortPct,
  });

  final String label;
  final double selfPct;
  final double cohortPct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PharmaTypography.labelSmall.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Your progress: ${selfPct.toStringAsFixed(0)}%', style: PharmaTypography.caption),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (selfPct / 100).clamp(0, 1),
              minHeight: 8,
              backgroundColor: PharmaColors.gray200,
              valueColor: AlwaysStoppedAnimation(PharmaColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Text('Cohort average: ${cohortPct.toStringAsFixed(0)}%', style: PharmaTypography.caption),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (cohortPct / 100).clamp(0, 1),
              minHeight: 8,
              backgroundColor: PharmaColors.gray200,
              valueColor: AlwaysStoppedAnimation(PharmaColors.gray500),
            ),
          ),
        ],
      ),
    );
  }
}

class _BatchRightPanel extends ConsumerWidget {
  const _BatchRightPanel({required this.batch, required this.batchId});

  final TrainingBatch batch;
  final int batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsync = ref.watch(employeeBatchParticipantsProvider(batchId));
    final announcementsAsync = ref.watch(employeeBatchAnnouncementsProvider(batchId));

    return ColoredBox(
      color: PharmaColors.gray50,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PharmaSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Batch announcements', style: PharmaTypography.headingSmall),
            const SizedBox(height: PharmaSpacing.sm),
            announcementsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              error: (e, _) => Text('Could not load announcements', style: PharmaTypography.caption),
              data: (announcements) {
                if (announcements.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(PharmaSpacing.md),
                    decoration: BoxDecoration(
                      color: PharmaColors.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: PharmaColors.borderLight),
                    ),
                    child: Text(
                      'No batch announcements.',
                      style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: announcements.map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(PharmaSpacing.sm),
                      decoration: BoxDecoration(
                        color: PharmaColors.cardBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: PharmaColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(a.body, style: PharmaTypography.bodyMedium),
                          const SizedBox(height: 4),
                          Text(
                            'By ${a.createdBy != null ? ('${a.createdBy!.firstName} ${a.createdBy!.lastName}') : 'Trainer'} on ${DateFormat.yMMMd().format(a.createdAt)}',
                            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                );
              },
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Text('Batch members', style: PharmaTypography.headingSmall),
            const SizedBox(height: PharmaSpacing.sm),
            participantsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              error: (e, _) => Text('$e', style: PharmaTypography.caption),
              data: (list) {
                final show = list.take(8).toList();
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(PharmaSpacing.md),
                  decoration: BoxDecoration(
                    color: PharmaColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: PharmaColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...show.map((p) {
                        final initials =
                            '${p.firstName.isNotEmpty ? p.firstName[0] : ''}${p.lastName.isNotEmpty ? p.lastName[0] : ''}'
                                .toUpperCase();
                        final mentor = p.role == 'mentor';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: PharmaColors.primary.withValues(alpha: 0.15),
                                child: Text(
                                  initials,
                                  style: PharmaTypography.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: PharmaColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${p.firstName} ${p.lastName}${mentor ? ' (Mentor)' : ''}',
                                  style: PharmaTypography.labelSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      if (list.length > 8)
                        Text(
                          'View all (${list.length})',
                          style: PharmaTypography.caption.copyWith(color: PharmaColors.primary),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileBatchLayout extends ConsumerWidget {
  const _MobileBatchLayout({
    required this.batches,
    required this.selected,
    required this.onSelect,
    required this.onRefresh,
  });

  final List<TrainingBatch> batches;
  final TrainingBatch selected;
  final void Function(int id) onSelect;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        await ref.read(employeeBatchesProvider.future);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Batches', style: PharmaTypography.headingLarge),
                  const SizedBox(height: PharmaSpacing.md),
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: batches.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final b = batches[i];
                        final sel = b.id == selected.id;
                        return ChoiceChip(
                          label: Text(b.name, overflow: TextOverflow.ellipsis),
                          selected: sel,
                          onSelected: (_) => onSelect(b.id!),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _BatchMainPanel(batch: selected, batchId: selected.id!),
          ),
          SliverToBoxAdapter(
            child: _BatchRightPanel(batch: selected, batchId: selected.id!),
          ),
        ],
      ),
    );
  }
}
