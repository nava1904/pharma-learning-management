import '../../../core/client.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import '../../../widgets/audit_timeline.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_page_frame.dart';
import '../../../design_system/pharma_components.dart';
import '../../../providers/admin_providers_v2.dart';
import '../../../widgets/compliance_gauge.dart';

// Helper to aggregate overdue enrollments by department
Future<List<List<String>>> getOverdueByDepartmentRows(
  WidgetRef ref,
  List<dynamic> departments,
  List<dynamic> users,
) async {
  List<List<String>> rows = [];
  for (final dept in departments) {
    final deptUsers = users.where((u) => u.departmentId == dept.id).toList();
    int overdueCount = 0;
    for (final user in deptUsers) {
      final enrollments = await ref.read(adminUserEnrollmentsProvider(user.id!).future);
      overdueCount += enrollments.where((e) => e.status == 'overdue').length;
    }
    rows.add([dept.name, overdueCount.toString()]);
  }
  // Sort descending by overdue count
  rows.sort((a, b) => int.parse(b[1]).compareTo(int.parse(a[1])));
  return rows;
}

// Helper widget for batch stats
class BatchStatWidget extends StatelessWidget {
  final String label;
  final int value;
  const BatchStatWidget({required this.label, required this.value, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey[600])),
          Text(value.toString(), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AdminDashboardScreenV2 extends ConsumerWidget {
  const AdminDashboardScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiAsync = ref.watch(adminDashboardKpiProvider);
    final queuesAsync = ref.watch(adminPriorityQueuesProvider);

    return AdminPageFrame(
      title: 'Admin Dashboard',
      subtitle: 'Compliance overview, pending approvals, and operational health.',
      actions: const [
        PharmaButton(
          onPressed: null,
          variant: PharmaButtonVariant.outline,
          child: Text('Export PDF'),
        ),
      ],
      children: [
        kpiAsync.when(
          data: (kpi) => AdminKpiRow(
            items: [
              (label: 'Total Users', value: kpi.totalUsers.toString(), icon: Icons.people_alt_outlined),
              (label: 'Compliance', value: '${kpi.complianceRate}%', icon: Icons.verified_outlined),
              (label: 'Pending QA', value: kpi.pendingQaCount.toString(), icon: Icons.pending_actions_outlined),
              (label: 'Overdue', value: kpi.overdueCount.toString(), icon: Icons.warning_amber_outlined),
            ],
          ),
          loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
          error: (_, __) => const Text('Failed to load KPIs'),
        ),
        const SizedBox(height: 16),
        AdminSectionCard(
          title: 'Priority Queues',
          subtitle: 'Live administrative work queues across modules.',
          child: queuesAsync.when(
            data: (queues) => AdminDataTable(
              columns: ['Queue', 'Count', 'SLA', 'Owner'],
              rows: queues
                  .map((q) => [q.name, q.count.toString(), q.sla, q.owner])
                  .toList(),
            ),
            loading: () => const SizedBox(height: 60, child: Center(child: CircularProgressIndicator())),
            error: (_, __) => const Text('Failed to load queues'),
          ),
        ),
        const SizedBox(height: 16),
        // --- Active Batches Section ---
        Consumer(
          builder: (context, ref, _) {
            final batchStatsAsync = ref.watch(adminBatchStatsProvider);
            final batchesAsync = ref.watch(adminBatchesProvider);
            return AdminSectionCard(
              title: 'Active Batches',
              subtitle: 'Current and upcoming training batches across the organization.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  batchStatsAsync.when(
                    data: (stats) => Row(
                      children: [
                        BatchStatWidget(label: 'Total', value: stats.total),
                        BatchStatWidget(label: 'Scheduled', value: stats.scheduled),
                        BatchStatWidget(label: 'In Progress', value: stats.inProgress),
                        BatchStatWidget(label: 'Completed', value: stats.completed),
                        BatchStatWidget(label: 'Cancelled', value: stats.cancelled),
                      ],
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) => const Text('Failed to load batch stats'),
                  ),
                  const SizedBox(height: 12),
                  batchesAsync.when(
                    data: (batches) => batches.isEmpty
                        ? const Text('No active batches.')
                        : AdminDataTable(
                            columns: ['Batch', 'Status', 'Start', 'End', 'Location'],
                            rows: batches
                                .where((b) => b.status == 'scheduled' || b.status == 'in_progress')
                                .map((b) => [
                                      b.name,
                                      b.status,
                                      b.startDate.toString().split(' ').first,
                                      b.endDate.toString().split(' ').first,
                                      b.location ?? '-',
                                    ])
                                .toList(),
                          ),
                    loading: () => const SizedBox(height: 40, child: Center(child: CircularProgressIndicator())),
                    error: (_, __) => const Text('Failed to load batches'),
                  ),
                ],
              ),
            );
          },
        ),
        // --- End Active Batches Section ---
        const SizedBox(height: 16),
        // --- Overdue by Department Section ---
        Consumer(
          builder: (context, ref, _) {
            final departmentsAsync = ref.watch(adminDepartmentsProvider);
            final usersAsync = ref.watch(adminUsersProvider);
            return AdminSectionCard(
              title: 'Overdue by Department',
              subtitle: 'Departments with the most overdue enrollments.',
              child: departmentsAsync.when(
                data: (departments) => usersAsync.when(
                  data: (users) {
                    if (departments.isEmpty || users.isEmpty) {
                      return const Text('No department or user data.');
                    }
                    return FutureBuilder<List<List<String>>>(
                      future: getOverdueByDepartmentRows(ref, departments, users),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox(height: 40, child: Center(child: CircularProgressIndicator()));
                        }
                        if (!snapshot.hasData) {
                          return const Text('No overdue data.');
                        }
                        return AdminDataTable(
                          columns: ['Department', 'Overdue Enrollments'],
                          rows: snapshot.data!,
                        );
                      },
                    );
                  },
                  loading: () => const SizedBox(height: 40, child: Center(child: CircularProgressIndicator())),
                  error: (_, __) => const Text('Failed to load users'),
                ),
                loading: () => const SizedBox(height: 40, child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const Text('Failed to load departments'),
              ),
            );
          },
        ),
        // --- End Overdue by Department Section ---
        const SizedBox(height: 16),
        // --- Compliance Score Section ---
        Consumer(
          builder: (context, ref, _) {
            final kpiAsync = ref.watch(adminDashboardKpiProvider);
            return AdminSectionCard(
              title: 'Compliance Score',
              subtitle: 'Current overall compliance rate across the organization.',
              child: kpiAsync.when(
                data: (kpi) => Center(
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: ComplianceGauge(
                      percentage: kpi.complianceRate.toDouble(),
                      label: 'Compliance',
                    ),
                  ),
                ),
                loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const Text('Failed to load compliance score'),
              ),
            );
          },
        ),
        // --- End Compliance Score Section ---
        const SizedBox(height: 16),
        // --- Live Audit Feed Section ---
        Consumer(
          builder: (context, ref, _) {
            final auditAsync = ref.watch(adminRecentAuditProvider);
            return AdminSectionCard(
              title: 'Live Audit Feed',
              subtitle: 'Recent system and compliance events.',
              child: auditAsync.when(
                data: (events) => events.isEmpty
                    ? const Text('No recent audit events.')
                    : SizedBox(
                        height: 320,
                        child: AuditTimeline(
                          events: events.map((e) => AuditTimelineEvent(
                            timestamp: e.timestamp,
                            title: e.action,
                            subtitle: e.entityType,
                            detail: e.reason,
                            icon: Icons.event_note,
                            type: AuditEventType.info,
                          )).toList(),
                        ),
                      ),
                loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const Text('Failed to load audit feed'),
              ),
            );
          },
        ),
        // --- End Live Audit Feed Section ---
        const SizedBox(height: 16),
        // --- Predictive Risk Section ---
        Consumer(
          builder: (context, ref, _) {
            // Use the analytics client directly for risk and readiness
            return FutureBuilder<List<dynamic>>(
              future: Future.wait([
                client.analytics.getCertificationExpiryRiskCount(),
                client.analytics.getAuditReadinessScore(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No predictive risk data.');
                }
                final certRisk = snapshot.data![0] as int;
                final AuditReadinessScore readiness = snapshot.data![1] as AuditReadinessScore;
                return AdminSectionCard(
                  title: 'Predictive Risk',
                  subtitle: 'Upcoming compliance risks and audit readiness.',
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Certificates Expiring Soon', style: Theme.of(context).textTheme.labelMedium),
                            const SizedBox(height: 8),
                            Text('$certRisk', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Audit Readiness Score', style: Theme.of(context).textTheme.labelMedium),
                            const SizedBox(height: 8),
                            Text('${readiness.overallScore.toStringAsFixed(1)}%', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.teal, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        // --- End Predictive Risk Section ---
// Helper to aggregate overdue enrollments by department
      ],
    );
  }
}
