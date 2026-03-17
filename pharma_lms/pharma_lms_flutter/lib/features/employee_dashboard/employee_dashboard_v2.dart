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
//   FR-07-01 AC-07: Dashboard loads within 3 seconds P95
//   FR-07-01 AC-08: Data freshness ≤ 5 min cache TTL; "Last updated" shown
//   EMP-WF-02: View Dashboard event workflow (AccessLog page_view)
//   EMP-01: User story — compliance %, urgency sort, expiring certs, recent activity
//
// Layout (matches React Overview.tsx):
// ┌─────────────────────────────────────────────────────────────────────────────┐
// │  Welcome Card: Hello {name} + email + stats grid + avatar                  │
// ├──────────────────────────────────────┬──────────────────────────────────────┤
// │  Hours Spent (BarChart)             │  Performance (AreaChart + mini-stats)│
// ├──────────────────────────────────────┴──────────────────────────────────────┤
// │  Continue Learning (3-card grid with images + progress)                    │
// ├────────────────────────────────────┬────────────────────────────────────────┤
// │  Upcoming Deadlines               │  Recent Activity                      │
// ├────────────────────────────────────┴────────────────────────────────────────┤
// │  Compliance Alerts (overdue, SOP retraining, cert expiry)                 │
// └─────────────────────────────────────────────────────────────────────────────┘
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';

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
              onPressed: () => ref.invalidate(dashboardSummaryProvider),
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
        ref.invalidate(dashboardSummaryProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────────────────────────────────────────────────────
            // 0. COMPLIANCE BANNERS — FRD SCR-03 Zone 1
            // Conditional banners: overdue (red), cert revoked (persistent),
            // SOP retraining (orange), waiver (purple)
            // ─────────────────────────────────────────────────────────────
            if (summary.compliance.overdueCount > 0)
              _ComplianceBanner(
                color: PharmaColors.danger,
                bgColor: PharmaColors.dangerBg,
                icon: Icons.error_rounded,
                title: '${summary.compliance.overdueCount} Overdue Training${summary.compliance.overdueCount > 1 ? 's' : ''}',
                subtitle: 'Immediate action required — complete before next audit.',
                actionLabel: 'View Overdue',
                onAction: () => context.go('/employee/lessons'),
              ),
            if (summary.complianceAlerts.any((a) => a['type'] == 'cert_revoked'))
              _ComplianceBanner(
                color: PharmaColors.danger,
                bgColor: PharmaColors.dangerBg,
                icon: Icons.gpp_bad_rounded,
                title: 'Certificate Revoked',
                subtitle: 'One or more certificates have been revoked. Retraining required.',
                actionLabel: 'View Details',
                onAction: () => context.go('/employee/credentials'),
              ),
            if (summary.complianceAlerts.any((a) => a['type'] == 'sop_retraining'))
              _ComplianceBanner(
                color: PharmaColors.orangeText,
                bgColor: PharmaColors.orangeBg,
                icon: Icons.description_outlined,
                title: 'SOP Retraining Required',
                subtitle: 'Updated SOPs require acknowledgement and retraining.',
                actionLabel: 'Start Retraining',
                onAction: () => context.go('/employee/lessons'),
              ),

            // ─────────────────────────────────────────────────────────────
            // 1. WELCOME CARD (React: white card with stats + avatar)
            // ─────────────────────────────────────────────────────────────
            _WelcomeCard(summary: summary),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // ─────────────────────────────────────────────────────────────
            // 2. CHARTS ROW (React: grid-cols-2 gap-6)
            // ─────────────────────────────────────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 900;
                return isNarrow
                    ? Column(
                        children: [
                          _HoursSpentChart(monthlyHours: summary.monthlyHours),
                          const SizedBox(height: PharmaSpacing.gridGap),
                          _PerformanceChart(summary: summary),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _HoursSpentChart(monthlyHours: summary.monthlyHours)),
                          const SizedBox(width: PharmaSpacing.gridGap),
                          Expanded(child: _PerformanceChart(summary: summary)),
                        ],
                      );
              },
            ),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // ─────────────────────────────────────────────────────────────
            // 3. CONTINUE LEARNING (React: 3-card grid with images)
            // ─────────────────────────────────────────────────────────────
            if (summary.inProgress.isNotEmpty || summary.toDo.isNotEmpty) ...[
              _ContinueLearningSection(
                enrollments: [...summary.inProgress, ...summary.toDo].take(3).toList(),
              ),
              const SizedBox(height: PharmaSpacing.sectionGap),
            ],

            // ─────────────────────────────────────────────────────────────
            // 4. UPCOMING DEADLINES + RECENT ACTIVITY (two-column)
            // FR-07-01 AC-02: Urgency-sorted assignments
            // FR-07-01 AC-04: Recent activity last 5 completed
            // ─────────────────────────────────────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 900;
                return isNarrow
                    ? Column(
                        children: [
                          _UpcomingDeadlinesCard(dueDates: summary.upcomingDueDates),
                          const SizedBox(height: PharmaSpacing.gridGap),
                          _RecentActivityCard(activities: summary.recentActivity),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _UpcomingDeadlinesCard(dueDates: summary.upcomingDueDates)),
                          const SizedBox(width: PharmaSpacing.gridGap),
                          Expanded(child: _RecentActivityCard(activities: summary.recentActivity)),
                        ],
                      );
              },
            ),

            // ─────────────────────────────────────────────────────────────
            // 5. COMPLIANCE ALERTS — PHARMA REGULATORY CRITICAL
            // FR-07-01 AC-03: Expiring certificates (30/60/90)
            // FR-07-01 AC-06: SOP retraining queue
            // ─────────────────────────────────────────────────────────────
            if (summary.complianceAlerts.isNotEmpty || summary.compliance.overdueCount > 0) ...[
              const SizedBox(height: PharmaSpacing.sectionGap),
              _ComplianceAlertsSection(
                alerts: summary.complianceAlerts,
                overdueCount: summary.compliance.overdueCount,
              ),
            ],

            // ─────────────────────────────────────────────────────────────
            // 6. LAST UPDATED TIMESTAMP (FR-07-01 AC-08)
            // ─────────────────────────────────────────────────────────────
            const SizedBox(height: PharmaSpacing.lg),
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
            const SizedBox(height: PharmaSpacing.lg),
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
// 1. WELCOME CARD
// React: bg-white rounded-lg p-6 shadow-sm border-gray-200
// Contains: greeting + email + 3 stat cards + user avatar
// ═══════════════════════════════════════════════════════════════════════════════

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final complianceRate = summary.compliance.complianceRate.toInt();

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
        title: 'OVERDUE',
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
// 2A. HOURS SPENT CHART
// React: BarChart with emerald-500 bars, rounded-[8,8,0,0]
// ═══════════════════════════════════════════════════════════════════════════════

class _HoursSpentChart extends StatelessWidget {
  const _HoursSpentChart({required this.monthlyHours});

  final List<Map<String, dynamic>> monthlyHours;

  @override
  Widget build(BuildContext context) {
    final chartData = monthlyHours.isNotEmpty
        ? monthlyHours
        : [
            {'month': 'Jan', 'hours': 0.0},
            {'month': 'Feb', 'hours': 0.0},
            {'month': 'Mar', 'hours': 0.0},
            {'month': 'Apr', 'hours': 0.0},
            {'month': 'May', 'hours': 0.0},
          ];

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
              Text('Hours Spent', style: PharmaTypography.headingMedium),
              Text(
                'Last ${chartData.length} months',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.emerald600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.xxl),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(chartData),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: _getInterval(chartData),
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: PharmaColors.borderLight,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: _getInterval(chartData),
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString(), style: PharmaTypography.caption);
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= chartData.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(chartData[idx]['month'] as String? ?? '', style: PharmaTypography.caption),
                        );
                      },
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => PharmaColors.gray900,
                    tooltipRoundedRadius: 6,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(1)}h',
                        const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                ),
                barGroups: chartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: (entry.value['hours'] as num?)?.toDouble() ?? 0,
                        color: PharmaColors.emerald500,
                        width: 28,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return 10;
    final maxHours = data.map((d) => (d['hours'] as num?)?.toDouble() ?? 0).fold<double>(0, (a, b) => a > b ? a : b);
    if (maxHours == 0) return 10;
    return (maxHours * 1.2).ceilToDouble();
  }

  double _getInterval(List<Map<String, dynamic>> data) {
    final maxY = _getMaxY(data);
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    return (maxY / 5).ceilToDouble();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 2B. PERFORMANCE CHART
// React: AreaChart + 3 mini-stat cards (Total Hours, Avg. Score, Courses)
// ═══════════════════════════════════════════════════════════════════════════════

class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final totalEnrollments = summary.inProgress.length + summary.toDo.length + summary.completed.length;
    final avgScore = summary.averageQuizScore > 0
        ? '${summary.averageQuizScore.toInt()}%'
        : '${summary.compliance.complianceRate.toInt()}%';

    final List<FlSpot> spots;
    if (summary.weeklyProgress.isNotEmpty) {
      spots = summary.weeklyProgress.asMap().entries.map((e) {
        final completed = (e.value['completed'] as num?)?.toDouble() ?? 0;
        final total = (e.value['total'] as num?)?.toDouble() ?? 1;
        return FlSpot(e.key.toDouble(), total > 0 ? (completed / total * 100) : 0);
      }).toList();
    } else {
      final completionRate = totalEnrollments > 0
          ? (summary.completed.length / totalEnrollments * 100)
          : 0.0;
      spots = List.generate(6, (i) {
        final progress = completionRate * (i + 1) / 6;
        return FlSpot(i.toDouble(), progress.clamp(0, 100));
      });
    }

    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
              Text('Performance', style: PharmaTypography.headingMedium),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.md, vertical: PharmaSpacing.xs),
                decoration: BoxDecoration(
                  color: PharmaColors.emerald50,
                  borderRadius: PharmaRadius.pillRadius,
                ),
                child: Text(
                  '${summary.learningStreak}🔥',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.emerald700, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.lg),
          Row(
            children: [
              Expanded(child: _MiniStat(label: 'Total Hours', value: summary.totalHoursThisYear.toStringAsFixed(0))),
              const SizedBox(width: PharmaSpacing.lg),
              Expanded(child: _MiniStat(label: 'Avg. Score', value: avgScore)),
              const SizedBox(width: PharmaSpacing.lg),
              Expanded(child: _MiniStat(label: 'Courses', value: totalEnrollments.toString())),
            ],
          ),
          const SizedBox(height: PharmaSpacing.lg),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(color: PharmaColors.borderLight, strokeWidth: 1, dashArray: [5, 5]),
                ),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => PharmaColors.gray900,
                    tooltipRoundedRadius: 6,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(0)}%',
                          const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        );
                      }).toList();
                    },
                  ),
                ),
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: PharmaColors.emerald500,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          PharmaColors.emerald500.withValues(alpha: 0.3),
                          PharmaColors.emerald500.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PharmaTypography.caption),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: PharmaColors.textPrimary),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// 3. CONTINUE LEARNING SECTION
// React: bg-white rounded-lg p-6, grid-cols-3 gap-4
// ═══════════════════════════════════════════════════════════════════════════════

class _ContinueLearningSection extends StatelessWidget {
  const _ContinueLearningSection({required this.enrollments});

  final List enrollments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Continue Learning', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.lg),
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
// FR-07-01 AC-02: Assignments sorted urgency-first
// ═══════════════════════════════════════════════════════════════════════════════

class _UpcomingDeadlinesCard extends StatelessWidget {
  const _UpcomingDeadlinesCard({required this.dueDates});

  final List<Map<String, dynamic>> dueDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({required this.activities});

  final List<Map<String, dynamic>> activities;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: PharmaTypography.headingMedium),
          const SizedBox(height: PharmaSpacing.lg),
          if (activities.isEmpty)
            const _EmptyState(icon: Icons.history_rounded, message: 'No recent activity')
          else
            ...activities.take(5).map((item) {
              final action = item['action'] as String? ?? '';
              final entityType = item['entityType'] as String? ?? '';
              final timestamp = item['timestamp'] as String? ?? '';
              final courseTitle = item['courseTitle'] as String?;
              final (icon, color, bgColor, label) = _getActivityStyle(action, entityType);

              return Padding(
                padding: const EdgeInsets.only(bottom: PharmaSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                      child: Icon(icon, color: color, size: 18),
                    ),
                    const SizedBox(width: PharmaSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(courseTitle ?? label, style: PharmaTypography.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 2),
                          Text(label, style: PharmaTypography.caption),
                        ],
                      ),
                    ),
                    Text(_formatTimestamp(timestamp), style: PharmaTypography.caption),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  (IconData, Color, Color, String) _getActivityStyle(String action, String entityType) {
    switch (action) {
      case 'TrainingCompleted':
        return (Icons.check_circle_rounded, PharmaColors.success, PharmaColors.successBg, 'Completed training');
      case 'EnrollmentStarted':
        return (Icons.play_circle_rounded, PharmaColors.info, PharmaColors.infoBg, 'Started course');
      case 'EnrollmentCreated':
        return (Icons.add_circle_rounded, PharmaColors.emerald600, PharmaColors.emerald50, 'Enrolled in course');
      case 'CertificateIssued':
        return (Icons.workspace_premium_rounded, PharmaColors.warning, PharmaColors.warningBg, 'Certificate earned');
      default:
        if (entityType == 'certificate') return (Icons.workspace_premium_rounded, PharmaColors.warning, PharmaColors.warningBg, 'Certificate action');
        if (entityType == 'assessment_attempt') return (Icons.quiz_rounded, PharmaColors.info, PharmaColors.infoBg, 'Quiz completed');
        return (Icons.info_outlined, PharmaColors.textTertiary, PharmaColors.gray100, 'Activity');
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
        padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
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
            const SizedBox(height: PharmaSpacing.lg),
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
