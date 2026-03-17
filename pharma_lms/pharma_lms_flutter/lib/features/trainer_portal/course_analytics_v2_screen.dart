// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE ANALYTICS V2 (TRN-08)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/analytics
// Stats row, completion trends, score distribution, dropout funnel.
// All data loaded from backend via real API calls.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

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

  @override
  void initState() {
    super.initState();
    _loadVersions();
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
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load analytics: $e';
      });
    }
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
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text(_error!, style: PharmaTypography.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadVersions,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
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
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
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
        if (_allVersions.length > 1) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: PharmaColors.borderLight),
              borderRadius: PharmaRadius.inputRadius,
            ),
            child: DropdownButton<int>(
              value: _selectedVersion?.id,
              underline: const SizedBox.shrink(),
              isDense: true,
              style: PharmaTypography.caption.copyWith(
                color: PharmaColors.textPrimary,
              ),
              items: _allVersions.map((v) {
                return DropdownMenuItem(
                  value: v.id,
                  child: Text('v${v.version}'),
                );
              }).toList(),
              onChanged: (vId) {
                if (vId == null) return;
                final version = _allVersions.firstWhere((v) => v.id == vId);
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
                        Container(
                          height: 170 * frac,
                          decoration: BoxDecoration(
                            color: PharmaColors.emerald600,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(3),
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
                        Container(
                          height: 140 * frac,
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(3),
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
