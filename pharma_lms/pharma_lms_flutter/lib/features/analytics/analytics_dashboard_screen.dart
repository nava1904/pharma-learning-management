import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Analytics dashboard with fl_chart and real API calls.
class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  Map<String, double> _completionRates = {};
  List<DepartmentComplianceSummary> _complianceSummary = [];
  int _certExpiryRisk = 0;
  AuditReadinessScore? _auditReadiness;
  List<SlaBreach> _openBreaches = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
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

      setState(() {
        _completionRates = completion;
        _complianceSummary = compliance;
        _certExpiryRisk = certRisk;
        _auditReadiness = readiness;
        _openBreaches = breaches;
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

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_auditReadiness != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Audit Readiness Score',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_auditReadiness!.overallScore.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                      ..._complianceSummary.map((m) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    m.departmentName ?? '',
                                  ),
                                ),
                                Text(
                                  '${m.complianceRate.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Overdue: ${m.overdue}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )),
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
