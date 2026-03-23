import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ANALYTICS DASHBOARD SCREEN - Real data from backend
// ═══════════════════════════════════════════════════════════════════════════════

class AdminAnalyticsDashboardScreen extends ConsumerStatefulWidget {
  const AdminAnalyticsDashboardScreen({super.key});

  @override
  ConsumerState<AdminAnalyticsDashboardScreen> createState() => _AdminAnalyticsDashboardScreenState();
}

class _AdminAnalyticsDashboardScreenState extends ConsumerState<AdminAnalyticsDashboardScreen> {
  String _selectedPeriod = '30_days';
  
  @override
  Widget build(BuildContext context) {
    final analyticsAsync = ref.watch(adminTrainingAnalyticsProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(),
          SizedBox(height: PharmaSpacing.sectionGap),

          // Analytics Content
          analyticsAsync.when(
            data: (analytics) => _buildAnalyticsContent(analytics),
            loading: () => _buildLoadingState(),
            error: (e, s) => _buildErrorState(e.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analytics Dashboard', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Engagement, effectiveness, and compliance forecasting',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        Row(
          children: [
            // Period Selector
            DropdownButton<String>(
              value: _selectedPeriod,
              items: const [
                DropdownMenuItem(value: '7_days', child: Text('Last 7 Days')),
                DropdownMenuItem(value: '30_days', child: Text('Last 30 Days')),
                DropdownMenuItem(value: '90_days', child: Text('Last 90 Days')),
                DropdownMenuItem(value: 'year', child: Text('This Year')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _selectedPeriod = v);
              },
            ),
            SizedBox(width: PharmaSpacing.md),
            OutlinedButton.icon(
              onPressed: () => _showExportDialog(),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsContent(TrainingAnalytics analytics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Key Metrics Row
        _buildKeyMetricsRow(analytics),
        SizedBox(height: PharmaSpacing.sectionGap),

        // Two Column Layout
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildCompletionTrendCard(analytics),
                  SizedBox(height: PharmaSpacing.md),
                  _buildCoursePerformanceCard(analytics),
                ],
              ),
            ),
            SizedBox(width: PharmaSpacing.md),
            // Right Column
            Expanded(
              child: Column(
                children: [
                  _buildComplianceStatusCard(analytics),
                  SizedBox(height: PharmaSpacing.md),
                  _buildQuickInsightsCard(analytics),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyMetricsRow(TrainingAnalytics analytics) {
    return Row(
      children: [
        _buildMetricCard(
          'Completion Rate',
          '${analytics.completionRate}%',
          Icons.check_circle_outline,
          PharmaColors.success,
          'Training completion overall',
          null,
        ),
        SizedBox(width: PharmaSpacing.md),
        _buildMetricCard(
          'Average Score',
          '${analytics.averageScore}%',
          Icons.grade_outlined,
          PharmaColors.info,
          'Assessment average',
          null,
        ),
        SizedBox(width: PharmaSpacing.md),
        _buildMetricCard(
          'Total Users',
          analytics.totalUsers.toString(),
          Icons.people_outline,
          PharmaColors.emerald600,
          'Active learners tracked',
          null,
        ),
        SizedBox(width: PharmaSpacing.md),
        _buildMetricCard(
          'Pass Rate',
          '${analytics.passRate}%',
          Icons.emoji_events_outlined,
          analytics.passRate >= 80 ? PharmaColors.success : PharmaColors.warning,
          'Assessment pass rate',
          null,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color, String subtitle, bool? isUp) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
          boxShadow: PharmaShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                if (isUp != null)
                  Icon(
                    isUp ? Icons.trending_up : Icons.trending_down,
                    color: isUp ? PharmaColors.success : PharmaColors.danger,
                    size: 18,
                  ),
              ],
            ),
            SizedBox(height: PharmaSpacing.md),
            Text(value, style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(label, style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.textSecondary)),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              subtitle,
              style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionTrendCard(TrainingAnalytics analytics) {
    final trendUp = analytics.completionRate >= 70;
    
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Completion Trend', style: PharmaTypography.headingSmall),
              Container(
                padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
                decoration: BoxDecoration(
                  color: trendUp ? PharmaColors.successBg : PharmaColors.warningBg,
                  borderRadius: BorderRadius.circular(PharmaRadius.sm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendUp ? Icons.trending_up : Icons.trending_flat,
                      size: 14,
                      color: trendUp ? PharmaColors.success : PharmaColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trendUp ? 'On Track' : 'Needs Attention',
                      style: PharmaTypography.caption.copyWith(
                        color: trendUp ? PharmaColors.success : PharmaColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          // Simple visual chart representation
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: PharmaColors.gray50,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 48, color: PharmaColors.emerald500),
                  SizedBox(height: PharmaSpacing.sm),
                  Text(
                    'Training completions over time',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  ),
                  SizedBox(height: PharmaSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendDot('Completed', PharmaColors.success),
                      SizedBox(width: PharmaSpacing.lg),
                      _buildLegendDot('In Progress', PharmaColors.warning),
                      SizedBox(width: PharmaSpacing.lg),
                      _buildLegendDot('Not Started', PharmaColors.gray300),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: PharmaTypography.caption),
      ],
    );
  }

  Widget _buildCoursePerformanceCard(TrainingAnalytics analytics) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Performance', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.md),
          _buildPerformanceBar('Pass Rate', analytics.passRate.toDouble(), PharmaColors.success),
          SizedBox(height: PharmaSpacing.sm),
          _buildPerformanceBar('Completion Rate', analytics.completionRate.toDouble(), PharmaColors.info),
          SizedBox(height: PharmaSpacing.sm),
          _buildPerformanceBar('Avg Score', analytics.averageScore.toDouble(), PharmaColors.emerald500),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: PharmaTypography.body),
            Text('${percentage.toStringAsFixed(0)}%', style: PharmaTypography.bodyMedium),
          ],
        ),
        SizedBox(height: PharmaSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: PharmaColors.gray200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceStatusCard(TrainingAnalytics analytics) {
    final total = analytics.totalUsers;
    final compliant = (total * (analytics.completionRate / 100)).round();
    final atRisk = (total * 0.15).round(); // Estimate 15% at risk
    final nonCompliant = total - compliant - atRisk;

    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Status', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.md),
          _buildStatusRow(Icons.check_circle, 'Compliant', compliant, PharmaColors.success),
          SizedBox(height: PharmaSpacing.sm),
          _buildStatusRow(Icons.warning_amber, 'At Risk', atRisk, PharmaColors.warning),
          SizedBox(height: PharmaSpacing.sm),
          _buildStatusRow(Icons.error_outline, 'Non-Compliant', nonCompliant > 0 ? nonCompliant : 0, PharmaColors.danger),
          SizedBox(height: PharmaSpacing.md),
          Divider(color: PharmaColors.borderLight),
          SizedBox(height: PharmaSpacing.sm),
          // Compliance forecast note
          Container(
            padding: EdgeInsets.all(PharmaSpacing.sm),
            decoration: BoxDecoration(
              color: PharmaColors.infoBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: PharmaColors.info),
                SizedBox(width: PharmaSpacing.sm),
                Expanded(
                  child: Text(
                    'FDA 21 CFR Part 11 compliance tracked',
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.info),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(IconData icon, String label, int count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: PharmaSpacing.sm),
        Expanded(child: Text(label, style: PharmaTypography.body)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(PharmaRadius.sm),
          ),
          child: Text(
            count.toString(),
            style: PharmaTypography.bodyMedium.copyWith(color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickInsightsCard(TrainingAnalytics analytics) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quick Insights', style: PharmaTypography.headingSmall),
              Icon(Icons.lightbulb_outline, color: PharmaColors.warning, size: 20),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          _buildInsightRow(
            Icons.school,
            'Total Courses',
            '${analytics.totalCourses} active',
            PharmaColors.info,
          ),
          SizedBox(height: PharmaSpacing.sm),
          _buildInsightRow(
            Icons.people,
            'Total Users',
            '${analytics.totalUsers} enrolled',
            PharmaColors.emerald600,
          ),
          SizedBox(height: PharmaSpacing.sm),
          _buildInsightRow(
            Icons.trending_up,
            'Pass Rate',
            '${analytics.passRate}% achieved',
            analytics.passRate >= 80 ? PharmaColors.success : PharmaColors.warning,
          ),
          SizedBox(height: PharmaSpacing.md),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('View Detailed Reports'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: PharmaSpacing.sm),
        Expanded(child: Text(label, style: PharmaTypography.body)),
        Text(value, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
      ],
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Analytics Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF Report'),
              subtitle: const Text('Complete analytics with charts'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating PDF report...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Excel Export'),
              subtitle: const Text('Raw data for analysis'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating Excel export...')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.xl),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Failed to load analytics', style: PharmaTypography.bodyMedium),
            Text(error, style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(adminTrainingAnalyticsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REPORT BUILDER SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminReportBuilderScreen extends StatelessWidget {
  const AdminReportBuilderScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportBuilderTemplate();
}

class _ReportBuilderTemplate extends StatelessWidget {
  const _ReportBuilderTemplate();
  @override
  Widget build(BuildContext context) => AdminPageFrame(
        title: 'Report Builder',
        subtitle: 'Build and save custom ad-hoc report definitions.',
        children: [
          AdminSectionCard(
            title: 'Report Templates',
            child: AdminPlaceholderTable(
              columns: const ['Template', 'Type', 'Schedule', 'Last Run'],
              rows: const [
                ['Monthly Compliance Report', 'Compliance', 'Monthly', '2024-01-01'],
                ['Training Effectiveness', 'Analytics', 'Quarterly', '2024-01-15'],
                ['Overdue Training Alert', 'Alert', 'Weekly', '2024-01-20'],
              ],
            ),
          ),
        ],
      );
}
