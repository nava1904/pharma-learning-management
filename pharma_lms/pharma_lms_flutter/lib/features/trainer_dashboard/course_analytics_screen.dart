import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Course analytics - pass rate and score distribution.
class CourseAnalyticsScreen extends StatefulWidget {
  const CourseAnalyticsScreen({
    super.key,
    required this.courseVersionId,
    this.courseTitle,
  });

  final int courseVersionId;
  final String? courseTitle;

  @override
  State<CourseAnalyticsScreen> createState() => _CourseAnalyticsScreenState();
}

class _CourseAnalyticsScreenState extends State<CourseAnalyticsScreen> {
  CourseAnalytics? _analytics;
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
      final analytics =
          await client.analytics.getCourseAnalytics(widget.courseVersionId);
      setState(() {
        _analytics = analytics;
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
        appBar: AppBar(
          title: Text(widget.courseTitle ?? 'Course Analytics'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Course Analytics'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _load,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final a = _analytics!;
    Map<String, int> distribution = {};
    if (a.scoreDistributionJson != null) {
      try {
        distribution = Map<String, int>.from(
          jsonDecode(a.scoreDistributionJson!) as Map,
        );
      } catch (_) {}
    }
    final entries = distribution.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle ?? 'Course Analytics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pass Rate',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      a.totalAttempts == 0
                          ? 'No completions yet'
                          : '${(a.passRate * 100).toStringAsFixed(1)}% (${a.passedCount}/${a.totalAttempts})',
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
                      'Score Distribution',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    if (entries.isEmpty)
                      const Text('No score data')
                    else
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: (entries
                                        .map((e) => e.value)
                                        .reduce((a, b) => a > b ? a : b) *
                                    1.2)
                                .clamp(1.0, double.infinity),
                            barGroups: entries
                                .asMap()
                                .entries
                                .map((e) => BarChartGroupData(
                                      x: e.key,
                                      barRods: [
                                        BarChartRodData(
                                          toY: e.value.value.toDouble(),
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
                                    '${v.toInt()}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (v, meta) {
                                    if (v.toInt() >= 0 &&
                                        v.toInt() < entries.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          entries[v.toInt()].key,
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
          ],
        ),
      ),
    );
  }
}
