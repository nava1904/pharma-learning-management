import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/stat_card.dart';
import '../esignature/esignature_screen.dart' show showEsignatureModal;

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
      backgroundColor: AppColors.slate50,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quality & Compliance Command Center',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                StatCard(
                  label: 'Audit Readiness',
                  icon: Icons.check_circle,
                  value: ref.watch(auditReadinessProvider).when(
                        data: (score) => '${score.toStringAsFixed(1)}%',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: AppColors.backgroundAlt,
                  iconColor: AppColors.indigo600,
                ),
                StatCard(
                  label: 'Open Quality Events',
                  icon: Icons.warning,
                  value: ref.watch(qualityEventsProvider).when(
                        data: (count) => '$count',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: AppColors.backgroundAlt,
                  iconColor: AppColors.amber600,
                ),
                StatCard(
                  label: 'Active SLA Breaches',
                  icon: Icons.error,
                  value: ref.watch(slaBreachesProvider).when(
                        data: (breaches) => '${breaches.length}',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: AppColors.backgroundAlt,
                  iconColor: AppColors.destructive,
                ),
                StatCard(
                  label: 'Pending Approvals',
                  icon: Icons.pending,
                  value: ref.watch(pendingDocumentApprovalsCountProvider).when(
                        data: (count) => '$count',
                        loading: () => 'Loading...',
                        error: (e, st) => 'Error',
                      ),
                  iconBackgroundColor: AppColors.backgroundAlt,
                  iconColor: AppColors.teal600,
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
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.destructive.withValues(alpha: 0.1),
                    AppColors.amber600.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.destructive.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.destructive.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.trending_down,
                          color: AppColors.destructive,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Compliance Drop Alert',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.destructive,
                              ),
                            ),
                            Text(
                              '${alerts.length} department(s) below 90% compliance threshold',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.slate600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () => context.push('/compliance-report'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.destructive.withValues(alpha: 0.2),
                        ),
                        child: const Text('View Report'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: alerts.map((dept) => Chip(
                      avatar: CircleAvatar(
                        backgroundColor: dept.complianceRate < 80 
                            ? AppColors.destructive 
                            : AppColors.amber600,
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
                          ? AppColors.destructive.withValues(alpha: 0.1)
                          : AppColors.amber600.withValues(alpha: 0.1),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Text(
          'Pending Course Reviews',
          style: Theme.of(context).textTheme.titleLarge,
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
              padding: EdgeInsets.all(16.0),
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
          padding: EdgeInsets.all(16.0),
          child: EmptyState(message: 'Failed to load course reviews.'),
        ),
      ),
    );
  }

  Widget _buildActiveSLABreachesHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Text(
          'Active SLA Breaches',
          style: Theme.of(context).textTheme.titleLarge,
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
              padding: EdgeInsets.all(16.0),
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
          padding: EdgeInsets.all(16.0),
          child: EmptyState(message: 'Failed to load SLA breaches.'),
        ),
      ),
    );
  }
}

/// Tile for reviewing/approving a course version
class _CourseReviewTile extends StatefulWidget {
  final CourseVersion course;

  const _CourseReviewTile({required this.course});

  @override
  State<_CourseReviewTile> createState() => _CourseReviewTileState();
}

class _CourseReviewTileState extends State<_CourseReviewTile> {
  bool _loading = false;

  Future<void> _approveCourse() async {
    final esignatureId = await showEsignatureModal(
      context,
      entityType: 'course_version',
      entityId: widget.course.id.toString(),
      signatureMeaning: 'Approved for publication',
    );

    if (esignatureId == null || !mounted) return;

    setState(() => _loading = true);
    try {
      await client.qa.approveCourseVersion(
        courseVersionId: widget.course.id!,
        passwordPlaintext: '', // E-signature already captured
        signatureMeaning: 'Approved for publication',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course approved successfully.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseTitle = widget.course.course?.title ?? 'Course #${widget.course.courseId}';
    return ListTile(
      title: Text(courseTitle),
      subtitle: Text('Version: ${widget.course.version}'),
      trailing: _loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : ElevatedButton(
              onPressed: _approveCourse,
              child: const Text('Review'),
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
        context.push('/admin/sla-policies');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final policyMetric = widget.breach.slaPolicy?.metric ?? 'SLA Policy #${widget.breach.slaPolicyId}';
    final threshold = widget.breach.slaPolicy?.threshold.toStringAsFixed(0) ?? 'N/A';
    return ListTile(
      title: Text(policyMetric),
      subtitle: Text('Threshold: $threshold% • Breached: ${_formatDate(widget.breach.breachedAt)}'),
      trailing: _loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : FilledButton.tonal(
              onPressed: _viewDetails,
              child: const Text('View'),
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
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
