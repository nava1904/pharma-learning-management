import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../../design_system/pharma_design_system.dart';
import '../../../providers/employee_assigned_training_provider.dart';
import '../../../providers/employee_batch_providers.dart';

/// Lists active [TrainingAssignment] rows with enrollment-derived status (no mock data).
class EmployeeAssignedTrainingScreen extends ConsumerWidget {
  const EmployeeAssignedTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelAsync = ref.watch(employeeAssignedTrainingModelProvider);
    final df = DateFormat('MMM d, yyyy');

    return modelAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (model) {
        return LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 960;
            final list = _buildList(context, model, df);
            final side = _ComplianceSidebar(model: model);

            Widget assignmentsSection = Card(
              margin: const EdgeInsets.only(bottom: PharmaSpacing.lg),
              color: PharmaColors.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: PharmaColors.borderLight),
              ),
              child: ListTile(
                title: Text('Other assignments', style: PharmaTypography.headingSmall),
                subtitle: Text('View assignments given directly by your trainer (not linked to a course)'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/employee/standalone-assignments'),
              ),
            );

            if (!wide) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(employeeUserAssignmentsProvider);
                  ref.invalidate(employeeUserEnrollmentsProvider);
                  ref.invalidate(employeeEnrollmentByCourseVersionProvider);
                  ref.invalidate(employeeAssignedTrainingModelProvider);
                  await ref.read(employeeAssignedTrainingModelProvider.future);
                },
                child: ListView(
                  padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
                  children: [
                    Text('Assigned training', style: PharmaTypography.headingLarge),
                    const SizedBox(height: PharmaSpacing.md),
                    if (model.urgentAssignment != null) ...[
                      _UrgentBanner(
                        assignment: model.urgentAssignment!,
                        title: model.urgentAssignment!.courseVersion?.course?.title ??
                            'Training',
                        df: df,
                      ),
                      const SizedBox(height: PharmaSpacing.md),
                    ],
                    ...list,
                    assignmentsSection,
                    const SizedBox(height: PharmaSpacing.lg),
                    side,
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(employeeUserAssignmentsProvider);
                ref.invalidate(employeeUserEnrollmentsProvider);
                ref.invalidate(employeeEnrollmentByCourseVersionProvider);
                ref.invalidate(employeeAssignedTrainingModelProvider);
                await ref.read(employeeAssignedTrainingModelProvider.future);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
                      children: [
                        Text('Assigned training', style: PharmaTypography.headingLarge),
                        const SizedBox(height: PharmaSpacing.md),
                        if (model.urgentAssignment != null) ...[
                          _UrgentBanner(
                            assignment: model.urgentAssignment!,
                            title: model.urgentAssignment!.courseVersion?.course?.title ??
                                'Training',
                            df: df,
                          ),
                          const SizedBox(height: PharmaSpacing.md),
                        ],
                        ...list,
                        assignmentsSection,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, PharmaSpacing.pagePadding,
                          PharmaSpacing.pagePadding, PharmaSpacing.pagePadding),
                      child: side,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildList(
    BuildContext context,
    EmployeeAssignedTrainingModel model,
    DateFormat df,
  ) {
    if (model.assignments.isEmpty) {
      return [
        Text(
          'No active assignments.',
          style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
        ),
      ];
    }

    return model.assignments.map((a) {
      final title = a.courseVersion?.course?.title ?? 'Course';
      final courseId = a.courseVersion?.course?.id;
      final status = model.statusLabel(a);
      final enroll = model.enrollmentFor(a);
      final isHigh = a.priority == 'high';

      return Padding(
        padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
        child: Material(
          color: PharmaColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: courseId != null
                ? () => context.push(
                      '/employee/course/$courseId',
                      extra: {
                        'courseVersionId': a.courseVersionId.toString(),
                        'enrollmentId': enroll?.id?.toString(),
                      },
                    )
                : null,
            child: Container(
              padding: const EdgeInsets.all(PharmaSpacing.md),
              decoration: BoxDecoration(
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
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (isHigh)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: PharmaColors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'High priority',
                                  style: PharmaTypography.caption.copyWith(
                                    color: PharmaColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            _StatusPill(status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(title, style: PharmaTypography.headingSmall),
                        const SizedBox(height: 6),
                        Text(
                          'Assigned: ${df.format(a.assignedAt)}   Due: ${df.format(a.dueDate)}',
                          style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                        ),
                        if (a.source.isNotEmpty)
                          Text(
                            'Source: ${a.source}',
                            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: courseId != null && enroll?.status != 'completed'
                        ? () => context.push(
                              '/employee/course/$courseId',
                              extra: {
                                'courseVersionId': a.courseVersionId.toString(),
                                'enrollmentId': enroll?.id?.toString(),
                              },
                            )
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: PharmaColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(enroll?.status == 'completed' ? 'Completed' : 'Start training'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final isProgress = label == 'In progress';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isProgress ? PharmaColors.primary.withValues(alpha: 0.12) : PharmaColors.gray100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: PharmaTypography.caption.copyWith(
          color: isProgress ? PharmaColors.primary : PharmaColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _UrgentBanner extends StatelessWidget {
  const _UrgentBanner({
    required this.assignment,
    required this.title,
    required this.df,
  });

  final TrainingAssignment assignment;
  final String title;
  final DateFormat df;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = assignment.dueDate.difference(now).inDays;
    final overdue = assignment.dueDate.isBefore(now);
    final msg = overdue
        ? '$title is overdue (due ${df.format(assignment.dueDate)}).'
        : days == 0
            ? '$title is due today.'
            : '$title is due in $days day${days == 1 ? '' : 's'}.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFC45C3E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Urgent: $msg',
        style: PharmaTypography.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ComplianceSidebar extends StatelessWidget {
  const _ComplianceSidebar({required this.model});

  final EmployeeAssignedTrainingModel model;

  @override
  Widget build(BuildContext context) {
    final pct = model.compliancePct.clamp(0, 100) / 100.0;
    final pendingAdmin = model.totalCount - model.completedCount;

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance summary', style: PharmaTypography.headingSmall),
          const SizedBox(height: PharmaSpacing.md),
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: pct,
                      strokeWidth: 10,
                      backgroundColor: PharmaColors.gray200,
                      valueColor: AlwaysStoppedAnimation(PharmaColors.primary),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${model.compliancePct.round()}%',
                        style: PharmaTypography.headingMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'standing',
                        style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: PharmaSpacing.md),
          Text(
            'Completed: ${model.completedCount} / ${model.totalCount}',
            style: PharmaTypography.labelSmall,
          ),
          Text(
            'Remaining: $pendingAdmin',
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.sm),
          Text(
            'Based on active assignments and enrollment completion status.',
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
          ),
        ],
      ),
    );
  }
}
