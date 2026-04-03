// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE ANALYTICS V2 (TRN-08)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/analytics
// Stats row, completion trends, score distribution, dropout funnel.
// All data loaded from backend via real API calls.
// Auto-refreshes every 30 seconds for near-real-time learner analytics.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import 'widgets/trainer_page_scaffold.dart';

class CourseAnalyticsV2Screen extends ConsumerStatefulWidget {
  const CourseAnalyticsV2Screen({super.key, required this.courseId});

  final int courseId;

  @override
  ConsumerState<CourseAnalyticsV2Screen> createState() =>
      _CourseAnalyticsV2ScreenState();
}

class _CourseAnalyticsV2ScreenState
    extends ConsumerState<CourseAnalyticsV2Screen> {
  bool _loading = true;
  String? _error;

  List<CourseVersion> _allVersions = [];
  CourseVersion? _selectedVersion;
  CourseAnalytics? _analytics;
  List<Enrollment> _enrollments = [];
  List<Certificate> _certificates = [];
  List<TrainingRecord> _trainingRecords = [];

  Map<String, int> _scoreDistribution = {};

  /// Auto-refresh timer — refreshes analytics every 30 seconds.
  Timer? _autoRefreshTimer;
  bool _autoRefreshEnabled = true;
  DateTime? _lastRefreshedAt;

  @override
  void initState() {
    super.initState();
    _loadVersions();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted || !_autoRefreshEnabled) return;
      if (_selectedVersion != null) {
        _silentRefresh();
      }
    });
  }

  /// Refresh data without showing the loading spinner (for background auto-refresh).
  Future<void> _silentRefresh() async {
    if (_selectedVersion == null) return;
    try {
      final versionId = _selectedVersion!.id!;
      final results = await Future.wait([
        client.analytics.getCourseAnalytics(versionId),
        client.training.getEnrollmentsForCourseVersion(versionId),
        client.training.getCertificatesForCourseVersion(versionId),
        client.training.getTrainingRecordsForCourseVersion(versionId),
      ]);

      final analytics = results[0] as CourseAnalytics;
      final enrollments = results[1] as List<Enrollment>;
      final certificates = results[2] as List<Certificate>;
      final records = results[3] as List<TrainingRecord>;

      Map<String, int> scoreDist = {};
      if (analytics.scoreDistributionJson != null &&
          analytics.scoreDistributionJson!.isNotEmpty) {
        final decoded = jsonDecode(analytics.scoreDistributionJson!);
        if (decoded is Map) {
          scoreDist = decoded.map(
            (k, v) => MapEntry(k.toString(), (v as num).toInt()),
          );
        }
      }

      if (mounted) {
        setState(() {
          _analytics = analytics;
          _enrollments = enrollments;
          _certificates = certificates;
          _trainingRecords = records;
          _scoreDistribution = scoreDist;
          _lastRefreshedAt = DateTime.now();
        });
      }
    } catch (_) {
      // Silent — don't show error for background refresh
    }
  }

  Future<void> _loadVersions() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final versions = await client.course.getCourseVersions(widget.courseId);
      if (versions.isEmpty) {
        setState(() {
          _loading = false;
          _error = 'No course versions found.';
        });
        return;
      }

      versions.sort((a, b) => b.version.compareTo(a.version));
      setState(() => _allVersions = versions);
      await _loadVersionData(versions.first);
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load course versions: $e';
      });
    }
  }

  Future<void> _loadVersionData(CourseVersion version) async {
    setState(() {
      _loading = true;
      _error = null;
      _selectedVersion = version;
    });

    try {
      final versionId = version.id!;
      final results = await Future.wait([
        client.analytics.getCourseAnalytics(versionId),
        client.training.getEnrollmentsForCourseVersion(versionId),
        client.training.getCertificatesForCourseVersion(versionId),
        client.training.getTrainingRecordsForCourseVersion(versionId),
      ]);

      final analytics = results[0] as CourseAnalytics;
      final enrollments = results[1] as List<Enrollment>;
      final certificates = results[2] as List<Certificate>;
      final records = results[3] as List<TrainingRecord>;

      Map<String, int> scoreDist = {};
      if (analytics.scoreDistributionJson != null &&
          analytics.scoreDistributionJson!.isNotEmpty) {
        final decoded = jsonDecode(analytics.scoreDistributionJson!);
        if (decoded is Map) {
          scoreDist = decoded.map(
            (k, v) => MapEntry(k.toString(), (v as num).toInt()),
          );
        }
      }

      setState(() {
        _analytics = analytics;
        _enrollments = enrollments;
        _certificates = certificates;
        _trainingRecords = records;
        _scoreDistribution = scoreDist;
        _loading = false;
        _lastRefreshedAt = DateTime.now();
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load analytics: $e';
      });
    }
  }

  /// Each menu value must appear exactly once (Flutter [DropdownButton] asserts otherwise).
  List<CourseVersion> get _dropdownVersions {
    final seen = <int>{};
    final out = <CourseVersion>[];
    for (final v in _allVersions) {
      final id = v.id;
      if (id == null) continue;
      if (seen.add(id)) out.add(v);
    }
    return out;
  }

  /// [DropdownButton] requires [value] to be null or equal to exactly one item.
  int? get _dropdownValue {
    final id = _selectedVersion?.id;
    if (id == null) return null;
    var matches = 0;
    for (final v in _dropdownVersions) {
      if (v.id == id) matches++;
    }
    return matches == 1 ? id : null;
  }

  int get _enrolledCount => _enrollments.length;

  int get _completedCount =>
      _enrollments.where((e) => e.status == 'completed').length;

  int get _inProgressCount =>
      _enrollments.where((e) => e.status == 'in_progress').length;

  int get _overdueCount =>
      _enrollments.where((e) => e.status == 'overdue').length;

  int get _notStartedCount =>
      _enrollments.where((e) => e.status == 'not_started').length;

  int get _certifiedCount => _certificates.length;

  double get _completionRate =>
      _enrolledCount > 0 ? _completedCount / _enrolledCount : 0.0;

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const TrainerPageLoading(cardCount: 5);
    }

    if (_error != null) {
      return TrainerPageError(message: _error!, onRetry: _loadVersions);
    }

    return RefreshIndicator(
      onRefresh: () => _selectedVersion != null
          ? _loadVersionData(_selectedVersion!)
          : _loadVersions(),
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: PharmaSpacing.sectionGap),
          _buildStatsRow(),
          const SizedBox(height: 16),
          _buildEngagementRow(),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildAverageProgressCard(),
                    const SizedBox(height: 20),
                    _buildCompletionTimeline(),
                    const SizedBox(height: 20),
                    _buildScoreDistribution(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    _buildDropoutFunnel(),
                    const SizedBox(height: 20),
                    _buildRecentCompletions(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLearnerTable(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final versionLabel = _selectedVersion != null
        ? 'v${_selectedVersion!.version}'
        : '';
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/trainer/courses'),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.analytics_outlined,
          color: PharmaColors.emerald600,
          size: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Analytics $versionLabel',
                style: PharmaTypography.headingLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Performance metrics and learner insights',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        if (_dropdownVersions.length > 1) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: PharmaColors.borderLight),
              borderRadius: PharmaRadius.inputRadius,
            ),
            child: DropdownButton<int>(
              value: _dropdownValue,
              underline: const SizedBox.shrink(),
              isDense: true,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textPrimary,
              ),
              items: _dropdownVersions.map((v) {
                return DropdownMenuItem(
                  value: v.id,
                  child: Text('v${v.version}'),
                );
              }).toList(),
              onChanged: (vId) {
                if (vId == null) return;
                final version = _dropdownVersions.firstWhere((v) => v.id == vId);
                _loadVersionData(version);
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
        IconButton(
          onPressed: _selectedVersion != null
              ? () => _loadVersionData(_selectedVersion!)
              : _loadVersions,
          icon: const Icon(Icons.refresh, size: 20),
          tooltip: 'Refresh',
        ),
        const SizedBox(width: 4),
        // ── Live auto-refresh indicator ──
        GestureDetector(
          onTap: () => setState(() => _autoRefreshEnabled = !_autoRefreshEnabled),
          child: Tooltip(
            message: _autoRefreshEnabled
                ? 'Auto-refresh ON (every 30s) — tap to pause'
                : 'Auto-refresh paused — tap to resume',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _autoRefreshEnabled ? const Color(0xFFECFDF5) : PharmaColors.gray100,
                borderRadius: PharmaRadius.pillRadius,
                border: Border.all(color: _autoRefreshEnabled ? PharmaColors.emerald600 : PharmaColors.gray300),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _autoRefreshEnabled ? PharmaColors.emerald600 : PharmaColors.gray400,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _autoRefreshEnabled ? 'LIVE' : 'PAUSED',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _autoRefreshEnabled ? PharmaColors.emerald700 : PharmaColors.gray600,
                  ),
                ),
                if (_lastRefreshedAt != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    _formatTimeAgo(_lastRefreshedAt!),
                    style: TextStyle(fontSize: 9, color: PharmaColors.textTertiary),
                  ),
                ],
              ]),
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: _selectedVersion?.id == null
              ? null
              : () async {
                  try {
                    final csv = await client.analytics
                        .exportCourseAnalyticsCsv(
                            courseVersionId: _selectedVersion!.id!);
                    if (!mounted) return;
                    _showExportResult(context, csv, 'Course Analytics Export');
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Export failed: $e')),
                    );
                  }
                },
          icon: const Icon(Icons.download, size: 16),
          label: const Text('Export'),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final passRate = _analytics?.passRate ?? 0.0;
    final failedCount = (_analytics?.totalAttempts ?? 0) -
        (_analytics?.passedCount ?? 0);

    return Row(
      children: [
        _statCard(
          'Total Enrolled',
          '$_enrolledCount',
          Icons.people,
          PharmaColors.emerald600,
          _selectedVersion != null
              ? 'v${_selectedVersion!.version}'
              : '',
        ),
        _statCard(
          'Completed',
          '$_completedCount',
          Icons.check_circle,
          PharmaColors.emerald600,
          '${(_completionRate * 100).toStringAsFixed(1)}%',
        ),
        _statCard(
          'In Progress',
          '$_inProgressCount',
          Icons.pending,
          PharmaColors.warningText,
          _enrolledCount > 0
              ? '${(_inProgressCount / _enrolledCount * 100).toStringAsFixed(1)}%'
              : '0%',
        ),
        _statCard(
          'Pass Rate',
          '${(passRate * 100).toStringAsFixed(1)}%',
          Icons.verified,
          PharmaColors.success,
          '${_analytics?.passedCount ?? 0} of ${_analytics?.totalAttempts ?? 0}',
        ),
        _statCard(
          'Failed',
          '$failedCount',
          Icons.cancel,
          PharmaColors.danger,
          '${_analytics?.totalAttempts ?? 0} attempts',
        ),
        _statCard(
          'Certified',
          '$_certifiedCount',
          Icons.workspace_premium,
          PharmaColors.info,
          'certificates issued',
        ),
      ].map(
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

  Widget _buildEngagementRow() {
    final hours =
        ((_analytics?.totalTimeSpentSeconds ?? 0) / 3600.0).toStringAsFixed(1);
    return Row(
      children: [
        _statCard(
          'Time on content',
          '$hours h',
          Icons.timer_outlined,
          PharmaColors.info,
          'material progress (sum)',
        ),
        _statCard(
          'Training assignments',
          '${_analytics?.activeTrainingAssignmentCount ?? 0}',
          Icons.assignment_outlined,
          PharmaColors.warningText,
          'active for enrolled learners',
        ),
        _statCard(
          'Coursework submissions',
          '${_analytics?.courseworkSubmissionCount ?? 0}',
          Icons.upload_file,
          PharmaColors.emerald600,
          'lesson assignment submissions',
        ),
        _statCard(
          'Assessment attempts',
          '${_analytics?.assessmentAttemptCount ?? 0}',
          Icons.quiz_outlined,
          PharmaColors.info,
          '${_analytics?.passedAssessmentAttemptCount ?? 0} passed',
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

  Widget _buildAverageProgressCard() {
    final pct = (_analytics?.averageMaterialProgressPct ?? 0.0)
        .clamp(0.0, 100.0);
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
          Text(
            'Average material progress',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            'Mean progress % across material progress rows linked to enrollments for this version.',
            style: PharmaTypography.caption
                .copyWith(color: PharmaColors.textTertiary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: pct / 100,
                    minHeight: 12,
                    backgroundColor: PharmaColors.gray100,
                    color: PharmaColors.emerald600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${pct.toStringAsFixed(1)}%',
                style: PharmaTypography.bodyMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String label,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
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
              Text(
                value,
                style: PharmaTypography.statNumber.copyWith(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(subtitle, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }

  Widget _buildCompletionTimeline() {
    final completedEnrollments = _enrollments
        .where((e) => e.completedAt != null)
        .toList()
      ..sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

    Map<String, int> monthlyCompletions = {};
    for (final e in completedEnrollments) {
      final key =
          '${e.completedAt!.year}-${e.completedAt!.month.toString().padLeft(2, '0')}';
      monthlyCompletions[key] = (monthlyCompletions[key] ?? 0) + 1;
    }

    final sortedKeys = monthlyCompletions.keys.toList()..sort();
    final maxCount = monthlyCompletions.values.fold<int>(
      1,
      (a, b) => a > b ? a : b,
    );

    if (sortedKeys.isEmpty) {
      return _emptyCard(
        'Completion Trend',
        'No completions recorded yet.',
        Icons.timeline,
      );
    }

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
          Text(
            'Completion Trend',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            '${completedEnrollments.length} total completions',
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: sortedKeys.map((key) {
                final count = monthlyCompletions[key]!;
                final frac = count / maxCount;
                final parts = key.split('-');
                const monthNames = [
                  '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
                ];
                final label = monthNames[int.parse(parts[1])];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: frac,
                            child: Container(
                              decoration: BoxDecoration(
                                color: PharmaColors.emerald600,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 10,
                            color: PharmaColors.textTertiary,
                          ),
                        ),
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

  Widget _buildScoreDistribution() {
    if (_scoreDistribution.isEmpty) {
      return _emptyCard(
        'Score Distribution',
        'No score data available yet.',
        Icons.bar_chart,
      );
    }

    const bucketOrder = ['0-20', '21-40', '41-60', '61-80', '81-100'];
    final orderedKeys = <String>[];
    for (final key in bucketOrder) {
      if (_scoreDistribution.containsKey(key)) orderedKeys.add(key);
    }
    for (final key in _scoreDistribution.keys) {
      if (!orderedKeys.contains(key)) orderedKeys.add(key);
    }

    final maxVal = _scoreDistribution.values.fold<int>(
      1,
      (a, b) => a > b ? a : b,
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
          Text(
            'Score Distribution',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            'Assessment score breakdown',
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: orderedKeys.map((key) {
                final count = _scoreDistribution[key]!;
                final frac = count / maxVal;

                Color barColor;
                if (key == '81-100') {
                  barColor = PharmaColors.emerald600;
                } else if (key == '61-80') {
                  barColor = PharmaColors.success;
                } else if (key == '41-60') {
                  barColor = PharmaColors.warningText;
                } else {
                  barColor = PharmaColors.danger;
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: barColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: frac,
                            child: Container(
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$key%',
                          style: const TextStyle(
                            fontSize: 10,
                            color: PharmaColors.textTertiary,
                          ),
                        ),
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

  Widget _buildDropoutFunnel() {
    final started = _enrollments
        .where((e) => e.status != 'not_started')
        .length;

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
          Text(
            'Completion Funnel',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 16),
          _funnelRow('Enrolled', _enrolledCount, 1.0),
          _funnelRow(
            'Started',
            started,
            _enrolledCount > 0 ? started / _enrolledCount : 0.0,
          ),
          _funnelRow(
            'Completed',
            _completedCount,
            _enrolledCount > 0 ? _completedCount / _enrolledCount : 0.0,
          ),
          _funnelRow(
            'Certified',
            _certifiedCount,
            _enrolledCount > 0 ? _certifiedCount / _enrolledCount : 0.0,
          ),
        ],
      ),
    );
  }

  Widget _funnelRow(String label, int count, double frac) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  label,
                  style: PharmaTypography.caption.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '$count',
                style: PharmaTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: frac,
              backgroundColor: PharmaColors.gray100,
              color: PharmaColors.emerald600,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCompletions() {
    final recentRecords = List<TrainingRecord>.from(_trainingRecords)
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    final display = recentRecords.take(5).toList();

    if (display.isEmpty) {
      return _emptyCard(
        'Recent Completions',
        'No training records yet.',
        Icons.history,
      );
    }

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
          Text(
            'Recent Completions',
            style: PharmaTypography.headingSmall.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ...display.map((r) {
            final timeAgo = _formatTimeAgo(r.completedAt);
            final scoreText = r.score != null ? '${r.score}%' : 'N/A';
            final userLabel = r.user != null
                ? '${r.user!.firstName} ${r.user!.lastName}'
                : 'User #${r.userId}';
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: PharmaColors.emerald600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$userLabel — Score: $scoreText',
                          style: PharmaTypography.caption,
                        ),
                        Text(
                          timeAgo,
                          style: const TextStyle(
                            fontSize: 10,
                            color: PharmaColors.textTertiary,
                          ),
                        ),
                      ],
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

  // ═══════════════════════════════════════════════════════════════════════════
  // LEARNER TABLE — Real-time individual user analytics
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildLearnerTable() {
    if (_enrollments.isEmpty) {
      return _emptyCard(
        'Learner Analytics',
        'No enrolled learners yet.',
        Icons.people_outline,
      );
    }

    // Build a map of userId → TrainingRecord for quick lookup
    final recordsByUser = <int, TrainingRecord>{};
    for (final r in _trainingRecords) {
      recordsByUser[r.userId] = r;
    }

    // Sort enrollments: completed first, then in_progress, then others
    final sorted = List<Enrollment>.from(_enrollments)
      ..sort((a, b) {
        const order = {'completed': 0, 'in_progress': 1, 'not_started': 2, 'overdue': 3};
        final oa = order[a.status] ?? 4;
        final ob = order[b.status] ?? 4;
        if (oa != ob) return oa.compareTo(ob);
        return (b.status == 'completed' ? 100 : 0).compareTo(a.status == 'completed' ? 100 : 0);
      });

    return Container(
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.people, size: 20, color: PharmaColors.emerald600),
                const SizedBox(width: 10),
                Text(
                  'Learner Analytics',
                  style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: PharmaColors.emerald50, borderRadius: PharmaRadius.pillRadius),
                  child: Text(
                    '${_enrollments.length} learners',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: PharmaColors.emerald700),
                  ),
                ),
                const Spacer(),
                if (_autoRefreshEnabled)
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 6, height: 6,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: PharmaColors.emerald600),
                    ),
                    const SizedBox(width: 4),
                    Text('Live', style: TextStyle(fontSize: 10, color: PharmaColors.emerald600, fontWeight: FontWeight.w600)),
                  ]),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          // Table header
          Container(
            color: PharmaColors.pageBg,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                SizedBox(width: 200, child: Text('Learner', style: _tableHeaderStyle)),
                SizedBox(width: 100, child: Text('Status', style: _tableHeaderStyle)),
                SizedBox(width: 90, child: Text('Progress', style: _tableHeaderStyle)),
                SizedBox(width: 80, child: Text('Score', style: _tableHeaderStyle)),
                Expanded(child: Text('Enrolled', style: _tableHeaderStyle)),
                SizedBox(width: 100, child: Text('Completed', style: _tableHeaderStyle)),
              ],
            ),
          ),
          Divider(height: 1, color: PharmaColors.borderLight),
          // Table rows
          ...sorted.map((enrollment) {
            final record = recordsByUser[enrollment.userId];
            final userName = enrollment.user != null
                ? '${enrollment.user!.firstName} ${enrollment.user!.lastName}'
                : 'User #${enrollment.userId}';
            final progress = enrollment.status == 'completed' ? 100 : (enrollment.status == 'in_progress' ? 50 : 0);
            final score = record?.score;
            final enrolledAt = enrollment.startedAt;
            final completedAt = enrollment.completedAt;

            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: PharmaColors.borderLight.withValues(alpha: 0.5))),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Row(children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: PharmaColors.emerald50,
                        child: Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: PharmaColors.emerald700),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(userName, style: PharmaTypography.bodyMedium, overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: 100,
                    child: _statusChip(enrollment.status),
                  ),
                  SizedBox(
                    width: 90,
                    child: Row(children: [
                      SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: progress / 100,
                            backgroundColor: PharmaColors.gray100,
                            color: progress >= 100 ? PharmaColors.emerald600 : PharmaColors.info,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('$progress%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    ]),
                  ),
                  SizedBox(
                    width: 80,
                    child: score != null
                        ? Text(
                            '$score%',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: score >= (_analytics?.passRate != null ? 80 : 80)
                                  ? PharmaColors.emerald600
                                  : PharmaColors.danger,
                            ),
                          )
                        : Text('—', style: TextStyle(color: PharmaColors.textTertiary)),
                  ),
                  Expanded(
                    child: Text(
                      enrolledAt != null ? _formatDate(enrolledAt) : '—',
                      style: PharmaTypography.caption,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      completedAt != null ? _formatDate(completedAt) : '—',
                      style: PharmaTypography.caption,
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

  Widget _statusChip(String status) {
    Color bg, fg;
    String label;
    switch (status) {
      case 'completed':
        bg = PharmaColors.successBg; fg = PharmaColors.successText; label = 'Completed';
      case 'in_progress':
        bg = PharmaColors.infoBg; fg = PharmaColors.info; label = 'In Progress';
      case 'overdue':
        bg = PharmaColors.dangerBg; fg = PharmaColors.danger; label = 'Overdue';
      case 'not_started':
        bg = PharmaColors.gray100; fg = PharmaColors.gray600; label = 'Not Started';
      default:
        bg = PharmaColors.gray100; fg = PharmaColors.gray600; label = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: PharmaRadius.pillRadius),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  TextStyle get _tableHeaderStyle => PharmaTypography.caption.copyWith(
    fontWeight: FontWeight.w600,
    color: PharmaColors.textTertiary,
    fontSize: 11,
  );

  String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '$d ${months[dt.month]} ${dt.year}';
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
          Text(
            title,
            style: PharmaTypography.headingSmall.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: PharmaTypography.caption.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }

  void _showExportResult(
      BuildContext context, String csvContent, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 500,
          height: 400,
          child: SingleChildScrollView(
            child: SelectableText(
              csvContent,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: csvContent));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
            child: const Text('Copy All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
