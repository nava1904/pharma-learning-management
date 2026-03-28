import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/stat_card.dart';

// Define providers
final auditReadinessProvider = FutureProvider<double>((ref) async {
  final score = await client.analytics.getAuditReadinessScore();
  return score.overallScore;
});

final qualityEventsProvider = FutureProvider<int>((ref) async {
  return await client.analytics.getOpenQualityEventsCount();
});

final slaBreachesProvider = FutureProvider<List<SlaBreach>>((ref) async {
  return await client.analytics.getSlaBreaches();
});

final pendingDocumentApprovalsCountProvider = FutureProvider<int>((ref) async {
  return await client.qa.getPendingDocumentApprovalsCount();
});

final pendingCourseVersionsProvider = FutureProvider<List<CourseVersion>>((ref) async {
  return await client.qa.listPendingCourseVersions();
});

final departmentComplianceSummaryProvider = FutureProvider<List<DepartmentComplianceSummary>>((ref) async {
  return await client.analytics.getDepartmentComplianceSummary();
});

// Compliance drop alert provider - departments below 90% threshold
final complianceDropAlertsProvider = FutureProvider<List<DepartmentComplianceSummary>>((ref) async {
  final summary = await client.analytics.getDepartmentComplianceSummary();
  // Filter departments below 90% compliance (critical threshold)
  return summary.where((dept) => dept.complianceRate < 90.0).toList();
});

class QACommandCenterScreen extends ConsumerWidget {
  const QACommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(auditReadinessProvider);
          ref.invalidate(qualityEventsProvider);
          ref.invalidate(slaBreachesProvider);
          ref.invalidate(pendingDocumentApprovalsCountProvider);
          ref.invalidate(pendingCourseVersionsProvider);
          ref.invalidate(complianceDropAlertsProvider);
        },
        child: CustomScrollView(
          slivers: [
            _buildHeroSliver(context, ref),
            _buildComplianceDropAlerts(context, ref),
            _buildQuickActionsRow(context),
            _buildPendingCourseReviewsHeader(context),
            _buildPendingCourseReviews(context, ref),
            _buildActiveSLABreachesHeader(context),
            _buildActiveSLABreaches(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSliver(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(PortalLayout.contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quality & Compliance Command Center',
              style: PharmaTypography.headingLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: PharmaColors.textPrimary,
              ),
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Wrap(
              spacing: PharmaSpacing.lg,
              runSpacing: PharmaSpacing.lg,
              children: [
                StatCard(
                  label: 'Audit Readiness',
                  icon: Icons.check_circle,
                  value: ref.watch(auditReadinessProvider).when(
                        data: (score) => '${score.toStringAsFixed(1)}%',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: PharmaColors.infoBg,
                  iconColor: PharmaColors.info,
                ),
                StatCard(
                  label: 'Open Quality Events',
                  icon: Icons.warning,
                  value: ref.watch(qualityEventsProvider).when(
                        data: (count) => '$count',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: PharmaColors.warningBg,
                  iconColor: PharmaColors.warningText,
                ),
                StatCard(
                  label: 'Active SLA Breaches',
                  icon: Icons.error,
                  value: ref.watch(slaBreachesProvider).when(
                        data: (breaches) => '${breaches.length}',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: PharmaColors.dangerBg,
                  iconColor: PharmaColors.danger,
                ),
                StatCard(
                  label: 'Pending Approvals',
                  icon: Icons.pending,
                  value: ref.watch(pendingDocumentApprovalsCountProvider).when(
                        data: (count) => '$count',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: PharmaColors.emerald50,
                  iconColor: PharmaColors.emerald600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceDropAlerts(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(complianceDropAlertsProvider);
    
    return alertsAsync.when(
      data: (alerts) {
        if (alerts.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(PortalLayout.contentPadding),
            child: Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PharmaColors.danger.withValues(alpha: 0.08),
                    PharmaColors.warning.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: PharmaRadius.cardRadius,
                border: Border.all(color: PharmaColors.danger.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(PharmaSpacing.sm),
                        decoration: BoxDecoration(
                          color: PharmaColors.dangerBg,
                          borderRadius: PharmaRadius.cardRadius,
                        ),
                        child: const Icon(
                          Icons.trending_down,
                          color: PharmaColors.danger,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: PharmaSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Compliance Drop Alert',
                              style: PharmaTypography.headingSmall.copyWith(
                                fontWeight: FontWeight.w700,
                                color: PharmaColors.danger,
                              ),
                            ),
                            Text(
                              '${alerts.length} department(s) below 90% compliance threshold',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () => context.push('/compliance-report'),
                        style: FilledButton.styleFrom(
                          backgroundColor: PharmaColors.dangerBg,
                          foregroundColor: PharmaColors.danger,
                        ),
                        child: const Text('View Report'),
                      ),
                    ],
                  ),
                  const SizedBox(height: PharmaSpacing.md),
                  Wrap(
                    spacing: PharmaSpacing.sm,
                    runSpacing: PharmaSpacing.sm,
                    children: alerts.map((dept) => Chip(
                      avatar: CircleAvatar(
                        backgroundColor: dept.complianceRate < 80
                            ? PharmaColors.danger
                            : PharmaColors.warning,
                        child: Text(
                          '${dept.complianceRate.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      label: Text(dept.departmentName ?? 'Unknown'),
                      backgroundColor: dept.complianceRate < 80
                          ? PharmaColors.dangerBg
                          : PharmaColors.warningBg,
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      error: (e, st) => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }

  Widget _buildQuickActionsRow(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PortalLayout.contentPadding, vertical: PharmaSpacing.sm),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              QuickActionButton(
                label: 'Quality Events',
                icon: Icons.event,
                onPressed: () => context.push('/quality-events'),
              ),
              QuickActionButton(
                label: 'E-Signatures',
                icon: Icons.fingerprint,
                onPressed: () => context.push('/auditor/esignatures'),
              ),
              QuickActionButton(
                label: 'Documents',
                icon: Icons.description,
                onPressed: () => context.push('/documents'),
              ),
              QuickActionButton(
                label: 'Audit Trail',
                icon: Icons.track_changes,
                onPressed: () => context.push('/audit-trail'),
              ),
              QuickActionButton(
                label: 'Event Triggers',
                icon: Icons.bolt,
                onPressed: () => context.push('/event-triggers'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPendingCourseReviewsHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(PortalLayout.contentPadding, PharmaSpacing.lg, PortalLayout.contentPadding, PharmaSpacing.sm),
        child: Text(
          'Pending Course Reviews',
          style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildPendingCourseReviews(BuildContext context, WidgetRef ref) {
    final courseVersionsAsync = ref.watch(pendingCourseVersionsProvider);

    return courseVersionsAsync.when(
      data: (courseVersions) {
        if (courseVersions.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(PortalLayout.contentPadding),
              child: EmptyState(message: 'No pending course reviews.'),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final course = courseVersions[index];
              return _CourseReviewTile(course: course);
            },
            childCount: courseVersions.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(PortalLayout.contentPadding),
          child: EmptyState(message: 'Failed to load course reviews.'),
        ),
      ),
    );
  }

  Widget _buildActiveSLABreachesHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(PortalLayout.contentPadding, PharmaSpacing.lg, PortalLayout.contentPadding, PharmaSpacing.sm),
        child: Text(
          'Active SLA Breaches',
          style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildActiveSLABreaches(BuildContext context, WidgetRef ref) {
    final breachesAsync = ref.watch(slaBreachesProvider);

    return breachesAsync.when(
      data: (breaches) {
        if (breaches.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(PortalLayout.contentPadding),
              child: EmptyState(message: 'No active SLA breaches.'),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final breach = breaches[index];
              return _SLABreachTile(breach: breach);
            },
            childCount: breaches.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(PortalLayout.contentPadding),
          child: EmptyState(message: 'Failed to load SLA breaches.'),
        ),
      ),
    );
  }
}

/// Tile for reviewing/approving a course version
class _CourseReviewTile extends ConsumerStatefulWidget {
  final CourseVersion course;

  const _CourseReviewTile({required this.course});

  @override
  ConsumerState<_CourseReviewTile> createState() => _CourseReviewTileState();
}

class _CourseReviewTileState extends ConsumerState<_CourseReviewTile> {
  void _openFullCourseReview() {
    context.push('/qa/course/${widget.course.courseId}/review');
  }

  @override
  Widget build(BuildContext context) {
    final courseTitle = widget.course.course?.title ?? 'Course #${widget.course.courseId}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PortalLayout.contentPadding, vertical: PharmaSpacing.xs),
      child: Card(
        elevation: 0,
        color: PharmaColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.cardRadius,
          side: const BorderSide(color: PharmaColors.borderLight),
        ),
        child: ListTile(
          title: Text(courseTitle, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          subtitle: Text(
            'Version: ${widget.course.version} · ${widget.course.status}',
            style: PharmaTypography.caption,
          ),
          trailing: FilledButton(
            onPressed: _openFullCourseReview,
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg),
            child: const Text('Open review'),
          ),
        ),
      ),
    );
  }
}

/// Tile for SLA breach escalation
class _SLABreachTile extends StatefulWidget {
  final SlaBreach breach;

  const _SLABreachTile({required this.breach});

  @override
  State<_SLABreachTile> createState() => _SLABreachTileState();
}

class _SLABreachTileState extends State<_SLABreachTile> {
  bool _loading = false;

  Future<void> _viewDetails() async {
    setState(() => _loading = true);
    try {
      // Navigate to SLA policy details
      if (mounted) {
        context.push('/admin/analytics/dashboard');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final policyMetric = widget.breach.slaPolicy?.metric ?? 'SLA Policy #${widget.breach.slaPolicyId}';
    final threshold = widget.breach.slaPolicy?.threshold.toStringAsFixed(0) ?? 'N/A';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PortalLayout.contentPadding, vertical: PharmaSpacing.xs),
      child: Card(
        elevation: 0,
        color: PharmaColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.cardRadius,
          side: const BorderSide(color: PharmaColors.borderLight),
        ),
        child: ListTile(
          title: Text(policyMetric, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          subtitle: Text('Threshold: $threshold% • Breached: ${_formatDate(widget.breach.breachedAt)}', style: PharmaTypography.caption),
          trailing: _loading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : FilledButton.tonal(
                  onPressed: _viewDetails,
                  style: FilledButton.styleFrom(foregroundColor: PharmaColors.emerald700),
                  child: const Text('View'),
                ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const QuickActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: PharmaSpacing.lg),
      elevation: 0,
      color: PharmaColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: PharmaRadius.cardRadius,
        side: const BorderSide(color: PharmaColors.borderLight),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: PharmaRadius.cardRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: PharmaSpacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: PharmaColors.emerald600),
              const SizedBox(width: PharmaSpacing.sm),
              Text(
                label,
                style: PharmaTypography.bodyMedium.copyWith(
                  color: PharmaColors.emerald700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
