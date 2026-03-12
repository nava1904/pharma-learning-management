import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';

/// QA Dashboard: Overview, Approvals, Compliance tabs.
class QADashboardScreen extends ConsumerStatefulWidget {
  const QADashboardScreen({super.key});

  @override
  ConsumerState<QADashboardScreen> createState() => _QADashboardScreenState();
}

enum _QATab { overview, approvals, compliance }

/// QA-WF-01 checklist keys (shared by dialog and split-pane).
const _qaChecklistKeys = [
  'Content accuracy verified',
  'Regulatory coverage adequate',
  'Correct answers validated',
  'Pass mark appropriate',
  'Question clarity acceptable',
];

Map<String, bool> _initialChecklist() =>
    {for (final k in _qaChecklistKeys) k: false};

class _QADashboardScreenState extends ConsumerState<QADashboardScreen> {
  _QATab _selectedTab = _QATab.overview;

  Future<void> _doApproveApi(CourseVersion v, Map<String, bool> checklist) async {
    if (v.id == null || !mounted) return;
    final checklistJson =
        checklist.entries.map((e) => '"${e.key}":${e.value}').join(',');
    final jsonStr = '{$checklistJson}';
    try {
      final user = await client.user.getUserByEmail('qa@pharmacorp.demo');
      await client.qa.approveCourseVersion(
        courseVersionId: v.id!,
        approverId: user?.id,
        reviewChecklistJson: jsonStr,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course version approved')),
        );
        ref.invalidate(pendingCourseVersionsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _approve(CourseVersion v) async {
    if (v.id == null) return;
    final checklist = _initialChecklist();
    final width = MediaQuery.sizeOf(context).width;
    if (width > 900) {
      await showGeneralDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        pageBuilder: (_, __, ___) => _QAReviewSplitPane(
          version: v,
          checklist: checklist,
          onApprove: (c) async {
            Navigator.pop(context);
            await _doApproveApi(v, c);
          },
          onReject: () async {
            Navigator.pop(context);
            await _reject(v);
          },
          onCancel: () => Navigator.pop(context),
        ),
      );
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) => AlertDialog(
          title: const Text('QA Review Checklist (QA-WF-01)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${v.course?.title ?? 'Course'} v${v.version}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                ...checklist.entries.map((e) => CheckboxListTile(
                      value: e.value,
                      onChanged: (val) {
                        setState(() {
                          checklist[e.key] = val ?? false;
                        });
                      },
                      title: Text(e.key),
                      controlAffinity: ListTileControlAffinity.leading,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (checklist.values.any((x) => !x)) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                        content: Text('All checklist items must be verified')),
                  );
                  return;
                }
                Navigator.pop(ctx, true);
              },
              child: const Text('Approve'),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true || !mounted) return;
    await _doApproveApi(v, checklist);
  }

  Future<void> _reject(CourseVersion v) async {
    if (v.id == null) return;
    try {
      await client.qa.rejectCourseVersion(courseVersionId: v.id!, returnForChanges: false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course version rejected')),
        );
        ref.invalidate(pendingCourseVersionsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Quality Assurance Portal',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick links
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () => context.push('/documents'),
                  icon: const Icon(Icons.description, size: 18),
                  label: const Text('Document Control'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => context.push('/quality-events'),
                  icon: const Icon(Icons.warning_amber, size: 18),
                  label: const Text('Quality Events'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => context.push('/inspection-management'),
                  icon: const Icon(Icons.assignment, size: 18),
                  label: const Text('Inspection Management'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => context.push('/admin/training-waivers'),
                  icon: const Icon(Icons.verified_user, size: 18),
                  label: const Text('Training Waivers'),
                ),
              ],
            ),
          ),
          // Tabs
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                _TabButton(
                  label: 'Overview',
                  selected: _selectedTab == _QATab.overview,
                  onTap: () => setState(() => _selectedTab = _QATab.overview),
                ),
                const SizedBox(width: 8),
                Consumer(
                  builder: (context, ref, _) {
                    final pendingAsync =
                        ref.watch(pendingCourseVersionsProvider);
                    final count = pendingAsync.valueOrNull?.length ?? 0;
                    return _TabButton(
                      label: 'Pending Approvals',
                      selected: _selectedTab == _QATab.approvals,
                      onTap: () =>
                          setState(() => _selectedTab = _QATab.approvals),
                      badge: count > 0 ? count : null,
                    );
                  },
                ),
                const SizedBox(width: 8),
                _TabButton(
                  label: 'Compliance Monitoring',
                  selected: _selectedTab == _QATab.compliance,
                  onTap: () =>
                      setState(() => _selectedTab = _QATab.compliance),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: switch (_selectedTab) {
              _QATab.overview => _OverviewTab(),
              _QATab.approvals => _ApprovalsTab(
                  onApprove: _approve,
                  onReject: _reject,
                ),
              _QATab.compliance => _ComplianceTab(),
            },
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.indigo600 : AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selected ? AppColors.indigo600 : AppColors.slate200,
                ),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: selected ? Colors.white : AppColors.slate700,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        if (badge != null)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.destructive,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              alignment: Alignment.center,
              child: Text(
                '$badge',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _OverviewTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(departmentComplianceSummaryProvider);
    final pendingAsync = ref.watch(pendingCourseVersionsProvider);

    return complianceAsync.when(
      data: (compliance) {
        final overallCompliance = compliance.isEmpty
            ? 0.0
            : compliance
                    .map((c) => c.complianceRate)
                    .reduce((a, b) => a + b) /
                compliance.length;
        final criticalDepartments =
            compliance.where((d) => d.complianceRate < 95).toList();
        final totalEmployees =
            compliance.fold<int>(0, (s, d) => s + d.totalEmployees);
        final pendingCount = pendingAsync.valueOrNull?.length ?? 0;

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(departmentComplianceSummaryProvider);
            ref.invalidate(pendingCourseVersionsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              SectionHeader(
                icon: Icons.dashboard,
                title: 'Overview',
                color: AppColors.indigo600,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600
                      ? 4
                      : (constraints.maxWidth > 400 ? 2 : 1);
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      StatCard(
                        label: 'Overall Compliance',
                        value: '${overallCompliance.toStringAsFixed(0)}%',
                        icon: Icons.trending_up,
                        iconBackgroundColor: const Color(0xFFDCFCE7),
                        iconColor: AppColors.success,
                      ),
                      StatCard(
                        label: 'Pending Approvals',
                        value: '$pendingCount',
                        icon: Icons.schedule,
                        iconBackgroundColor: const Color(0xFFFEF3C7),
                        iconColor: const Color(0xFFD97706),
                      ),
                      StatCard(
                        label: 'At-Risk Departments',
                        value: '${criticalDepartments.length}',
                        icon: Icons.warning_amber_rounded,
                        iconBackgroundColor: const Color(0xFFFEE2E2),
                        iconColor: AppColors.destructive,
                      ),
                      StatCard(
                        label: 'Total Employees',
                        value: '$totalEmployees',
                        icon: Icons.people,
                        iconBackgroundColor: AppColors.indigo100,
                        iconColor: AppColors.indigo600,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              if (criticalDepartments.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: AppColors.destructive, size: 24),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Compliance Drop Alert',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF7F1D1D),
                                    ),
                              ),
                              Text(
                                '${criticalDepartments.length} department(s) have fallen below the 95% compliance threshold.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: const Color(0xFFB91C1C),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...criticalDepartments.map((dept) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      dept.departmentName ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.slate900,
                                          ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${dept.overdue} employees overdue',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${dept.complianceRate.toStringAsFixed(1)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.destructive,
                                      ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      icon: Icons.history,
                      title: 'Recent QA Activities',
                      color: AppColors.slate600,
                    ),
                    const EmptyState(
                      message:
                          'No recent activities. Approve or reject courses to see activity here.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _ApprovalsTab extends ConsumerWidget {
  const _ApprovalsTab({
    required this.onApprove,
    required this.onReject,
  });

  final void Function(CourseVersion) onApprove;
  final void Function(CourseVersion) onReject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingCourseVersionsProvider);

    return pendingAsync.when(
      data: (pending) {
        if (pending.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded,
                    size: 48, color: AppColors.success),
                const SizedBox(height: 16),
                Text(
                  'All Caught Up!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'There are no courses pending approval at this time.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate600,
                      ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async =>
              ref.invalidate(pendingCourseVersionsProvider),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              SectionHeader(
                icon: Icons.pending_actions,
                title: 'Pending Course Approvals',
                color: const Color(0xFFD97706),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Column(
                  children: pending.asMap().entries.map((entry) {
                    final index = entry.key;
                    final v = entry.value;
                    final course = v.course;
                    final title = course?.title ?? 'Course';
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.slate200,
                            width: index < pending.length - 1 ? 1 : 0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '$title v${v.version}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.slate900,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF3C7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'PENDING APPROVAL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF854D0E),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (course?.description != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    course!.description!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.slate600,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => onReject(v),
                                child: const Text('Reject'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => onApprove(v),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                ),
                                child: const Text('Approve'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _ComplianceTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(departmentComplianceSummaryProvider);

    return complianceAsync.when(
      data: (compliance) {
        return RefreshIndicator(
          onRefresh: () async =>
              ref.invalidate(departmentComplianceSummaryProvider),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              SectionHeader(
                icon: Icons.trending_up,
                title: 'Department Compliance Monitoring',
                color: AppColors.teal600,
                action: ElevatedButton.icon(
                  onPressed: () => context.push('/compliance-report'),
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Export Report'),
                ),
              ),
              const SizedBox(height: 24),
              if (compliance.isEmpty)
                const EmptyState(message: 'No compliance data')
              else
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: Column(
                    children: compliance.map((dept) {
                      final rate = dept.complianceRate;
                      final isAtRisk = rate < 95;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isAtRisk
                              ? const Color(0xFFFEF2F2)
                              : const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isAtRisk
                                ? const Color(0xFFFECACA)
                                : const Color(0xFFBBF7D0),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dept.departmentName ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.slate900,
                                          ),
                                    ),
                                    Text(
                                      '${dept.totalEmployees} employees',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${rate.toStringAsFixed(1)}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isAtRisk
                                                ? AppColors.destructive
                                                : AppColors.success,
                                          ),
                                    ),
                                    Text(
                                      'compliance',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.slate600,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _ComplianceStat(
                                    value: '${dept.compliant}',
                                    label: 'Compliant',
                                    color: AppColors.success),
                                _ComplianceStat(
                                    value: '${dept.overdue}',
                                    label: 'Overdue',
                                    color: AppColors.destructive),
                                _ComplianceStat(
                                    value: '${dept.upcoming}',
                                    label: 'Upcoming',
                                    color: AppColors.warning),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: rate / 100,
                                minHeight: 8,
                                backgroundColor: AppColors.slate200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    isAtRisk
                                        ? AppColors.destructive
                                        : AppColors.success),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _ComplianceStat extends StatelessWidget {
  const _ComplianceStat({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.slate600,
              ),
        ),
      ],
    );
  }
}

/// Fullscreen split-pane for QA review on desktop (width > 900): left = course preview, right = checklist + actions.
class _QAReviewSplitPane extends StatefulWidget {
  const _QAReviewSplitPane({
    required this.version,
    required this.checklist,
    required this.onApprove,
    required this.onReject,
    required this.onCancel,
  });

  final CourseVersion version;
  final Map<String, bool> checklist;
  final void Function(Map<String, bool> checklist) onApprove;
  final VoidCallback onReject;
  final VoidCallback onCancel;

  @override
  State<_QAReviewSplitPane> createState() => _QAReviewSplitPaneState();
}

class _QAReviewSplitPaneState extends State<_QAReviewSplitPane> {
  Map<String, bool> get _checklist => widget.checklist;

  @override
  Widget build(BuildContext context) {
    final course = widget.version.course;
    final title = course?.title ?? 'Course';
    final description = course?.description;
    return Material(
      color: AppColors.background,
      child: SafeArea(
        child: Row(
          children: [
            // Left: course preview
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  border: Border(
                    right: BorderSide(color: AppColors.slate200),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course preview',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.slate600,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$title v${widget.version.version}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.slate600,
                            ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Placeholder: could navigate to full course preview
                      },
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Open full preview'),
                    ),
                  ],
                ),
              ),
            ),
            // Right: QA-WF-01 checklist + actions
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QA Review Checklist (QA-WF-01)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _checklist.entries
                              .map(
                                (e) => CheckboxListTile(
                                  value: e.value,
                                  onChanged: (val) {
                                    setState(() {
                                      _checklist[e.key] = val ?? false;
                                    });
                                  },
                                  title: Text(e.key),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: widget.onCancel,
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            widget.onReject();
                          },
                          child: const Text('Reject'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            if (_checklist.values.any((v) => !v)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'All checklist items must be verified'),
                                ),
                              );
                              return;
                            }
                            widget.onApprove(Map<String, bool>.from(_checklist));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.success,
                          ),
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
