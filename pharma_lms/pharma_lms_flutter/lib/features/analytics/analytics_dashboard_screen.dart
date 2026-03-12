import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_providers.dart';
import '../../widgets/section_header.dart';

/// Analytics dashboard with fl_chart, real API calls, and real-time stream.
class AnalyticsDashboardScreen extends ConsumerStatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  ConsumerState<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState
    extends ConsumerState<AnalyticsDashboardScreen> {
  Map<String, double> _completionRates = {};
  List<DepartmentComplianceSummary> _complianceSummary = [];
  int _certExpiryRisk = 0;
  AuditReadinessScore? _auditReadiness;
  List<SlaBreach> _openBreaches = [];
  Map<String, dynamic>? _trainingDeviationCorrelation;
  Map<String, dynamic>? _slaSummary;
  Map<String, dynamic>? _complianceDeviationOverlay;
  List<Map<String, dynamic>> _complianceTrend = [];
  double _sopRetrainingVelocity = 0;
  bool _loading = true;
  String? _error;
  DateTime? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _applyStreamUpdate(AnalyticsEvent event) {
    if (!mounted) return;
    try {
      final payload = jsonDecode(event.payloadJson) as Map<String, dynamic>?;
      if (payload == null) return;
      setState(() {
        if (payload['completionRates'] != null) {
          _completionRates = Map<String, double>.from(
            (payload['completionRates'] as Map).map(
              (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
            ),
          );
        }
        if (payload['certExpiryRiskCount'] != null) {
          _certExpiryRisk = payload['certExpiryRiskCount'] as int;
        }
        _lastUpdated = event.occurredAt;
      });
    } catch (_) {}
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${dt.month}/${dt.day} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final completion = await client.analytics.getTrainingCompletionRate();
      final compliance = await client.analytics.getDepartmentComplianceSummary();
      final certRisk = await client.analytics.getCertificationExpiryRiskCount();
      final readiness = await client.analytics.getAuditReadinessScore();
      final breaches = await client.analytics.getOpenSlaBreaches();
      final correlation = await client.analytics.getTrainingVsDeviationCorrelation();
      final slaSummary = await client.analytics.getSlaSummary();
      final overlay = await client.analytics.getComplianceDeviationOverlay();
      List<Map<String, dynamic>> trend = [];
      var sopVelocity = 0.0;
      try {
        trend = await client.analytics.getComplianceTrend(months: 12);
      } catch (_) {}
      try {
        sopVelocity = await client.analytics.getSopRetrainingVelocity();
      } catch (_) {}

      setState(() {
        _completionRates = completion;
        _complianceSummary = compliance;
        _certExpiryRisk = certRisk;
        _auditReadiness = readiness;
        _openBreaches = breaches;
        _trainingDeviationCorrelation = correlation;
        _slaSummary = slaSummary;
        _complianceDeviationOverlay = overlay;
        _complianceTrend = trend;
        _sopRetrainingVelocity = sopVelocity;
        _lastUpdated = DateTime.now();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    ref.listen<AsyncValue<AnalyticsEvent>>(
      analyticsStreamProvider('compliance'),
      (prev, next) {
        next.whenData(_applyStreamUpdate);
      },
    );
    final streamAsync = ref.watch(analyticsStreamProvider('compliance'));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Analytics'),
            streamAsync.when(
              data: (_) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Chip(
                  label: const Text('Live', style: TextStyle(fontSize: 10)),
                  backgroundColor: Colors.green.shade100,
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            SectionHeader(
              icon: Icons.analytics,
              title: 'Analytics Overview',
              color: AppColors.indigo600,
            ),
            const SizedBox(height: 16),
            if (_auditReadiness != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inspection Readiness Score',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(_auditReadiness!.overallScore * 100).toStringAsFixed(0)}/100',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (_lastUpdated != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Last updated: ${_formatTime(_lastUpdated!)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate500,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Training Completion Rate by Department',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    if (_completionRates.isEmpty)
                      const Text('No data')
                    else
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            barGroups: _completionRates.entries
                                .toList()
                                .asMap()
                                .entries
                                .map((e) => BarChartGroupData(
                                      x: e.key,
                                      barRods: [
                                        BarChartRodData(
                                          toY: e.value.value,
                                          color: Colors.blue,
                                          width: 16,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(4),
                                          ),
                                        ),
                                      ],
                                      showingTooltipIndicators: [0],
                                    ))
                                .toList(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 32,
                                  getTitlesWidget: (v, meta) => Text(
                                    '${v.toInt()}%',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (v, meta) {
                                    final entries =
                                        _completionRates.entries.toList();
                                    if (v.toInt() >= 0 &&
                                        v.toInt() < entries.length) {
                                      final name = entries[v.toInt()].key;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          name.length > 8
                                              ? '${name.substring(0, 8)}..'
                                              : name,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(show: true),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Department Compliance',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (_complianceSummary.isEmpty)
                      const Text('No data')
                    else
                      ..._complianceSummary.map((m) => InkWell(
                            onTap: () {
                              if (m.departmentId != null) {
                                context.push(
                                  '/compliance-report?departmentId=${m.departmentId}',
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      m.departmentName ?? '',
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (m.complianceRate >= 0.9
                                              ? AppColors.success
                                              : m.complianceRate >= 0.7
                                                  ? AppColors.warning
                                                  : AppColors.destructive)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${(m.complianceRate * 100).toStringAsFixed(1)}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: m.complianceRate >= 0.9
                                            ? AppColors.success
                                            : m.complianceRate >= 0.7
                                                ? AppColors.warning
                                                : AppColors.destructive,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Overdue: ${m.overdue}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  if (m.departmentId != null)
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: AppColors.slate500,
                                    ),
                                ],
                              ),
                            ),
                          )),
                  ],
                ),
              ),
            ),
            if (_complianceTrend.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '12-Month Compliance Trend',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 180,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: _complianceTrend
                                    .asMap()
                                    .entries
                                    .map((e) => FlSpot(
                                          e.key.toDouble(),
                                          ((e.value['complianceRate'] as num?) ?? 0) * 100,
                                        ))
                                    .toList(),
                                isCurved: true,
                                color: AppColors.indigo600,
                                barWidth: 2,
                                dotData: const FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: AppColors.indigo600.withValues(alpha: 0.1),
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 32,
                                  getTitlesWidget: (v, meta) => Text(
                                    '${v.toInt()}%',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 24,
                                  getTitlesWidget: (v, meta) {
                                    final entries = _complianceTrend;
                                    if (v.toInt() >= 0 && v.toInt() < entries.length) {
                                      final m = entries[v.toInt()]['month'] as String? ?? '';
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          m.length > 7 ? m.substring(5) : m,
                                          style: const TextStyle(fontSize: 9),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(show: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_sopRetrainingVelocity > 0 || _complianceSummary.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SOP Retraining Velocity',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(_sopRetrainingVelocity * 100).toStringAsFixed(1)}% employees retrained within 30 days of SOP update',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Certification Expiry Risk',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_certExpiryRisk certs expiring in next 30 days',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            if (_trainingDeviationCorrelation != null) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CAPA Effectiveness',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${((_trainingDeviationCorrelation!['capaEffectivenessRate'] as num?) ?? 0) * 100}% (${_trainingDeviationCorrelation!['closedCapas'] ?? 0}/${_trainingDeviationCorrelation!['totalCapas'] ?? 0} closed)',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_slaSummary != null) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SLA Summary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Policies: ${_slaSummary!['policyCount'] ?? 0} | '
                        'Open breaches: ${_slaSummary!['openBreachCount'] ?? 0}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_complianceDeviationOverlay != null &&
                (_complianceDeviationOverlay!['highRiskDepartments'] as List?)?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Card(
                color: const Color(0xFFFEF2F2),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning_amber, color: Color(0xFFDC2626)),
                          const SizedBox(width: 8),
                          Text(
                            'High Risk Departments',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF991B1B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...((_complianceDeviationOverlay!['highRiskDepartments'] as List?) ?? []).map((d) {
                        final m = d as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(m['departmentName'] ?? ''),
                              ),
                              Text(
                                '${((m['complianceRate'] as num?) ?? 0) * 100}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFDC2626),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Overdue: ${m['overdue'] ?? 0}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
            if (_openBreaches.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Open SLA Breaches',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ..._openBreaches.map((b) => ListTile(
                            title: Text('Breach #${b.id}'),
                            subtitle: Text(
                              'Breached: ${b.breachedAt.toIso8601String()}',
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
