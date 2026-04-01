import '../../../core/client.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_page_frame.dart';
import '../widgets/admin_shared_widgets.dart';
import '../../../design_system/pharma_design_system.dart';
import '../../../providers/admin_providers_v2.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// STITCH "CLINICAL ARCHIVE" — ADMIN DASHBOARD V2
// ═══════════════════════════════════════════════════════════════════════════════
// All data wired to real backend via Riverpod providers.
// RenderFlex-safe: every widget uses bounded constraints.
// ═══════════════════════════════════════════════════════════════════════════════

class AdminDashboardScreenV2 extends ConsumerWidget {
  const AdminDashboardScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiAsync = ref.watch(adminDashboardKpiProvider);
    final queuesAsync = ref.watch(adminPriorityQueuesProvider);

    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ─── CRITICAL BANNER ─────────────────────────────────────────
          kpiAsync.when(
            data: (kpi) {
              if (kpi.overdueCount > 0) {
                return ClinicalCriticalBanner(
                  title: '${kpi.overdueCount} Overdue training assignments',
                  subtitle:
                      'Critical non-compliance detected in GxP-regulated modules. Immediate remediation required.',
                  actionLabel: 'Initiate review',
                  onAction: () {},
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── KPI GRID ────────────────────────────────────────────
                _KpiGridSection(),

                const SizedBox(height: 24),

                // ─── OVERDUE TABLE + SIDEBAR ─────────────────────────────
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1000) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _OverdueTrainingsTable()),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ESignatureReadinessSection(),
                                const SizedBox(height: 24),
                                _RecentAuditFeedSection(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _OverdueTrainingsTable(),
                        const SizedBox(height: 24),
                        _ESignatureReadinessSection(),
                        const SizedBox(height: 24),
                        _RecentAuditFeedSection(),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                // ─── PRIORITY QUEUES ─────────────────────────────────────
                AdminSectionCard(
                  title: 'Priority queues',
                  subtitle: 'Live administrative work queues across modules.',
                  child: queuesAsync.when(
                    data: (queues) {
                      if (queues.isEmpty) {
                        return Text('No pending queues.',
                            style: PharmaTypography.clinicalBody);
                      }
                      return AdminDataTable(
                        columns: const ['Queue', 'Count', 'SLA', 'Owner'],
                        rows: queues
                            .map((q) =>
                                [q.name, q.count.toString(), q.sla, q.owner])
                            .toList(),
                      );
                    },
                    loading: () => const SizedBox(
                      height: 60,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: PharmaColors.clinicalPrimary)),
                    ),
                    error: (_, __) => const Text('Failed to load queues'),
                  ),
                ),

                const SizedBox(height: 24),

                // ─── ACTIVE BATCHES ──────────────────────────────────────
                _ActiveBatchesSection(),

                const SizedBox(height: 24),

                // ─── PREDICTIVE RISK ─────────────────────────────────────
                _PredictiveRiskSection(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// KPI GRID
// ═══════════════════════════════════════════════════════════════════════════════

class _KpiGridSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpiAsync = ref.watch(adminDashboardKpiProvider);
    final healthAsync = ref.watch(adminSystemHealthProvider);

    return kpiAsync.when(
      data: (kpi) {
        final complianceColor = kpi.complianceRate < 90
            ? PharmaColors.clinicalTertiary
            : PharmaColors.clinicalSecondary;

        return LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isWide = w > 900;
            final isMedium = w > 600;
            double cardW;
            if (isWide) {
              cardW = (w - 48) / 4;
            } else if (isMedium) {
              cardW = (w - 16) / 2;
            } else {
              cardW = w;
            }

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: cardW,
                  child: ClinicalKpiCard(
                    label: 'Compliance status',
                    value: '${kpi.complianceRate}%',
                    icon: Icons.verified_user_outlined,
                    valueColor: complianceColor,
                    progress: kpi.complianceRate / 100,
                    progressColor: complianceColor,
                    changeLabel: kpi.complianceRate < 95
                        ? '-${95 - kpi.complianceRate}% vs target'
                        : null,
                    changeColor: PharmaColors.clinicalTertiary,
                    subtitle: 'Audit readiness threshold: 95%',
                  ),
                ),
                SizedBox(
                  width: cardW,
                  child: ClinicalKpiCard(
                    label: 'Total users',
                    value: kpi.totalUsers.toString(),
                    icon: Icons.people_alt_outlined,
                    subtitle: '${kpi.totalCourses} active courses',
                  ),
                ),
                SizedBox(
                  width: isWide ? cardW * 2 + 16 : w,
                  child: _SystemHealthMonitorCard(healthAsync: healthAsync),
                ),
              ],
            );
          },
        );
      },
      loading: () => const SizedBox(
        height: 140,
        child: Center(
            child: CircularProgressIndicator(
                color: PharmaColors.clinicalPrimary)),
      ),
      error: (_, __) => const Text('Failed to load KPIs'),
    );
  }
}

class _SystemHealthMonitorCard extends StatelessWidget {
  const _SystemHealthMonitorCard({required this.healthAsync});
  final AsyncValue<SystemHealthStatus> healthAsync;

  @override
  Widget build(BuildContext context) {
    return ClinicalTonalCard(
      borderBottom: PharmaColors.clinicalPrimaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SYSTEM HEALTH MONITOR', style: PharmaTypography.clinicalLabel),
          const SizedBox(height: 16),
          healthAsync.when(
            data: (h) => Row(
              children: [
                Expanded(
                  child: ClinicalHealthCell(
                    label: 'SCIM Sync',
                    value: h.scimSync,
                    icon: h.scimSync == 'Active'
                        ? Icons.check_circle_outline
                        : Icons.error_outline,
                    statusColor: h.scimSync == 'Active'
                        ? PharmaColors.clinicalSecondary
                        : PharmaColors.clinicalTertiary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClinicalHealthCell(
                    label: 'Kafka Lag',
                    value: h.kafkaLag,
                    icon: Icons.trending_flat,
                    statusColor: PharmaColors.clinicalSecondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClinicalHealthCell(
                    label: 'DB Status',
                    value: h.dbStatus,
                    icon: Icons.storage_outlined,
                    statusColor: h.dbStatus == 'Healthy'
                        ? PharmaColors.clinicalSecondary
                        : PharmaColors.clinicalTertiary,
                  ),
                ),
              ],
            ),
            loading: () => const SizedBox(
              height: 48,
              child: Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: PharmaColors.clinicalPrimary)),
            ),
            error: (_, __) => Row(
              children: [
                Expanded(
                  child: ClinicalHealthCell(
                      label: 'SCIM Sync',
                      value: 'Unknown',
                      icon: Icons.help_outline),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClinicalHealthCell(
                      label: 'Kafka Lag',
                      value: 'Unknown',
                      icon: Icons.help_outline),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClinicalHealthCell(
                      label: 'DB Status',
                      value: 'Unknown',
                      icon: Icons.help_outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// OVERDUE TRAININGS TABLE
// ═══════════════════════════════════════════════════════════════════════════════

class _OverdueTrainingsTable extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departmentsAsync = ref.watch(adminDepartmentsProvider);
    final usersAsync = ref.watch(adminUsersProvider);
    final kpiAsync = ref.watch(adminDashboardKpiProvider);

    return AdminSectionCard(
      title: 'Overdue trainings breakdown',
      trailing: kpiAsync.when(
        data: (kpi) => kpi.overdueCount > 0
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PharmaColors.clinicalTertiaryContainer
                      .withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.clinicalCardRadius,
                ),
                child: Text(
                  '${kpi.overdueCount} CRITICAL',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.clinicalTertiary,
                    letterSpacing: 1.5,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
      child: departmentsAsync.when(
        data: (departments) => usersAsync.when(
          data: (users) {
            if (departments.isEmpty || users.isEmpty) {
              return Text('No department or user data.',
                  style: PharmaTypography.clinicalBody);
            }
            return FutureBuilder<List<List<String>>>(
              future: _getOverdueByDepartmentRows(ref, departments, users),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 80,
                    child: Center(
                        child: CircularProgressIndicator(
                            color: PharmaColors.clinicalPrimary)),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'No overdue trainings detected — all departments compliant.',
                      style: PharmaTypography.clinicalBody,
                    ),
                  );
                }
                return AdminDataTable(
                  columns: const ['Department', 'Overdue count'],
                  rows: snapshot.data!,
                );
              },
            );
          },
          loading: () => const SizedBox(
            height: 60,
            child: Center(
                child: CircularProgressIndicator(
                    color: PharmaColors.clinicalPrimary)),
          ),
          error: (_, __) => const Text('Failed to load users'),
        ),
        loading: () => const SizedBox(
          height: 60,
          child: Center(
              child: CircularProgressIndicator(
                  color: PharmaColors.clinicalPrimary)),
        ),
        error: (_, __) => const Text('Failed to load departments'),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// E-SIGNATURE READINESS
// ═══════════════════════════════════════════════════════════════════════════════

class _ESignatureReadinessSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(adminDashboardKpiProvider).when(
          data: (kpi) => ClinicalESignatureWidget(
            pendingCount: kpi.pendingQaCount,
            onProcess: () {},
          ),
          loading: () => const SizedBox(
            height: 200,
            child: Center(
                child: CircularProgressIndicator(
                    color: PharmaColors.clinicalPrimary)),
          ),
          error: (_, __) => const Text('Failed to load e-signature data'),
        );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// RECENT AUDIT FEED
// ═══════════════════════════════════════════════════════════════════════════════

class _RecentAuditFeedSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditAsync = ref.watch(adminRecentAuditProvider);

    return ClinicalTonalCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RECENT AUDIT LOG', style: PharmaTypography.clinicalLabel),
          const SizedBox(height: 20),
          auditAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return Text('No recent audit events.',
                    style: PharmaTypography.clinicalBody);
              }
              return ClinicalAuditTimeline(
                events: events.take(5).map((e) {
                  Color dotColor;
                  IconData icon;
                  final a = e.action.toLowerCase();
                  if (a.contains('create') || a.contains('provision')) {
                    dotColor = PharmaColors.clinicalPrimary;
                    icon = Icons.person_add_alt;
                  } else if (a.contains('approve') ||
                      a.contains('sign') ||
                      a.contains('verify')) {
                    dotColor = PharmaColors.clinicalSecondary;
                    icon = Icons.done_all;
                  } else if (a.contains('delete') ||
                      a.contains('deactivate') ||
                      a.contains('reject')) {
                    dotColor = PharmaColors.clinicalTertiary;
                    icon = Icons.report_outlined;
                  } else {
                    dotColor = PharmaColors.clinicalPrimary;
                    icon = Icons.event_note;
                  }
                  return ClinicalTimelineEvent(
                    title: e.action,
                    subtitle:
                        '${e.entityType} | ${e.reason ?? 'System event'}',
                    timestamp: _fmtTs(e.timestamp),
                    icon: icon,
                    dotColor: dotColor,
                  );
                }).toList(),
              );
            },
            loading: () => const SizedBox(
              height: 120,
              child: Center(
                  child: CircularProgressIndicator(
                      color: PharmaColors.clinicalPrimary)),
            ),
            error: (_, __) => const Text('Failed to load audit feed'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACTIVE BATCHES
// ═══════════════════════════════════════════════════════════════════════════════

class _ActiveBatchesSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchStatsAsync = ref.watch(adminBatchStatsProvider);
    final batchesAsync = ref.watch(adminBatchesProvider);

    return AdminSectionCard(
      title: 'Active batches',
      subtitle:
          'Current and upcoming training batches across the organization.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          batchStatsAsync.when(
            data: (stats) => Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                _BatchStatChip(label: 'Total', value: stats.total),
                _BatchStatChip(label: 'Scheduled', value: stats.scheduled),
                _BatchStatChip(
                    label: 'In progress',
                    value: stats.inProgress,
                    color: PharmaColors.clinicalSecondary),
                _BatchStatChip(label: 'Completed', value: stats.completed),
                _BatchStatChip(
                    label: 'Cancelled',
                    value: stats.cancelled,
                    color: PharmaColors.clinicalTertiary),
              ],
            ),
            loading: () => const LinearProgressIndicator(
                color: PharmaColors.clinicalPrimary),
            error: (_, __) => const Text('Failed to load batch stats'),
          ),
          const SizedBox(height: 16),
          batchesAsync.when(
            data: (batches) {
              final active = batches
                  .where((b) =>
                      b.status == 'scheduled' || b.status == 'in_progress')
                  .toList();
              if (active.isEmpty) {
                return Text('No active batches.',
                    style: PharmaTypography.clinicalBody);
              }
              return AdminDataTable(
                columns: const [
                  'Batch',
                  'Status',
                  'Start',
                  'End',
                  'Location'
                ],
                rows: active
                    .map((b) => [
                          b.name,
                          b.status,
                          b.startDate.toString().split(' ').first,
                          b.endDate.toString().split(' ').first,
                          b.location ?? '-',
                        ])
                    .toList(),
              );
            },
            loading: () => const SizedBox(
              height: 60,
              child: Center(
                  child: CircularProgressIndicator(
                      color: PharmaColors.clinicalPrimary)),
            ),
            error: (_, __) => const Text('Failed to load batches'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PREDICTIVE RISK
// ═══════════════════════════════════════════════════════════════════════════════

class _PredictiveRiskSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        client.analytics.getCertificationExpiryRiskCount(),
        client.analytics.getAuditReadinessScore(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 120,
            child: Center(
                child: CircularProgressIndicator(
                    color: PharmaColors.clinicalPrimary)),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final certRisk = snapshot.data![0] as int;
        final readiness = snapshot.data![1] as AuditReadinessScore;
        return AdminSectionCard(
          title: 'Predictive risk',
          subtitle: 'Upcoming compliance risks and audit readiness.',
          child: LayoutBuilder(
            builder: (context, constraints) {
              final halfW = constraints.maxWidth > 600
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 24,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: halfW,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: PharmaColors.clinicalSurfaceContainerLow,
                        borderRadius: PharmaRadius.clinicalCardRadius,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CERTIFICATES EXPIRING SOON',
                              style: PharmaTypography.clinicalLabel),
                          const SizedBox(height: 8),
                          Text(
                            certRisk.toString(),
                            style: PharmaTypography.clinicalKpiValue.copyWith(
                              color: certRisk > 0
                                  ? PharmaColors.warning
                                  : PharmaColors.clinicalOnSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: halfW,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: PharmaColors.clinicalSurfaceContainerLow,
                        borderRadius: PharmaRadius.clinicalCardRadius,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AUDIT READINESS SCORE',
                              style: PharmaTypography.clinicalLabel),
                          const SizedBox(height: 8),
                          Text(
                            '${readiness.overallScore.toStringAsFixed(1)}%',
                            style: PharmaTypography.clinicalKpiValue.copyWith(
                              color: PharmaColors.clinicalSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

class _BatchStatChip extends StatelessWidget {
  const _BatchStatChip(
      {required this.label, required this.value, this.color});
  final String label;
  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: PharmaTypography.clinicalLabel),
        const SizedBox(height: 2),
        Text(
          value.toString(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color ?? PharmaColors.clinicalOnSurface,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATA HELPERS — Wired to real DB via providers
// ═══════════════════════════════════════════════════════════════════════════════

Future<List<List<String>>> _getOverdueByDepartmentRows(
  WidgetRef ref,
  List<dynamic> departments,
  List<dynamic> users,
) async {
  final rows = <List<String>>[];
  for (final dept in departments) {
    final deptUsers =
        users.where((u) => u.departmentId == dept.id).toList();
    int overdueCount = 0;
    for (final user in deptUsers) {
      try {
        final enrollments =
            await ref.read(adminUserEnrollmentsProvider(user.id!).future);
        overdueCount +=
            enrollments.where((e) => e.status == 'overdue').length;
      } catch (_) {}
    }
    if (overdueCount > 0) {
      rows.add([dept.name, overdueCount.toString()]);
    }
  }
  rows.sort((a, b) => int.parse(b[1]).compareTo(int.parse(a[1])));
  return rows;
}

String _fmtTs(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')} UTC';
}
