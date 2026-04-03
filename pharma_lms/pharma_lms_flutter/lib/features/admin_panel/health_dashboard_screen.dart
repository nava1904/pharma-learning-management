import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// IT-02: AWS CloudWatch-style System Health Command Center.
/// Displays system status, DLQ count, and manual job triggers.
class HealthDashboardScreen extends StatefulWidget {
  const HealthDashboardScreen({super.key});

  @override
  State<HealthDashboardScreen> createState() => _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends State<HealthDashboardScreen> {
  Map<String, String>? _health;
  bool _loading = true;
  String? _error;

  // Job loading states
  final Map<String, bool> _jobLoadingStates = {
    'ComplianceCalc': false,
    'CertExpiryCheck': false,
    'NotificationWorker': false,
    'AuditTrailIntegrityCheck': false,
  };

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
        _health = health.map((k, v) => MapEntry(k, v.toString()));
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _showSuccessSnackBar(String message, {Map<String, String>? result}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message),
                  if (result != null && result['recordsProcessed'] != null)
                    Text(
                      'Processed: ${result['recordsProcessed']} records',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.destructive,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _runJob(String jobName, Future<Map<String, dynamic>> Function() jobFn) async {
    setState(() => _jobLoadingStates[jobName] = true);
    try {
      final result = await jobFn();
      _showSuccessSnackBar('$jobName completed successfully', result: result.map((k, v) => MapEntry(k, v.toString())));
      _load(); // Refresh to show updated job history
    } catch (e) {
      _showErrorSnackBar('$jobName failed: $e');
    } finally {
      if (mounted) setState(() => _jobLoadingStates[jobName] = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Dark hero header (AWS CloudWatch style)
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.slate900,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: _load,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroHeader(),
            ),
          ),

          // Body content
          SliverToBoxAdapter(
            child: _loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(64),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _error != null
                    ? _buildErrorState()
                    : _buildDashboardContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    final dlqCount = int.tryParse(_health?['dlqCount'] ?? '') ?? 0;
    final dbOk = _health?['databaseConnected'] == 'true';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.slate900,
            AppColors.slate800,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(56, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: dbOk
                          ? AppColors.success.withValues(alpha: 0.2)
                          : AppColors.destructive.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      dbOk ? Icons.cloud_done : Icons.cloud_off,
                      color: dbOk ? AppColors.success : AppColors.destructive,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Status',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: dbOk ? AppColors.success : AppColors.destructive,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            dbOk ? 'All Systems Operational' : 'Service Degraded',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate400,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // DLQ Alert Banner
              if (!_loading)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: dlqCount > 0
                        ? AppColors.destructive.withValues(alpha: 0.15)
                        : AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: dlqCount > 0
                          ? AppColors.destructive.withValues(alpha: 0.3)
                          : AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        dlqCount > 0 ? Icons.warning_amber : Icons.check_circle,
                        color: dlqCount > 0 ? AppColors.destructive : AppColors.success,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dead Letter Queue',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            dlqCount > 0 ? '$dlqCount unresolved' : 'Clear',
                            style: TextStyle(
                              color: dlqCount > 0
                                  ? AppColors.destructive
                                  : AppColors.success,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        dlqCount > 0 ? '⚠️ Action Required' : '✅ Healthy',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
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

  Widget _buildErrorState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.slate100, AppColors.slate50],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.destructive),
              const SizedBox(height: 16),
              Text(
                'Failed to load system health',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                _error ?? 'Unknown error',
                style: TextStyle(color: AppColors.slate600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    final dbOk = _health!['databaseConnected'] == 'true';
    final dlqCount = int.tryParse(_health!['dlqCount'] ?? '') ?? 0;
    final kafkaLag = int.tryParse(_health!['kafkaConsumerLag'] ?? '') ?? 0;
    final recentJobsRaw = _health!['recentJobs'];
    List<dynamic> recentJobs = [];
    if (recentJobsRaw != null && recentJobsRaw.isNotEmpty) {
      try {
        final decoded = jsonDecode(recentJobsRaw);
        if (decoded is List) recentJobs = decoded;
      } catch (_) {}
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.slate100, AppColors.slate50],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Cards Row
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth > 600
                    ? (constraints.maxWidth - 48) / 3
                    : constraints.maxWidth;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildStatusCard(
                      width: cardWidth,
                      icon: Icons.storage,
                      iconColor: dbOk ? AppColors.success : AppColors.destructive,
                      title: 'Database',
                      value: dbOk ? 'Connected' : 'Disconnected',
                      status: dbOk ? 'healthy' : 'critical',
                    ),
                    _buildStatusCard(
                      width: cardWidth,
                      icon: Icons.inbox,
                      iconColor: dlqCount == 0 ? AppColors.success : AppColors.destructive,
                      title: 'DLQ Items',
                      value: dlqCount.toString(),
                      status: dlqCount == 0 ? 'healthy' : 'critical',
                    ),
                    _buildStatusCard(
                      width: cardWidth,
                      icon: Icons.sync,
                      iconColor: kafkaLag > 1000 ? AppColors.warning : AppColors.success,
                      title: 'Kafka Lag',
                      value: kafkaLag.toString(),
                      status: kafkaLag > 1000 ? 'warning' : 'healthy',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // Manual Job Triggers Section
            Text(
              'Scheduled Job Triggers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manually trigger background automation jobs for testing and maintenance.',
              style: TextStyle(color: AppColors.slate600),
            ),
            const SizedBox(height: 16),

            // Job Trigger Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 800
                    ? 4
                    : constraints.maxWidth > 500
                        ? 2
                        : 1;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: crossAxisCount == 1 ? 4 : 2,
                  children: [
                    _buildJobTriggerCard(
                      workflowId: 'SYS-WF-07',
                      title: 'Compliance Calc',
                      description: 'Compute org & dept compliance',
                      icon: Icons.analytics,
                      iconColor: AppColors.indigo600,
                      loading: _jobLoadingStates['ComplianceCalc']!,
                      onTrigger: () => _runJob(
                        'ComplianceCalc',
                        () => client.analytics.runComplianceCalc(),
                      ),
                    ),
                    _buildJobTriggerCard(
                      workflowId: 'SYS-WF-04',
                      title: 'Cert Expiry Check',
                      description: 'Check & renew certificates',
                      icon: Icons.card_membership,
                      iconColor: AppColors.teal600,
                      loading: _jobLoadingStates['CertExpiryCheck']!,
                      onTrigger: () => _runJob(
                        'CertExpiryCheck',
                        () => client.analytics.runCertExpiryCheck(),
                      ),
                    ),
                    _buildJobTriggerCard(
                      workflowId: 'SYS-WF-05',
                      title: 'Notification Ladder',
                      description: 'Process due date escalations',
                      icon: Icons.notifications_active,
                      iconColor: AppColors.amber600,
                      loading: _jobLoadingStates['NotificationWorker']!,
                      onTrigger: () => _runJob(
                        'NotificationWorker',
                        () => client.analytics.runNotificationWorker(),
                      ),
                    ),
                    _buildJobTriggerCard(
                      workflowId: 'SYS-WF-08',
                      title: 'Audit Integrity',
                      description: '21 CFR 11 hash verification',
                      icon: Icons.verified_user,
                      iconColor: AppColors.destructive,
                      loading: _jobLoadingStates['AuditTrailIntegrityCheck']!,
                      onTrigger: () => _runJob(
                        'AuditTrailIntegrityCheck',
                        () => client.analytics.runAuditTrailIntegrityCheck(),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // Recent Jobs Section
            Text(
              'Recent Job Executions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildRecentJobsCard(recentJobs),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required double width,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String status,
  }) {
    Color bgColor;
    switch (status) {
      case 'healthy':
        bgColor = AppColors.success.withValues(alpha: 0.1);
        break;
      case 'warning':
        bgColor = AppColors.warning.withValues(alpha: 0.1);
        break;
      case 'critical':
        bgColor = AppColors.destructive.withValues(alpha: 0.1);
        break;
      default:
        bgColor = AppColors.slate100;
    }

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.slate600,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.slate900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobTriggerCard({
    required String workflowId,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool loading,
    required VoidCallback onTrigger,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        workflowId,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: AppColors.slate600,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: loading ? null : onTrigger,
              style: OutlinedButton.styleFrom(
                foregroundColor: iconColor,
                side: BorderSide(color: iconColor.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: loading
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(iconColor),
                      ),
                    )
                  : Icon(Icons.play_arrow, size: 16),
              label: Text(
                loading ? 'Running...' : 'Run Now',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentJobsCard(List<dynamic> recentJobs) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (recentJobs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: AppColors.slate400),
                  const SizedBox(height: 12),
                  Text(
                    'No recent job executions',
                    style: TextStyle(color: AppColors.slate600),
                  ),
                ],
              ),
            )
          else
            ...recentJobs.asMap().entries.map((entry) {
              final index = entry.key;
              final j = entry.value as Map<String, dynamic>;
              final status = j['status'] as String? ?? 'unknown';
              final recs = j['recordsProcessed'];

              Color statusColor;
              IconData statusIcon;
              switch (status) {
                case 'completed':
                  statusColor = AppColors.success;
                  statusIcon = Icons.check_circle;
                  break;
                case 'failed':
                  statusColor = AppColors.destructive;
                  statusIcon = Icons.error;
                  break;
                case 'running':
                  statusColor = AppColors.info;
                  statusIcon = Icons.sync;
                  break;
                default:
                  statusColor = AppColors.slate500;
                  statusIcon = Icons.help_outline;
              }

              return Container(
                decoration: BoxDecoration(
                  border: index < recentJobs.length - 1
                      ? Border(bottom: BorderSide(color: AppColors.slate200))
                      : null,
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 20),
                  ),
                  title: Text(
                    j['jobName'] as String? ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${_formatStatus(status)} • ${_formatTimestamp(j['startedAt'])}${recs != null ? ' • $recs records' : ''}',
                    style: TextStyle(fontSize: 12, color: AppColors.slate600),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _formatStatus(status),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  String _formatStatus(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'running':
        return 'Running';
      case 'triggered':
        return 'Triggered';
      default:
        return status.substring(0, 1).toUpperCase() + status.substring(1);
    }
  }

  String _formatTimestamp(dynamic ts) {
    if (ts == null) return 'Unknown';
    try {
      final dt = DateTime.parse(ts.toString());
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (_) {
      return ts.toString();
    }
  }
}
