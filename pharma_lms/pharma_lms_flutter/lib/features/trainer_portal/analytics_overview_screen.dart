import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class AnalyticsOverviewScreen extends ConsumerStatefulWidget {
  const AnalyticsOverviewScreen({super.key});

  @override
  ConsumerState<AnalyticsOverviewScreen> createState() =>
      _AnalyticsOverviewScreenState();
}

class _AnalyticsOverviewScreenState
    extends ConsumerState<AnalyticsOverviewScreen> {
  bool _loading = true;
  String? _error;

  Map<String, double> _deptCompletion = {};
  AuditReadinessScore? _auditReadiness;
  int _certExpiryRisk = 0;
  double _sopRetrainingVelocity = 0.0;
  List<DepartmentComplianceSummary> _deptSummaries = [];
  List<ComplianceTrendPoint> _complianceTrend = [];

  int _totalEnrollments = 0;
  int _completedEnrollments = 0;
  int _inProgressEnrollments = 0;
  int _overdueEnrollments = 0;
  int _totalCourses = 0;
  List<Course> _orgCourses = [];
  int? _selectedCourseIdForAnalytics;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final user = ref.read(currentUserProvider).value;
      final orgId = user?.organizationId;

      final results = await Future.wait([
        client.analytics.getTrainingCompletionRate(organizationId: orgId),
        client.analytics.getAuditReadinessScore(organizationId: orgId),
        client.analytics.getCertificationExpiryRiskCount(organizationId: orgId),
        client.analytics.getSopRetrainingVelocity(),
        client.analytics.getDepartmentComplianceSummary(),
        client.analytics.getComplianceTrend(months: 6),
        client.course.listCourses(organizationId: orgId),
      ]);

      final deptCompletion = results[0] as Map<String, double>;
      final auditReadiness = results[1] as AuditReadinessScore;
      final certRisk = results[2] as int;
      final sopVelocity = results[3] as double;
      final deptSummaries = results[4] as List<DepartmentComplianceSummary>;
      final complianceTrend = results[5] as List<ComplianceTrendPoint>;
      final courses = results[6] as List<Course>;

      int totalE = 0, completedE = 0, inProgressE = 0, overdueE = 0;

      if (courses.isNotEmpty) {
        for (final course in courses) {
          if (course.id == null) continue;
          try {
            final versions = await client.course.getCourseVersions(course.id!);
            for (final v in versions) {
              if (v.id == null) continue;
              final enrollments =
                  await client.training.getEnrollmentsForCourseVersion(v.id!);
              totalE += enrollments.length;
              for (final e in enrollments) {
                if (e.status == 'completed') {
                  completedE++;
                } else if (e.status == 'in_progress') {
                  inProgressE++;
                } else if (e.status == 'overdue') {
                  overdueE++;
                }
              }
            }
          } catch (_) {}
        }
      }

      setState(() {
        _deptCompletion = deptCompletion;
        _auditReadiness = auditReadiness;
        _certExpiryRisk = certRisk;
        _sopRetrainingVelocity = sopVelocity;
        _deptSummaries = deptSummaries;
        _complianceTrend = complianceTrend;
        _totalCourses = courses.length;
        _totalEnrollments = totalE;
        _completedEnrollments = completedE;
        _inProgressEnrollments = inProgressE;
        _overdueEnrollments = overdueE;
        _orgCourses = courses;
        if (_selectedCourseIdForAnalytics == null) {
          for (final c in courses) {
            if (c.id != null) {
              _selectedCourseIdForAnalytics = c.id;
              break;
            }
          }
        }
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load analytics: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: PharmaColors.danger),
                      const SizedBox(height: 12),
                      Text(_error!, style: PharmaTypography.body),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding:
                      const EdgeInsets.all(PharmaSpacing.pagePadding),
                  children: [
                    _buildHeader(),
                    const SizedBox(height: PharmaSpacing.sectionGap),
                    _buildAnalyticsScopesSection(context),
                    const SizedBox(height: PharmaSpacing.sectionGap),
                    _buildKpiCards(),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              _buildDeptCompletionChart(),
                              const SizedBox(height: 20),
                              _buildComplianceTrendChart(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 320,
                          child: Column(
                            children: [
                              _buildAuditReadinessCard(),
                              const SizedBox(height: 20),
                              _buildRiskIndicators(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.analytics_outlined,
            color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analytics Overview',
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Organization-wide metrics below. Use the cards to open course, batch, or learner-level analytics.',
                style: PharmaTypography.body
                    .copyWith(color: PharmaColors.textTertiary),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _loadData,
          icon: const Icon(Icons.refresh, size: 20),
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  /// Links to course-, batch-, and individual-level analytics (trainer portal).
  Widget _buildAnalyticsScopesSection(BuildContext context) {
    final withId = _orgCourses.where((c) => c.id != null).toList();

    Widget scopeCard({
      required IconData icon,
      required Color iconColor,
      required String title,
      required String subtitle,
      required Widget child,
    }) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
          boxShadow: PharmaShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textTertiary,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics by scope',
          style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 4),
        Text(
          'This page shows organization-wide KPIs. Drill down using the options below.',
          style: PharmaTypography.caption.copyWith(
            color: PharmaColors.textTertiary,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 900;
            final cards = [
              scopeCard(
                icon: Icons.school_outlined,
                iconColor: PharmaColors.emerald600,
                title: 'Course analytics',
                subtitle: 'Pass rates, enrollments, and trends for one course.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (withId.isEmpty)
                      Text(
                        'No courses in organization.',
                        style: PharmaTypography.caption,
                      )
                    else
                      InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: PharmaColors.pageBg,
                          border: OutlineInputBorder(
                            borderRadius: PharmaRadius.inputRadius,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                        ),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          value: () {
                            final id = _selectedCourseIdForAnalytics;
                            if (id != null &&
                                withId.any((x) => x.id == id)) {
                              return id;
                            }
                            return withId.first.id;
                          }(),
                          items: withId
                              .map(
                                (co) => DropdownMenuItem(
                                  value: co.id,
                                  child: Text(
                                    co.title,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedCourseIdForAnalytics = v),
                        ),
                      ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: _selectedCourseIdForAnalytics == null
                          ? null
                          : () => context.push(
                                '/trainer/courses/${_selectedCourseIdForAnalytics!}/analytics',
                              ),
                      icon: const Icon(Icons.analytics_outlined, size: 18),
                      label: const Text('Open course analytics'),
                      style: FilledButton.styleFrom(
                        backgroundColor: PharmaColors.emerald600,
                        foregroundColor: PharmaColors.cardBg,
                      ),
                    ),
                  ],
                ),
              ),
              scopeCard(
                icon: Icons.groups_outlined,
                iconColor: PharmaColors.info,
                title: 'Batch analytics',
                subtitle: 'ILT cohorts, attendance, and batch-level training.',
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/trainer/batches'),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Open batches'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.info,
                    side: const BorderSide(color: PharmaColors.info),
                  ),
                ),
              ),
              scopeCard(
                icon: Icons.person_search_outlined,
                iconColor: PharmaColors.warningText,
                title: 'Individual analytics',
                subtitle: 'Per-learner enrollments, progress, and certificates.',
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/trainer/reports/learner-progress'),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Learner progress report'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.warningText,
                    side: BorderSide(color: PharmaColors.warningText.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ];
            if (narrow) {
              return Column(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    cards[i],
                  ],
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < cards.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  Expanded(child: cards[i]),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildKpiCards() {
    final completionRate = _totalEnrollments > 0
        ? (_completedEnrollments / _totalEnrollments * 100)
        : 0.0;

    return Row(
      children: [
        _kpiCard(
          'Total Courses',
          '$_totalCourses',
          Icons.school,
          PharmaColors.emerald600,
          'active in organization',
        ),
        _kpiCard(
          'Total Enrollments',
          '$_totalEnrollments',
          Icons.people,
          PharmaColors.info,
          '$_completedEnrollments completed',
        ),
        _kpiCard(
          'Completion Rate',
          '${completionRate.toStringAsFixed(1)}%',
          Icons.check_circle,
          PharmaColors.success,
          '$_inProgressEnrollments in progress',
        ),
        _kpiCard(
          'Overdue',
          '$_overdueEnrollments',
          Icons.warning_amber,
          _overdueEnrollments > 0 ? PharmaColors.danger : PharmaColors.success,
          _overdueEnrollments > 0 ? 'require attention' : 'all on track',
        ),
        _kpiCard(
          'Cert Expiry Risk',
          '$_certExpiryRisk',
          Icons.shield,
          _certExpiryRisk > 0 ? PharmaColors.warningText : PharmaColors.success,
          'expiring within 30 days',
        ),
      ]
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _kpiCard(
      String label, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(icon, size: 18, color: color),
              const Spacer(),
              Text(value,
                  style: PharmaTypography.statNumber.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(subtitle,
              style: TextStyle(fontSize: 10, color: color),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildDeptCompletionChart() {
    if (_deptCompletion.isEmpty) {
      return _emptyCard(
        'Department Completion Rates',
        'No department data available yet.',
        Icons.bar_chart,
      );
    }

    final entries = _deptCompletion.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Department Training Completion',
              style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
          const SizedBox(height: 4),
          Text('Completion rate by department',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          const SizedBox(height: 20),
          ...entries.map((entry) {
            final pct = entry.value.clamp(0.0, 100.0);
            final barColor = pct >= 80
                ? PharmaColors.emerald600
                : pct >= 60
                    ? PharmaColors.warningText
                    : PharmaColors.danger;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: PharmaTypography.caption
                              .copyWith(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${pct.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: barColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: PharmaColors.gray100,
                      color: barColor,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildComplianceTrendChart() {
    if (_complianceTrend.isEmpty) {
      return _emptyCard(
        'Compliance Trend',
        'No trend data available.',
        Icons.timeline,
      );
    }

    final maxRate = _complianceTrend.fold<double>(
      1.0,
      (prev, item) => prev > item.complianceRatePercent
          ? prev
          : item.complianceRatePercent,
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Trend (6 Months)',
              style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
          const SizedBox(height: 4),
          Text(
              'From compliance snapshots when available; otherwise current department average.',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _complianceTrend.map((item) {
                final rate = item.complianceRatePercent;
                final frac = maxRate > 0 ? rate / maxRate : 0.0;
                final month = item.monthLabel;
                final parts = month.split('-');
                const monthNames = [
                  '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
                ];
                final label = parts.length == 2
                    ? monthNames[int.tryParse(parts[1]) ?? 0]
                    : month;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${rate.toStringAsFixed(0)}%',
                          style: const TextStyle(
                              fontSize: 10, color: PharmaColors.textTertiary),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 120 * frac,
                          decoration: BoxDecoration(
                            color: PharmaColors.emerald600,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(label,
                            style: const TextStyle(
                                fontSize: 10,
                                color: PharmaColors.textTertiary)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditReadinessCard() {
    final score = _auditReadiness?.overallScore ?? 0.0;
    final displayPct = score > 1 ? score.clamp(0.0, 100.0) : score * 100;
    final progressVal = score > 1 ? score / 100 : score;
    final complianceScore = _auditReadiness?.complianceScore ?? 0.0;
    final displayCompliance = complianceScore > 1
        ? complianceScore.clamp(0.0, 100.0)
        : complianceScore * 100;
    final auditActive = _auditReadiness?.auditTrailActive ?? false;
    final depts = _auditReadiness?.departmentCount ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        children: [
          Text('Audit Readiness',
              style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 16),
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: progressVal.clamp(0.0, 1.0),
                    strokeWidth: 8,
                    backgroundColor: PharmaColors.gray100,
                    color: displayPct >= 80
                        ? PharmaColors.emerald600
                        : displayPct >= 50
                            ? PharmaColors.warningText
                            : PharmaColors.danger,
                  ),
                ),
                Text(
                  '${displayPct.toStringAsFixed(0)}%',
                  style: PharmaTypography.statNumber.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _readinessRow('Compliance Score', '${displayCompliance.toStringAsFixed(0)}%'),
          _readinessRow('Audit Trail', auditActive ? 'Active' : 'Inactive'),
          _readinessRow('Departments', '$depts'),
        ],
      ),
    );
  }

  Widget _readinessRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          Text(value,
              style: PharmaTypography.caption
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRiskIndicators() {
    final velocityPct = _sopRetrainingVelocity > 1
        ? _sopRetrainingVelocity.clamp(0.0, 100.0)
        : _sopRetrainingVelocity * 100;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Risk Indicators',
              style: PharmaTypography.headingSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 16),
          _riskRow(
            'Cert Expiry Risk',
            '$_certExpiryRisk',
            _certExpiryRisk > 5
                ? PharmaColors.danger
                : _certExpiryRisk > 0
                    ? PharmaColors.warningText
                    : PharmaColors.success,
          ),
          _riskRow(
            'SOP Retraining',
            '${velocityPct.toStringAsFixed(0)}% complete',
            velocityPct >= 80
                ? PharmaColors.success
                : velocityPct >= 50
                    ? PharmaColors.warningText
                    : PharmaColors.danger,
          ),
          _riskRow(
            'Overdue Training',
            '$_overdueEnrollments',
            _overdueEnrollments > 10
                ? PharmaColors.danger
                : _overdueEnrollments > 0
                    ? PharmaColors.warningText
                    : PharmaColors.success,
          ),
          if (_deptSummaries.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Lowest Dept Compliance',
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary)),
            const SizedBox(height: 6),
            ..._buildLowestDepts(),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildLowestDepts() {
    final sorted = List<DepartmentComplianceSummary>.from(_deptSummaries)
      ..sort((a, b) => a.complianceRate.compareTo(b.complianceRate));
    final lowest = sorted.take(3);
    return lowest.map((d) {
      final pct = d.complianceRate.clamp(0.0, 100.0);
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pct >= 80
                    ? PharmaColors.success
                    : pct >= 50
                        ? PharmaColors.warningText
                        : PharmaColors.danger,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                d.departmentName ?? 'Dept #${d.departmentId}',
                style: PharmaTypography.caption,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${pct.toStringAsFixed(0)}%',
              style: PharmaTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _riskRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: PharmaTypography.caption),
          ),
          Text(
            value,
            style: PharmaTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyCard(String title, String message, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: PharmaColors.gray300),
          const SizedBox(height: 12),
          Text(title,
              style: PharmaTypography.headingSmall.copyWith(fontSize: 15)),
          const SizedBox(height: 4),
          Text(message,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
        ],
      ),
    );
  }
}
