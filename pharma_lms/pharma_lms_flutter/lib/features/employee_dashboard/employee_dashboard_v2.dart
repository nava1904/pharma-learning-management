// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE DASHBOARD V2 (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Pixel-matched to React reference: Overview.tsx
// Uses real data from Serverpod via dashboardSummaryProvider
//
// FRD Requirements Covered:
//   FR-07-01 AC-01: Compliance score = completed ÷ assigned(due≤today) × 100
//   FR-07-01 AC-02: Assignment list sorted urgency-first
//   FR-07-01 AC-03: Expiring certificates panel (30/60/90 days)
//   FR-07-01 AC-04: Recent activity: last 5 completed courses with date
//   FR-07-01 AC-05: Unread notifications badge (via shell header)
//   FR-07-01 AC-06: SOP retraining queue
//   FR-07-01 AC-07: Dashboard loads w  ithin 3 seconds P95
//   FR-07-01 AC-08: Data freshness ≤ 5 min cache TTL; "Last updated" shown
//   EMP-WF-02: View Dashboard event workflow (AccessLog page_view)
//   EMP-01: User story — compliance %, urgency sort, expiring certs, recent activity
//
// Layout:
// ┌─────────────────────────────────────────────────────────────────────────────┐
// │  Welcome Card: Hello {name} + email + stats grid + avatar                  │
// ├─────────────────────────────────────────────────────────────────────────────┤
// │  Continue Learning, overdue / deadlines, recent activity, e-sign, alerts   │
// └─────────────────────────────────────────────────────────────────────────────┘
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show Enrollment;

import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';
import '../../providers/user_provider.dart';
import '../shared/communication_sheets.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN DASHBOARD SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class EmployeeDashboardV2 extends ConsumerWidget {
  const EmployeeDashboardV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardSummaryProvider);

    return dashboardAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: PharmaColors.emerald500),
      ),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 16),
            Text('Error loading dashboard', style: PharmaTypography.headingSmall),
            const SizedBox(height: 8),
            Text('$e', style: PharmaTypography.caption),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                invalidateEmployeeDashboard(ref);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (summary) => _DashboardContent(summary: summary),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DASHBOARD CONTENT — FULL LAYOUT
// ═══════════════════════════════════════════════════════════════════════════════

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastUpdated = ref.watch(employeeDashboardLastUpdatedProvider);

    return RefreshIndicator(
      color: PharmaColors.emerald600,
      onRefresh: () async {
        invalidateEmployeeDashboard(ref);
        await ref.read(dashboardSummaryProvider.future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Page header — "Compliance & activity" + greeting + avatar
            _ComplianceDashboardHeader(summary: summary),
            const SizedBox(height: 16),

            // 2. TOP ROW — Compliance overview (donut + scores) | Overdue table
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 900;
                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ComplianceOverviewCard(summary: summary),
                      const SizedBox(height: 12),
                      _EsignatureReadinessCard(summary: summary),
                      const SizedBox(height: 12),
                      _OverdueTrainingsBreakdownCard(summary: summary),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: Column(
                      children: [
                        _ComplianceOverviewCard(summary: summary),
                        const SizedBox(height: 12),
                        _EsignatureReadinessCard(summary: summary),
                      ],
                    )),
                    const SizedBox(width: 16),
                    Expanded(flex: 5, child: _OverdueTrainingsBreakdownCard(summary: summary)),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),

            // 3. SECOND ROW — Recent activity | Learning progress
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 1000;
                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _RecentActivityCard(activities: summary.recentActivity),
                      const SizedBox(height: 12),
                      _LearningProgressCarousel(summary: summary),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _RecentActivityCard(activities: summary.recentActivity)),
                    const SizedBox(width: 16),
                    Expanded(flex: 5, child: _LearningProgressCarousel(summary: summary)),
                  ],
                );
              },
            ),

            // 4. COMPLIANCE ALERTS — PHARMA REGULATORY CRITICAL
            if (summary.complianceAlerts.isNotEmpty || summary.compliance.overdueCount > 0) ...[
              const SizedBox(height: 16),
              _ComplianceAlertsSection(
                alerts: summary.complianceAlerts,
                overdueCount: summary.compliance.overdueCount,
              ),
            ],

            // 6. LAST UPDATED TIMESTAMP (FR-07-01 AC-08)
            const SizedBox(height: 16),
            Center(
              child: Text(
                lastUpdated != null
                    ? 'Last updated ${_formatTimeAgo(lastUpdated)}'
                    : 'Last updated just now',
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textQuaternary,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat.yMd().format(dt);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COMPLIANCE DASHBOARD — Header + top row + second row (reference layout)
// ═══════════════════════════════════════════════════════════════════════════════

class _ComplianceDashboardHeader extends StatelessWidget {
  const _ComplianceDashboardHeader({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compliance & activity',
                style: PharmaTypography.caption.copyWith(
                  color: PharmaColors.textTertiary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hello, ${summary.user.firstName}',
                style: PharmaTypography.headingLarge.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
        // Avatar removed
      ],
    );
  }
}

class _ComplianceOverviewCard extends StatelessWidget {
  const _ComplianceOverviewCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final rate = summary.complianceScorePercent.round();
    final perf = summary.performanceScorePercent;
    final c = summary.enrollmentCompleteCount;
    final ip = summary.enrollmentInProgressCount;
    final od = summary.enrollmentOverdueCount;
    final sum = c + ip + od;

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance overview', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          if (sum == 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'No enrollments yet',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                ),
              ),
            )
          else
            Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 44,
                      sections: [
                        if (c > 0)
                          PieChartSectionData(
                            color: PharmaColors.emerald500,
                            value: c.toDouble(),
                            radius: 28,
                            showTitle: false,
                          ),
                        if (ip > 0)
                          PieChartSectionData(
                            color: PharmaColors.warning,
                            value: ip.toDouble(),
                            radius: 28,
                            showTitle: false,
                          ),
                        if (od > 0)
                          PieChartSectionData(
                            color: PharmaColors.danger,
                            value: od.toDouble(),
                            radius: 28,
                            showTitle: false,
                          ),
                        if (c == 0 && ip == 0 && od == 0)
                          PieChartSectionData(
                            color: PharmaColors.gray200,
                            value: 1,
                            radius: 28,
                            showTitle: false,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: PharmaSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$rate%',
                        style: PharmaTypography.headingLarge.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: PharmaColors.emerald700,
                        ),
                      ),
                      Text(
                        'Compliance score (target 100%)',
                        style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                      ),
                      const SizedBox(height: PharmaSpacing.sm),
                      Text(
                        summary.hasAssessmentScores && perf != null
                            ? 'Performance score: ${perf.round()}%'
                            : 'Performance score: —',
                        style: PharmaTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: PharmaColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Average assessment score',
                        style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: PharmaSpacing.md),
          Text(
            'Compliance score: $rate% (target 100%)',
            style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.sm),
          Wrap(
            spacing: PharmaSpacing.md,
            runSpacing: 8,
            children: [
              _LegendDot(color: PharmaColors.danger, label: '$od overdue (enrollments)'),
              _LegendDot(color: PharmaColors.emerald500, label: '$c complete'),
              _LegendDot(color: PharmaColors.warning, label: '$ip in progress'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: PharmaTypography.caption),
      ],
    );
  }
}

/// Nested scrollables on web: [Scrollbar] must use the same [ScrollController] as the
/// [ListView], or the bar has no [ScrollPosition] (PrimaryScrollController mismatch).
class _LinkedScrollbarList extends StatefulWidget {
  const _LinkedScrollbarList({
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
  });

  final double height;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Axis scrollDirection;

  @override
  State<_LinkedScrollbarList> createState() => _LinkedScrollbarListState();
}

class _LinkedScrollbarListState extends State<_LinkedScrollbarList> {
  late final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        child: widget.separatorBuilder != null
            ? ListView.separated(
                controller: _controller,
                scrollDirection: widget.scrollDirection,
                padding: EdgeInsets.zero,
                itemCount: widget.itemCount,
                separatorBuilder: widget.separatorBuilder!,
                itemBuilder: widget.itemBuilder,
              )
            : ListView.builder(
                controller: _controller,
                scrollDirection: widget.scrollDirection,
                padding: EdgeInsets.zero,
                itemCount: widget.itemCount,
                itemBuilder: widget.itemBuilder,
              ),
      ),
    );
  }
}

Map<String, dynamic>? _dueRowForEnrollment(
  Enrollment e,
  DashboardSummary summary,
) {
  final title = e.courseVersion?.course?.title;
  for (final d in summary.upcomingDueDates) {
    if (e.assignmentId != null && d['assignmentId'] == e.assignmentId) {
      return d;
    }
    if (title != null && d['courseTitle'] == title) return d;
  }
  return null;
}

class _OverdueTrainingsBreakdownCard extends StatelessWidget {
  const _OverdueTrainingsBreakdownCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final overdue = List<Map<String, dynamic>>.from(summary.overdueItems);

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overdue trainings', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          if (overdue.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  summary.overdueDetailIncomplete
                      ? 'Overdue items are reported by compliance, but this list could not be loaded. '
                          'Pull to refresh. If the problem persists, open Assigned training or My Learning.'
                      : 'No overdue items. This list shows active assignments past their due date '
                          'and expired certificates. If you just created an account or have no assignments yet, '
                          'nothing will appear here.',
                  textAlign: TextAlign.center,
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
                ),
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Course', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Text('Tag', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Text('Overdue', style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 72),
              ],
            ),
            const Divider(height: 16),
            _LinkedScrollbarList(
              height: 300,
              itemCount: overdue.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                    final item = overdue[index];
                    final kind = item['kind'] as String? ?? 'assignment';
                    final title = item['courseTitle'] as String? ?? 'Course';
                    final tag = item['regulatoryTag'] as String? ??
                        item['courseCategory'] as String? ??
                        item['sopNumber'] as String? ??
                        'GMP';
                    final days = item['daysOverdue'] as int? ?? 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: PharmaTypography.body,
                                ),
                                if (kind == 'certificate_expired')
                                  Text(
                                    'Expired certificate',
                                    style: PharmaTypography.caption
                                        .copyWith(color: PharmaColors.textTertiary),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              tag,
                              style: PharmaTypography.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$days days',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.danger,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 88,
                            child: FilledButton(
                              onPressed: () {
                                if (kind == 'certificate_expired') {
                                  context.go('/employee/credentials');
                                } else {
                                  context.go('/employee/lessons');
                                }
                              },
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                backgroundColor: PharmaColors.danger,
                              ),
                              child: Text(
                                kind == 'certificate_expired' ? 'Renew' : 'Start',
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
            ),
            if (overdue.length > 4)
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => context.go('/employee/lessons'),
                  child: Text('View all ${overdue.length}'),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _EsignatureReadinessCard extends StatelessWidget {
  const _EsignatureReadinessCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final rows = summary.esignatureSummary;
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('E-signature readiness', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'No pending signatures. Items appear when training requires acknowledgement.',
                style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontSize: 11),
              ),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 160),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: rows.length > 5 ? 5 : rows.length,
                separatorBuilder: (_, __) => Divider(height: 1, color: PharmaColors.borderLight),
                itemBuilder: (context, i) {
                  final row = rows[i];
                  final kind = row['kind'] as String? ?? '';
                  final title = row['courseTitle'] as String? ?? 'Training';
                  if (kind == 'signed') {
                    final at = row['signedAt'] as String?;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: PharmaTypography.bodyMedium.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                if (at != null)
                                  Text(
                                    'Signed: ${_fmtShort(at)}',
                                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary, fontSize: 10),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: PharmaColors.emerald50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'E-signed',
                              style: PharmaTypography.caption.copyWith(
                                color: PharmaColors.emerald700,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: PharmaTypography.bodyMedium.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(
                                kind == 'pending_ack'
                                    ? 'Acknowledgement required'
                                    : 'Signature required',
                                style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 26,
                          child: FilledButton(
                            onPressed: () => context.go('/employee/lessons'),
                            style: FilledButton.styleFrom(
                              backgroundColor: PharmaColors.danger,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                              textStyle: const TextStyle(fontSize: 11),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Sign now'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  String _fmtShort(String iso) {
    try {
      return DateFormat.yMMMd().format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return iso;
    }
  }
}

class _LearningProgressCarousel extends StatelessWidget {
  const _LearningProgressCarousel({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final list = [...summary.inProgress, ...summary.toDo];
    final dueLookup = <int, Map<String, dynamic>>{};
    for (final d in summary.upcomingDueDates) {
      final aid = d['assignmentId'] as int?;
      if (aid != null) dueLookup[aid] = d;
    }

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Learning progress', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          if (list.isEmpty)
            Text(
              'No active courses',
              style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
            )
          else
            _LinkedScrollbarList(
              height: 220,
              scrollDirection: Axis.horizontal,
              itemCount: list.length.clamp(0, 16),
              separatorBuilder: (_, _) => const SizedBox(width: PharmaSpacing.md),
              itemBuilder: (context, index) {
                    final e = list[index];
                    final course = e.courseVersion?.course;
                    Map<String, dynamic>? due;
                    if (e.assignmentId != null) {
                      due = dueLookup[e.assignmentId!];
                    }
                    due ??= _dueRowForEnrollment(e, summary);
                    final isOverdue = due?['isOverdue'] == true;
                    final priority = due?['priority'] as String?;
                    // Use real progress from server MaterialProgress data
                    final progress = e.status == 'completed'
                        ? 100.0
                        : (summary.enrollmentProgressMap[e.id] ?? _progressFromStatus(e.status));
                    return SizedBox(
                      width: 200,
                      child: Material(
                        color: PharmaColors.surface,
                        borderRadius: PharmaRadius.cardRadius,
                        child: InkWell(
                          onTap: () => context.go(
                            '/employee/course/${course?.id ?? e.courseVersionId}',
                            extra: {
                              'courseVersionId': e.courseVersionId.toString(),
                              'enrollmentId': e.id?.toString(),
                            },
                          ),
                          borderRadius: PharmaRadius.cardRadius,
                          child: Container(
                            padding: const EdgeInsets.all(PharmaSpacing.md),
                            decoration: BoxDecoration(
                              borderRadius: PharmaRadius.cardRadius,
                              border: Border.all(color: PharmaColors.borderLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        course?.title ?? 'Course',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    if (isOverdue)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: PharmaColors.dangerBg,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Overdue',
                                          style: PharmaTypography.caption.copyWith(
                                            color: PharmaColors.danger,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${progress.round()}% complete',
                                      style: PharmaTypography.caption.copyWith(
                                        color: PharmaColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (e.status == 'not_started' || e.status == 'assigned')
                                      Text(
                                        'Not started',
                                        style: PharmaTypography.caption.copyWith(
                                          color: PharmaColors.textTertiary,
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: progress / 100,
                                    minHeight: 6,
                                    backgroundColor: PharmaColors.gray200,
                                    color: isOverdue
                                        ? PharmaColors.danger
                                        : PharmaColors.emerald500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (due != null)
                                  Text(
                                    'Due: ${_dueLabel(due)}',
                                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                                  ),
                                if (priority != null && priority.isNotEmpty)
                                  Text(
                                    'Priority: $priority',
                                    style: PharmaTypography.caption.copyWith(
                                      color: priority.toLowerCase() == 'high'
                                          ? PharmaColors.danger
                                          : PharmaColors.warning,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
            ),
        ],
      ),
    );
  }

  /// Fallback when real server progress is unavailable.
  double _progressFromStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 100;
      case 'in_progress':
        return 25; // conservative estimate — real value preferred
      case 'overdue':
        return 10;
      default: // not_started, assigned
        return 0;
    }
  }

  String _dueLabel(Map<String, dynamic> due) {
    final iso = due['dueDate'] as String?;
    if (iso == null) return '—';
    try {
      return DateFormat.yMMMd().format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return iso;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 1. WELCOME CARD (retained for future / alternate layouts)
// ═══════════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final complianceRate = summary.compliance.complianceRate.toInt();

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting + Compliance Score row
              isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGreeting(),
                        const SizedBox(height: PharmaSpacing.lg),
                        _buildComplianceGauge(complianceRate),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildGreeting()),
                        const SizedBox(width: PharmaSpacing.xxl),
                        _buildComplianceGauge(complianceRate),
                      ],
                    ),

              const SizedBox(height: PharmaSpacing.xxl),

              // 4 Stat Cards per FRD spec: OVERDUE / DUE THIS WEEK / IN PROGRESS / COMPLETED
              _buildStatCards(isNarrow: isNarrow),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, ${summary.user.firstName} 👋',
          style: PharmaTypography.headingLarge,
        ),
        const SizedBox(height: 4),
        Text(
          summary.user.email,
          style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
        ),
        if (summary.user.department?.name != null || summary.user.jobRole?.name != null) ...[
          const SizedBox(height: 2),
          Text(
            [summary.user.department?.name, summary.user.jobRole?.name]
                .where((s) => s != null && s.isNotEmpty)
                .join(' · '),
            style: PharmaTypography.caption,
          ),
        ],
      ],
    );
  }

  /// FR-07-01 AC-01: Compliance score = completed ÷ assigned(due≤today) × 100
  Widget _buildComplianceGauge(int rate) {
    final gaugeColor = rate >= 90
        ? PharmaColors.emerald500
        : rate >= 70
            ? PharmaColors.warning
            : PharmaColors.danger;

    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: rate / 100,
                  strokeWidth: 6,
                  backgroundColor: PharmaColors.gray200,
                  valueColor: AlwaysStoppedAnimation(gaugeColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '$rate%',
                style: PharmaTypography.headingMedium.copyWith(color: gaugeColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('Compliance', style: PharmaTypography.caption),
      ],
    );
  }

  Widget _buildStatCards({required bool isNarrow}) {
    final dueThisWeekCount = summary.upcomingDueDates.where((d) {
      final daysUntilDue = d['daysUntilDue'] as int? ?? 999;
      return daysUntilDue >= 0 && daysUntilDue <= 7;
    }).length;

    final stats = [
      _StatData(
        title: 'OVERDUE (ITEMS)',
        value: summary.compliance.overdueCount.toString(),
        icon: Icons.error_rounded,
        accentColor: PharmaColors.danger,
      ),
      _StatData(
        title: 'DUE THIS WEEK',
        value: dueThisWeekCount.toString(),
        icon: Icons.schedule_rounded,
        accentColor: PharmaColors.warning,
      ),
      _StatData(
        title: 'IN PROGRESS',
        value: summary.inProgress.length.toString(),
        icon: Icons.play_circle_rounded,
        accentColor: PharmaColors.info,
      ),
      _StatData(
        title: 'COMPLETED',
        value: summary.completed.length.toString(),
        icon: Icons.check_circle_rounded,
        accentColor: PharmaColors.emerald500,
      ),
    ];

    if (isNarrow) {
      return Wrap(
        spacing: PharmaSpacing.md,
        runSpacing: PharmaSpacing.md,
        children: stats.map((s) => SizedBox(
          width: double.infinity,
          child: _StatItem(data: s),
        )).toList(),
      );
    }

    return Row(
      children: stats.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: entry.key < stats.length - 1 ? PharmaSpacing.md : 0,
            ),
            child: _StatItem(data: entry.value),
          ),
        );
      }).toList(),
    );
  }
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _StatData({
    required this.title,
    required this.value,
    required this.icon,
    this.accentColor = PharmaColors.gray900,
  });
}

/// FRD SCR-03: Stat card with colored bottom bar accent
class _StatItem extends StatelessWidget {
  const _StatItem({required this.data});

  final _StatData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.surface,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: PharmaColors.textQuaternary,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: data.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PharmaRadius.md),
                ),
                child: Icon(data.icon, color: data.accentColor, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(data.value, style: PharmaTypography.statNumber),
          const SizedBox(height: 8),
          // Colored bottom bar per FRD spec
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: data.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 3. CONTINUE LEARNING SECTION
// ═══════════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _ContinueLearningSection extends StatelessWidget {
  const _ContinueLearningSection({required this.enrollments});

  final List enrollments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Continue Learning', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              if (isNarrow) {
                return Column(
                  children: enrollments.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: PharmaSpacing.lg),
                    child: _CourseCard(enrollment: e),
                  )).toList(),
                );
              }
              final cardWidth = (constraints.maxWidth - 32) / 3;
              return Wrap(
                spacing: PharmaSpacing.lg,
                runSpacing: PharmaSpacing.lg,
                children: enrollments.map((e) => SizedBox(
                  width: cardWidth,
                  child: _CourseCard(enrollment: e),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatefulWidget {
  const _CourseCard({required this.enrollment});

  final dynamic enrollment;

  @override
  State<_CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<_CourseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final enrollment = widget.enrollment;
    final course = enrollment.courseVersion?.course;
    final status = enrollment.status ?? 'not_started';
    final progress = _calculateProgress(status);
    final colors = _getCourseGradient(course?.description);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.go('/employee/course/${course?.id ?? enrollment.courseVersionId}', extra: {
            'courseVersionId': enrollment.courseVersionId.toString(),
            'enrollmentId': enrollment.id?.toString(),
          });
        },
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
            boxShadow: _isHovered ? PharmaShadows.cardHoverShadow : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getCourseIcon(course?.description),
                      size: 36,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PharmaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course?.title ?? 'Course',
                      style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course?.description ?? 'Training Module',
                      style: PharmaTypography.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress: ${progress.toInt()}%',
                          style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                        ),
                        Text(
                          'Continue',
                          style: PharmaTypography.body.copyWith(color: PharmaColors.emerald600, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateProgress(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return 100.0;
      case 'in_progress': return 50.0;
      case 'not_started':
      case 'assigned': return 0.0;
      default: return 0.0;
    }
  }

  List<Color> _getCourseGradient(String? category) {
    switch (category?.toLowerCase()) {
      case 'gmp':
      case 'manufacturing':
        return [PharmaColors.emerald600, PharmaColors.emerald500];
      case 'safety':
      case 'sop':
        return [const Color(0xFF3B82F6), const Color(0xFF60A5FA)];
      case 'quality':
      case 'qc':
        return [const Color(0xFF8B5CF6), const Color(0xFFA78BFA)];
      case 'regulatory':
        return [const Color(0xFFF59E0B), const Color(0xFFFBBF24)];
      default:
        return [PharmaColors.gray600, PharmaColors.gray400];
    }
  }

  IconData _getCourseIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'gmp':
      case 'manufacturing': return Icons.precision_manufacturing_rounded;
      case 'safety':
      case 'sop': return Icons.health_and_safety_rounded;
      case 'quality':
      case 'qc': return Icons.verified_rounded;
      case 'regulatory': return Icons.policy_rounded;
      default: return Icons.menu_book_rounded;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 4A. UPCOMING DEADLINES CARD
// ═══════════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _UpcomingDeadlinesCard extends StatelessWidget {
  const _UpcomingDeadlinesCard({required this.dueDates});

  final List<Map<String, dynamic>> dueDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upcoming Deadlines', style: PharmaTypography.headingMedium),
              if (dueDates.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: PharmaSpacing.xs),
                  decoration: BoxDecoration(color: PharmaColors.warningBg, borderRadius: PharmaRadius.pillRadius),
                  child: Text('${dueDates.length}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: PharmaColors.warningText)),
                ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.lg),
          if (dueDates.isEmpty)
            const _EmptyState(icon: Icons.event_available_rounded, message: 'No upcoming deadlines')
          else
            ...dueDates.take(4).map((item) {
              final isOverdue = item['isOverdue'] == true;
              final daysUntilDue = item['daysUntilDue'] as int? ?? 0;
              final courseTitle = item['courseTitle'] as String? ?? 'Training';
              final (iconColor, bgColor, badgeText) = _getUrgencyStyle(isOverdue, daysUntilDue);

              return Padding(
                padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                      child: Icon(
                        isOverdue ? Icons.warning_amber_rounded : daysUntilDue <= 7 ? Icons.schedule_rounded : Icons.event_rounded,
                        color: iconColor, size: 18,
                      ),
                    ),
                    const SizedBox(width: PharmaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(courseTitle, style: PharmaTypography.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 2),
                          Text(_formatDueDate(item['dueDate'] as String?), style: PharmaTypography.caption),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: PharmaSpacing.xs),
                      decoration: BoxDecoration(color: bgColor, borderRadius: PharmaRadius.pillRadius),
                      child: Text(badgeText, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: iconColor)),
                    ),
                  ],
                ),
              );
            }),
          if (dueDates.length > 4) ...[
            const SizedBox(height: PharmaSpacing.sm),
            Center(
              child: TextButton(
                onPressed: () => context.go('/employee/lessons'),
                child: Text('View all ${dueDates.length} deadlines', style: PharmaTypography.body.copyWith(color: PharmaColors.emerald600, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  (Color, Color, String) _getUrgencyStyle(bool isOverdue, int daysUntilDue) {
    if (isOverdue) return (PharmaColors.danger, PharmaColors.dangerBg, '${daysUntilDue.abs()}d overdue');
    if (daysUntilDue <= 3) return (PharmaColors.danger, PharmaColors.dangerBg, 'Due in ${daysUntilDue}d');
    if (daysUntilDue <= 7) return (PharmaColors.warning, PharmaColors.warningBg, 'Due in ${daysUntilDue}d');
    return (PharmaColors.info, PharmaColors.infoBg, 'Due in ${daysUntilDue}d');
  }

  String _formatDueDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat.MMMd().format(date);
    } catch (_) {
      return '';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 4B. RECENT ACTIVITY CARD
// FR-07-01 AC-04: Last 5 completed courses with date
// ═══════════════════════════════════════════════════════════════════════════════

int? _parseActivityInt(Object? v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

/// Opens the course viewer for context, then the instructor thread (highlighting [messageId] if present).
Future<void> _openActivityMessageThread(
  BuildContext context,
  WidgetRef ref,
  Map<String, dynamic> item,
) async {
  final cvId = _parseActivityInt(item['courseVersionId']);
  if (cvId == null || cvId <= 0) return;
  final courseId = _parseActivityInt(item['courseId']);
  final messageId = _parseActivityInt(item['messageId']);
  final courseTitle = item['courseTitle'] as String? ?? 'Course';

  if (courseId != null && courseId > 0) {
    final enrollments = await ref.read(enrollmentsProvider.future);
    Enrollment? match;
    for (final e in enrollments) {
      if (e.courseVersionId == cvId) {
        match = e;
        break;
      }
    }
    final user = ref.read(currentUserProvider).valueOrNull;
    if (!context.mounted) return;
    context.push('/employee/course/$courseId', extra: {
      'courseVersionId': cvId.toString(),
      if (match?.id != null) 'enrollmentId': match!.id!.toString(),
      if (match != null) 'enrollmentStatus': match.status,
      if (user?.id != null) 'userId': user!.id!.toString(),
      'courseTitle': courseTitle,
    });
    await Future<void>.delayed(Duration.zero);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        openLearnerInstructorChat(
          context,
          courseVersionId: cvId,
          courseTitle: courseTitle,
          focusMessageId: messageId,
        );
      }
    });
    return;
  }

  if (context.mounted) {
    await openLearnerInstructorChat(
      context,
      courseVersionId: cvId,
      courseTitle: courseTitle,
      focusMessageId: messageId,
    );
  }
}

class _RecentActivityCard extends ConsumerWidget {
  const _RecentActivityCard({required this.activities});

  final List<Map<String, dynamic>> activities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent activity', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.md),
          if (activities.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.lg),
              child: Column(
                children: [
                  Icon(Icons.history_rounded, size: 32, color: PharmaColors.textQuaternary),
                  const SizedBox(height: PharmaSpacing.sm),
                  Text(
                    'No recent activity yet. Events appear here after enrollments, assessments, '
                    'messages to your instructor, and recorded training actions. Run the demo seed '
                    'or complete a course to see history.',
                    textAlign: TextAlign.center,
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textQuaternary),
                  ),
                ],
              ),
            )
          else
            _LinkedScrollbarList(
              height: 280,
              itemCount: activities.length.clamp(0, 20),
              itemBuilder: (context, index) {
                    final item = activities[index];
                    final action = item['action'] as String? ?? '';
                    final entityType = item['entityType'] as String? ?? '';
                    final timestamp = item['timestamp'] as String? ?? '';
                    final courseTitle = item['courseTitle'] as String?;
                    final detail = item['detail'] as String?;
                    final (icon, color, bgColor, label) =
                        _getActivityStyle(action, entityType);
                    final headline = _activityHeadline(action, entityType, courseTitle, label);
                    final isMessageActivity = entityType == 'learner_trainer_message' &&
                        (action == 'LearnerMessageSent' ||
                            action == 'InstructorReplyReceived');

                    final row = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: bgColor, shape: BoxShape.circle),
                          child: Icon(icon, color: color, size: 18),
                        ),
                        const SizedBox(width: PharmaSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headline,
                                style: PharmaTypography.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (detail != null && detail.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  detail,
                                  style: PharmaTypography.caption
                                      .copyWith(color: PharmaColors.textSecondary),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              const SizedBox(height: 2),
                              Text(label, style: PharmaTypography.caption),
                            ],
                          ),
                        ),
                        Text(_formatTimestamp(timestamp),
                            style: PharmaTypography.caption),
                      ],
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
                      child: isMessageActivity
                          ? Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => _openActivityMessageThread(
                                  context,
                                  ref,
                                  item,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: PharmaSpacing.xs,
                                    horizontal: 2,
                                  ),
                                  child: row,
                                ),
                              ),
                            )
                          : row,
                    );
                  },
            ),
        ],
      ),
    );
  }

  String _activityHeadline(
    String action,
    String entityType,
    String? courseTitle,
    String fallback,
  ) {
    // Comprehensive mapping for all known and possible event types
    if (action == 'LearnerMessageSent' && courseTitle != null) {
      return 'Message sent: $courseTitle';
    }
    if (action == 'InstructorReplyReceived' && courseTitle != null) {
      return 'Instructor reply: $courseTitle';
    }
    if (action == 'TrainingCompleted' && courseTitle != null) {
      return 'Completed: $courseTitle';
    }
    if (action == 'EnrollmentStarted' && courseTitle != null) {
      return 'Started: $courseTitle';
    }
    if (action == 'EnrollmentCreated' && courseTitle != null) {
      return 'Enrolled: $courseTitle';
    }
    if (action == 'CertificateIssued' && courseTitle != null) {
      return 'Certificate earned: $courseTitle';
    }
    if (action == 'AssessmentCompleted' && courseTitle != null) {
      return 'Assessment completed: $courseTitle';
    }
    if (entityType == 'assessment_attempt' || action.toLowerCase().contains('assessment')) {
      return courseTitle != null ? 'Assessment: $courseTitle' : fallback;
    }
    if (entityType == 'certificate' && courseTitle != null) {
      return 'Certificate: $courseTitle';
    }
    if (entityType == 'learner_trainer_message' && courseTitle != null) {
      return 'Message: $courseTitle';
    }
    if (entityType == 'training_record' && courseTitle != null) {
      return 'Training record: $courseTitle';
    }
    if (entityType == 'enrollment' && courseTitle != null) {
      return 'Enrollment: $courseTitle';
    }
    if (entityType == 'User') {
      return 'User event';
    }
    if (entityType == 'Lesson' && courseTitle != null) {
      return 'Lesson: $courseTitle';
    }
    if (entityType == 'Assessment' && courseTitle != null) {
      return 'Assessment: $courseTitle';
    }
    if (courseTitle != null && courseTitle.isNotEmpty) return courseTitle;
    // Fallback for unknown types
    return fallback.isNotEmpty ? fallback : 'Activity';
  }

  (IconData, Color, Color, String) _getActivityStyle(String action, String entityType) {
    // Comprehensive mapping for all known and possible event types
    switch (action) {
      case 'LearnerMessageSent':
        return (
          Icons.send_rounded,
          PharmaColors.emerald600,
          PharmaColors.emerald50,
          'Message to instructor'
        );
      case 'InstructorReplyReceived':
        return (
          Icons.mark_chat_read_rounded,
          PharmaColors.info,
          PharmaColors.infoBg,
          'Reply from instructor'
        );
      case 'TrainingCompleted':
        return (Icons.check_circle_rounded, PharmaColors.success,
            PharmaColors.successBg, 'Course completed');
      case 'EnrollmentStarted':
        return (Icons.play_circle_rounded, PharmaColors.info,
            PharmaColors.infoBg, 'Started course');
      case 'EnrollmentCreated':
        return (Icons.add_circle_rounded, PharmaColors.emerald600,
            PharmaColors.emerald50, 'Enrolled in course');
      case 'CertificateIssued':
        return (Icons.workspace_premium_rounded, PharmaColors.warning,
            PharmaColors.warningBg, 'Certificate earned');
      case 'AssessmentCompleted':
        return (Icons.emoji_events_outlined, PharmaColors.warning,
            PharmaColors.warningBg, 'Assessment completed');
      // Add more known backend actions here as needed
      default:
        // Map by entityType for any new or custom backend event types
        switch (entityType) {
          case 'certificate':
            return (Icons.workspace_premium_rounded, PharmaColors.warning,
                PharmaColors.warningBg, 'Certificate');
          case 'assessment_attempt':
            return (Icons.quiz_rounded, PharmaColors.info, PharmaColors.infoBg,
                'Assessment activity');
          case 'learner_trainer_message':
            return (Icons.forum_outlined, PharmaColors.emerald600,
                PharmaColors.emerald50, 'Message');
          case 'training_record':
            return (Icons.history_rounded, PharmaColors.info, PharmaColors.infoBg,
                'Training record');
          case 'enrollment':
            return (Icons.school_rounded, PharmaColors.info, PharmaColors.infoBg,
                'Enrollment');
          case 'User':
            return (Icons.person_rounded, PharmaColors.info, PharmaColors.infoBg,
                'User event');
          case 'Lesson':
            return (Icons.menu_book_rounded, PharmaColors.info, PharmaColors.infoBg,
                'Lesson');
          case 'Assessment':
            return (Icons.quiz_rounded, PharmaColors.info, PharmaColors.infoBg,
                'Assessment');
          default:
            // Fallback for unknown types
            return (Icons.info_outlined, PharmaColors.textTertiary,
                PharmaColors.gray100, 'Activity');
        }
    }
  }

  String _formatTimestamp(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final date = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      return DateFormat.MMMd().format(date);
    } catch (_) {
      return '';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 5. COMPLIANCE ALERTS — PHARMA REGULATORY CRITICAL
// FR-07-01 AC-03: Expiring certificates (30/60/90)
// FR-07-01 AC-06: SOP retraining queue
// ═══════════════════════════════════════════════════════════════════════════════

class _ComplianceAlertsSection extends StatelessWidget {
  const _ComplianceAlertsSection({
    required this.alerts,
    required this.overdueCount,
  });

  final List<Map<String, dynamic>> alerts;
  final int overdueCount;

  @override
  Widget build(BuildContext context) {
    if (alerts.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(color: PharmaColors.dangerBg, shape: BoxShape.circle),
                  child: const Icon(Icons.warning_amber_rounded, color: PharmaColors.danger, size: 18),
                ),
                const SizedBox(width: PharmaSpacing.md),
                Text('Compliance Alerts', style: PharmaTypography.headingMedium),
                const SizedBox(width: PharmaSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: PharmaSpacing.xs),
                  decoration: BoxDecoration(color: PharmaColors.dangerBg, borderRadius: PharmaRadius.pillRadius),
                  child: Text('${alerts.length}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: PharmaColors.dangerText)),
                ),
              ],
            ),
            const SizedBox(height: PharmaSpacing.md),
            ...alerts.take(5).map((alert) => Padding(
              padding: const EdgeInsets.only(bottom: PharmaSpacing.sm),
              child: _AlertCard(alert: alert),
            )),
            if (alerts.length > 5) ...[
              const SizedBox(height: PharmaSpacing.sm),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/employee/lessons'),
                  child: Text('View all ${alerts.length} alerts →', style: PharmaTypography.body.copyWith(color: PharmaColors.emerald600, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ],
        ),
      );
    }

    if (overdueCount > 0) {
      return Container(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        decoration: BoxDecoration(
          color: PharmaColors.dangerBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.danger.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: PharmaColors.danger, borderRadius: BorderRadius.circular(PharmaRadius.lg)),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: PharmaSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Compliance Alert', style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.dangerText)),
                  const SizedBox(height: 2),
                  Text(
                    'You have $overdueCount overdue training${overdueCount > 1 ? "s" : ""} requiring immediate attention.',
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.dangerText.withValues(alpha: 0.8)),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.go('/employee/lessons'),
              style: TextButton.styleFrom(
                backgroundColor: PharmaColors.danger,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: PharmaSpacing.sm),
                shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
              ),
              child: const Text('View Now'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final Map<String, dynamic> alert;

  @override
  Widget build(BuildContext context) {
    final type = alert['type'] as String? ?? 'unknown';
    final severity = alert['severity'] as String? ?? 'medium';
    final title = alert['title'] as String? ?? 'Alert';
    final message = alert['message'] as String? ?? '';

    final (bgColor, borderColor, iconColor, icon) = switch (type) {
      'sop_retraining' => (PharmaColors.warningBg, PharmaColors.warning.withValues(alpha: 0.3), PharmaColors.warning, Icons.description_outlined),
      'overdue' => (PharmaColors.dangerBg, PharmaColors.danger.withValues(alpha: 0.3), PharmaColors.danger, Icons.schedule),
      'cert_expiring' => (PharmaColors.infoBg, PharmaColors.info.withValues(alpha: 0.3), PharmaColors.info, Icons.badge_outlined),
      _ => (PharmaColors.gray100, PharmaColors.border, PharmaColors.textSecondary, Icons.info_outline),
    };

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(title, style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600))),
                    if (severity == 'critical') ...[
                      const SizedBox(width: PharmaSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.xs, vertical: 2),
                        decoration: BoxDecoration(color: PharmaColors.danger, borderRadius: BorderRadius.circular(4)),
                        child: Text('CRITICAL', style: PharmaTypography.labelSmall.copyWith(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ],
                ),
                if (message.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(message, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ],
            ),
          ),
          const SizedBox(width: PharmaSpacing.sm),
          Icon(Icons.chevron_right, color: PharmaColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COMPLIANCE BANNER — FRD SCR-03 Zone 1 persistent alerts
// ═══════════════════════════════════════════════════════════════════════════════

class _ComplianceBanner extends StatelessWidget {
  const _ComplianceBanner({
    required this.color,
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onAction,
  });

  final Color color;
  final Color bgColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: PharmaSpacing.md),
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(PharmaRadius.lg)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: PharmaSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PharmaTypography.bodyMedium.copyWith(color: color, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: PharmaTypography.caption.copyWith(color: color.withValues(alpha: 0.8))),
              ],
            ),
          ),
          const SizedBox(width: PharmaSpacing.md),
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: PharmaSpacing.sm),
              shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED EMPTY STATE
// ═══════════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PharmaSpacing.xxl),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 32, color: PharmaColors.textQuaternary),
            const SizedBox(height: PharmaSpacing.sm),
            Text(message, style: PharmaTypography.caption.copyWith(color: PharmaColors.textQuaternary)),
          ],
        ),
      ),
    );
  }
}
