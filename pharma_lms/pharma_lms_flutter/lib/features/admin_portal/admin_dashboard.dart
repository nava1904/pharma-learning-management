import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show AuditTrail;
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';

/// Admin Portal Dashboard
/// 
/// Displays comprehensive admin dashboard with:
/// - Real-time KPI metrics from database
/// - Compliance status and alerts
/// - Recent admin actions audit trail
/// - Quick action buttons
/// - System health monitoring
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiAsync = ref.watch(adminDashboardKpiProvider);
    final auditAsync = ref.watch(adminRecentAuditProvider);
    final priorityQueuesAsync = ref.watch(adminPriorityQueuesProvider);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Page Header
          _buildPageHeader(),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// KPI Metrics Grid
          kpiAsync.when(
            data: (kpi) => _buildKpiMetrics(context, ref, kpi),
            loading: () => _buildKpiMetricsLoading(),
            error: (e, s) => _buildKpiMetricsError(e.toString()),
          ),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// Priority Queues Section
          priorityQueuesAsync.when(
            data: (queues) => _buildPriorityQueues(context, queues),
            loading: () => _buildLoadingCard('Loading Priority Queues...'),
            error: (e, s) => _buildErrorCard('Failed to load priority queues'),
          ),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// Two-column layout: Quick Actions + Audit Trail
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1200) {
                return Column(
                  children: [
                    _buildQuickActionsSection(context),
                    SizedBox(height: PharmaSpacing.sectionGap),
                    auditAsync.when(
                      data: (events) => _buildRecentAuditEventsSection(context, ref, events),
                      loading: () => _buildLoadingCard('Loading Audit Events...'),
                      error: (e, s) => _buildErrorCard('Failed to load audit events'),
                    ),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildQuickActionsSection(context)),
                    SizedBox(width: PharmaSpacing.sectionGap),
                    Expanded(
                      child: auditAsync.when(
                        data: (events) => _buildRecentAuditEventsSection(context, ref, events),
                        loading: () => _buildLoadingCard('Loading Audit Events...'),
                        error: (e, s) => _buildErrorCard('Failed to load audit events'),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// System Health Status
          _buildSystemHealthSection(context, ref),
          SizedBox(height: PharmaSpacing.sectionGap),

          /// Compliance Trends Chart
          _buildComplianceTrendsSection(context, ref),
        ],
      ),
    );
  }

  /// Page header with title and filter
  Widget _buildPageHeader() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d, yyyy \'at\' h:mm a');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Admin Dashboard', style: PharmaTypography.displayLarge),
        SizedBox(height: PharmaSpacing.md),
        Text(
          'Last updated: ${formatter.format(now)}',
          style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary),
        ),
      ],
    );
  }

  /// Loading card helper
  Widget _buildLoadingCard(String message) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: PharmaSpacing.md),
            Text(message, style: PharmaTypography.body),
          ],
        ),
      ),
    );
  }
  
  /// Error card helper
  Widget _buildErrorCard(String message) {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        border: Border.all(color: PharmaColors.danger),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: PharmaColors.danger),
          SizedBox(width: PharmaSpacing.md),
          Expanded(child: Text(message, style: PharmaTypography.body)),
        ],
      ),
    );
  }

  /// KPI Metrics Loading State
  Widget _buildKpiMetricsLoading() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: PharmaSpacing.sectionGap,
      crossAxisSpacing: PharmaSpacing.sectionGap,
      childAspectRatio: 1.15,
      children: List.generate(4, (_) => _buildLoadingCard('Loading...')),
    );
  }

  /// KPI Metrics Error State
  Widget _buildKpiMetricsError(String error) {
    return _buildErrorCard('Failed to load KPI metrics: $error');
  }

  /// KPI Metrics Grid (with real data)
  Widget _buildKpiMetrics(BuildContext context, WidgetRef ref, AdminDashboardKpi kpi) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1200 ? 4 : (constraints.maxWidth > 768 ? 2 : 1);
        
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: PharmaSpacing.sectionGap,
          crossAxisSpacing: PharmaSpacing.sectionGap,
          childAspectRatio: 1.15,
          children: [
            _buildKpiCard(
              title: 'Total Users',
              value: _formatNumber(kpi.totalUsers),
              subtitle: 'Active organization users',
              change: kpi.totalUsers > 0 ? '+${kpi.totalUsers}' : '0',
              icon: Icons.people_outlined,
              color: PharmaColors.info,
              onTap: () => context.push('/admin/users'),
            ),
            _buildKpiCard(
              title: 'Active Courses',
              value: _formatNumber(kpi.totalCourses),
              subtitle: '${kpi.pendingQaCount} pending approval',
              change: kpi.pendingQaCount > 0 ? '${kpi.pendingQaCount} pending' : 'All approved',
              icon: Icons.school_outlined,
              color: PharmaColors.emerald600,
              onTap: () => context.push('/admin/courses'),
            ),
            _buildKpiCard(
              title: 'Total Enrollments',
              value: _formatNumber(kpi.totalEnrollments),
              subtitle: '${kpi.overdueCount} overdue',
              change: kpi.overdueCount > 0 ? '-${kpi.overdueCount} overdue' : 'On track',
              icon: Icons.assignment_outlined,
              color: PharmaColors.warning,
              onTap: () => context.push('/admin/enrollments'),
            ),
            _buildKpiCard(
              title: 'Compliance Rate',
              value: '${kpi.complianceRate}%',
              subtitle: 'Organization-wide',
              change: kpi.complianceRate >= 90 ? '+${kpi.complianceRate}%' : '${kpi.complianceRate}%',
              icon: Icons.check_circle_outline,
              color: kpi.complianceRate >= 90 ? PharmaColors.success : PharmaColors.warning,
              onTap: () => context.push('/admin/compliance'),
            ),
          ],
        );
      },
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  /// Priority Queues Section (real data from providers)
  Widget _buildPriorityQueues(BuildContext context, List<PriorityQueueItem> queues) {
    if (queues.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.warningBg,
        border: Border.all(color: PharmaColors.warning),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: PharmaColors.warning, size: 24),
              SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⚠️ Priority Action Items',
                      style: PharmaTypography.bodyMedium.copyWith(
                        color: PharmaColors.warningText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: PharmaSpacing.xs),
                    Text(
                      queues.map((q) => '${q.count} ${q.name}').join(' · '),
                      style: PharmaTypography.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          Wrap(
            spacing: PharmaSpacing.md,
            runSpacing: PharmaSpacing.sm,
            children: queues.map((q) => _buildPriorityChip(context, q)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(BuildContext context, PriorityQueueItem queue) {
    return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: PharmaColors.warning,
        foregroundColor: Colors.white,
        radius: 12,
        child: Text('${queue.count}', style: const TextStyle(fontSize: 10)),
      ),
      label: Text('${queue.name} (SLA: ${queue.sla})'),
      onPressed: () => context.push(queue.route),
      backgroundColor: PharmaColors.cardBg,
      side: BorderSide(color: PharmaColors.borderLight),
    );
  }

  /// Individual KPI Card
  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required String change,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title, style: PharmaTypography.bodyMedium),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(PharmaRadius.sm),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: PharmaTypography.statNumber),
                SizedBox(height: PharmaSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(subtitle, style: PharmaTypography.caption),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: change.startsWith('+') 
                            ? PharmaColors.success.withOpacity(0.1)
                            : PharmaColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(PharmaRadius.sm),
                      ),
                      child: Text(
                        change,
                        style: PharmaTypography.caption.copyWith(
                          color: change.startsWith('+') 
                              ? PharmaColors.success 
                              : PharmaColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Quick Actions Section
  Widget _buildQuickActionsSection(BuildContext context) {
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
          Text('Quick Actions', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.sectionGap),
          _buildActionButton(
            context,
            icon: Icons.person_add_outlined,
            label: 'Create User',
            onTap: () => context.push('/admin/users/create'),
          ),
          _buildActionButton(
            context,
            icon: Icons.upload_file_outlined,
            label: 'Bulk Import Users',
            onTap: () => context.push('/admin/users/import'),
          ),
          _buildActionButton(
            context,
            icon: Icons.add_circle_outline,
            label: 'Create Course',
            onTap: () => context.push('/admin/courses/create'),
          ),
          _buildActionButton(
            context,
            icon: Icons.people_alt_outlined,
            label: 'Create Batch',
            onTap: () => context.push('/admin/batches/create'),
          ),
          _buildActionButton(
            context,
            icon: Icons.note_add_outlined,
            label: 'Create Assessment',
            onTap: () => context.push('/admin/assessments/create'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PharmaSpacing.md,
            vertical: PharmaSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(icon, color: PharmaColors.emerald600, size: 20),
              SizedBox(width: PharmaSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.emerald600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward, size: 14, color: PharmaColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }

  /// Recent Audit Events Section (with real data)
  Widget _buildRecentAuditEventsSection(BuildContext context, WidgetRef ref, List<AuditTrail> events) {
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
              Text('Recent Admin Actions', style: PharmaTypography.headingSmall),
              TextButton(
                onPressed: () => context.push('/admin/audit-trail'),
                child: const Text('View All'),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          if (events.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(PharmaSpacing.lg),
                child: Text(
                  'No recent audit events',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                ),
              ),
            )
          else
            ...events.take(5).expand((event) => [
              _buildAuditEventItem(
                icon: _getIconForAction(event.action),
                user: 'User #${event.userId}',
                action: '${event.action}: ${event.entityType} #${event.entityId}',
                timestamp: _formatTimestamp(event.timestamp),
                color: _getColorForAction(event.action),
              ),
              if (event != events.take(5).last)
                Divider(color: PharmaColors.borderLight, height: 16),
            ]),
        ],
      ),
    );
  }

  IconData _getIconForAction(String action) {
    switch (action.toLowerCase()) {
      case 'create':
      case 'created':
        return Icons.add_circle_outline;
      case 'update':
      case 'updated':
        return Icons.edit_outlined;
      case 'delete':
      case 'deleted':
        return Icons.delete_outline;
      case 'approve':
      case 'approved':
        return Icons.check_circle_outline;
      case 'login':
        return Icons.login;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.history;
    }
  }

  Color _getColorForAction(String action) {
    switch (action.toLowerCase()) {
      case 'create':
      case 'created':
        return PharmaColors.info;
      case 'update':
      case 'updated':
        return PharmaColors.warning;
      case 'delete':
      case 'deleted':
        return PharmaColors.danger;
      case 'approve':
      case 'approved':
        return PharmaColors.success;
      default:
        return PharmaColors.textTertiary;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(timestamp);
  }

  Widget _buildAuditEventItem({
    required IconData icon,
    required String user,
    required String action,
    required String timestamp,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PharmaSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: PharmaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user, style: PharmaTypography.bodyMedium),
                Text(
                  action,
                  style: PharmaTypography.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(timestamp, style: PharmaTypography.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// System Health Section
  Widget _buildSystemHealthSection(BuildContext context, WidgetRef ref) {
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
          Text('System Health & Infrastructure', style: PharmaTypography.headingSmall),
          SizedBox(height: PharmaSpacing.sectionGap),
          _buildHealthIndicator(
            name: 'PostgreSQL Database',
            status: 'Healthy',
            isHealthy: true,
          ),
          SizedBox(height: PharmaSpacing.md),
          _buildHealthIndicator(
            name: 'File Storage (S3)',
            status: 'Healthy',
            isHealthy: true,
          ),
          SizedBox(height: PharmaSpacing.md),
          _buildHealthIndicator(
            name: 'Email Service',
            status: 'Healthy',
            isHealthy: true,
          ),
          SizedBox(height: PharmaSpacing.md),
          _buildHealthIndicator(
            name: 'Kafka Event Bus',
            status: '2 topics with lag > 30s',
            isHealthy: false,
          ),
        ],
      ),
    );
  }

  Widget _buildHealthIndicator({
    required String name,
    required String status,
    required bool isHealthy,
  }) {
    return Row(
      children: [
        Icon(
          isHealthy ? Icons.check_circle : Icons.warning_amber_rounded,
          color: isHealthy ? PharmaColors.success : PharmaColors.warning,
          size: 18,
        ),
        SizedBox(width: PharmaSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: PharmaTypography.bodyMedium),
              Text(status, style: PharmaTypography.caption),
            ],
          ),
        ),
      ],
    );
  }

  /// Compliance Trends Section
  Widget _buildComplianceTrendsSection(BuildContext context, WidgetRef ref) {
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
              Text('Compliance Trends', style: PharmaTypography.headingSmall),
              TextButton(
                onPressed: () => context.push('/admin/compliance'),
                child: const Text('View Details'),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.sectionGap),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: PharmaColors.pageBg,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Center(
              child: Text(
                'Chart will display compliance trend over 90 days',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
