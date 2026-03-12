import 'package:flutter/material.dart';

import '../../core/client.dart';

/// IT-02: System health dashboard - job status, DLQ count, DB connectivity.
class HealthDashboardScreen extends StatefulWidget {
  const HealthDashboardScreen({super.key});

  @override
  State<HealthDashboardScreen> createState() => _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends State<HealthDashboardScreen> {
  Map<String, dynamic>? _health;
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
      final health = await client.analytics.getSystemHealth();
      setState(() {
        _health = health;
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
          title: const Text('System Health'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('System Health'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
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

    final dbOk = _health!['databaseConnected'] as bool? ?? false;
    final dlqCount = _health!['dlqCount'] as int? ?? 0;
    final kafkaLag = _health!['kafkaConsumerLag'] as int? ?? 0;
    final recentJobs = _health!['recentJobs'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Health'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _load,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (dlqCount > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red.shade700, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DLQ Alert: $dlqCount unresolved failures',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),
                          ),
                          Text(
                            'Review and resolve dead letter queue items.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Card(
              child: ListTile(
                leading: Icon(
                  dbOk ? Icons.check_circle : Icons.error,
                  color: dbOk ? Colors.green : Colors.red,
                  size: 32,
                ),
                title: const Text('Database'),
                subtitle: Text(dbOk ? 'Connected' : 'Disconnected'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(
                  dlqCount == 0 ? Icons.check_circle : Icons.warning_amber,
                  color: dlqCount == 0 ? Colors.green : Colors.orange,
                  size: 32,
                ),
                title: const Text('Dead Letter Queue'),
                subtitle: Text('$dlqCount unresolved failures'),
              ),
            ),
            if (kafkaLag > 0) ...[
              const SizedBox(height: 16),
              Card(
                color: kafkaLag > 1000 ? Colors.orange.shade50 : null,
                child: ListTile(
                  leading: Icon(
                    kafkaLag > 1000 ? Icons.warning_amber : Icons.sync,
                    color: kafkaLag > 1000 ? Colors.orange : Colors.grey,
                    size: 32,
                  ),
                  title: const Text('Kafka Consumer Lag'),
                  subtitle: Text(
                    kafkaLag > 1000
                        ? 'Lag: $kafkaLag (alert threshold exceeded)'
                        : 'Lag: $kafkaLag',
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
                      'Recent Jobs',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (recentJobs.isEmpty)
                      const Text('No recent jobs')
                    else
                      ...recentJobs.map((j) {
                        final m = j as Map<String, dynamic>;
                        final recs = m['recordsProcessed'];
                        return ListTile(
                          dense: true,
                          title: Text(m['jobName'] as String? ?? 'Unknown'),
                          subtitle: Text(
                            '${m['status'] ?? '?'} • ${m['startedAt'] ?? ''}'
                            '${recs != null ? ' • $recs processed' : ''}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      }),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          await client.analytics.triggerManualJob(
                            jobName: 'ComplianceCalc',
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Job triggered'),
                              ),
                            );
                            _load();
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed: $e')),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Trigger ComplianceCalc Job'),
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
