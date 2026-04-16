import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';
import '../widgets/admin_page_scaffold.dart';

class AdminComplianceReportDashboardScreen extends ConsumerWidget {
  const AdminComplianceReportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(adminDepartmentComplianceSummaryProvider);

    return AdminPageFrame(
      title: 'Compliance Overview',
      subtitle: 'Department compliance summary and CSV exports.',
      children: [
        AdminSectionCard(
          title: 'By department',
          child: rows.when(
            loading: () => const AdminPageLoading(cardCount: 3),
            error: (e, _) => Text('$e'),
            data: (list) {
              if (list.isEmpty) {
                return Text('No summary rows.', style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary));
              }
              return AdminDataTable(
                columns: const ['Department', 'Employees', 'Compliant', 'Overdue', 'Upcoming', 'Rate %'],
                rows: list
                    .map(
                      (r) => [
                        r.departmentName ?? '${r.departmentId ?? ""}',
                        '${r.totalEmployees}',
                        '${r.compliant}',
                        '${r.overdue}',
                        '${r.upcoming}',
                        r.complianceRate.toStringAsFixed(1),
                      ],
                    )
                    .toList(),
              );
            },
          ),
        ),
        AdminSectionCard(
          title: 'Exports',
          child: Wrap(
            spacing: PharmaSpacing.sm,
            runSpacing: PharmaSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () async {
                  final user = await ref.read(currentUserProvider.future);
                  final csv = await client.analytics.exportCompletionMatrixCsv(
                    organizationId: user?.organizationId,
                  );
                  await saveBytesToFile(Uint8List.fromList(utf8.encode(csv)), 'completion_matrix.csv');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved completion matrix CSV')));
                  }
                },
                child: const Text('Completion matrix CSV'),
              ),
              OutlinedButton(
                onPressed: () async {
                  final user = await ref.read(currentUserProvider.future);
                  final csv = await client.analytics.exportLearnerProgressCsv(organizationId: user?.organizationId);
                  await saveBytesToFile(Uint8List.fromList(utf8.encode(csv)), 'learner_progress.csv');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved learner progress CSV')));
                  }
                },
                child: const Text('Learner progress CSV'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminGapReportScreen extends ConsumerWidget {
  const AdminGapReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(adminDepartmentComplianceSummaryProvider);

    return AdminPageFrame(
      title: 'Gap Report',
      subtitle: 'Departments with overdue and upcoming training volume.',
      children: [
        AdminSectionCard(
          title: 'Gaps by department',
          child: summary.when(
            loading: () => const AdminPageLoading(cardCount: 3),
            error: (e, _) => Text('$e'),
            data: (list) {
              final sorted = [...list]..sort((a, b) => b.overdue.compareTo(a.overdue));
              return AdminDataTable(
                columns: const ['Department', 'Overdue', 'Upcoming', 'Compliance %'],
                rows: sorted
                    .map(
                      (r) => [
                        r.departmentName ?? '${r.departmentId ?? ""}',
                        '${r.overdue}',
                        '${r.upcoming}',
                        r.complianceRate.toStringAsFixed(1),
                      ],
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AdminRegulatoryReportScreen extends ConsumerStatefulWidget {
  const AdminRegulatoryReportScreen({super.key});

  @override
  ConsumerState<AdminRegulatoryReportScreen> createState() => _AdminRegulatoryReportScreenState();
}

class _AdminRegulatoryReportScreenState extends ConsumerState<AdminRegulatoryReportScreen> {
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Regulatory Reports',
      subtitle: 'Inspection-oriented audit trail export (CSV, integrity logged server-side).',
      children: [
        AdminSectionCard(
          title: 'Audit trail export',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exports recent audit events for the organization session scope. Use Audit module for filters.',
                style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
              ),
              SizedBox(height: PharmaSpacing.md),
              FilledButton.icon(
                onPressed: _exporting
                    ? null
                    : () async {
                        setState(() => _exporting = true);
                        try {
                          final csv = await client.audit.exportAuditCsv(limit: 10_000);
                          await saveBytesToFile(
                            Uint8List.fromList(utf8.encode(csv)),
                            'audit_trail_export.csv',
                          );
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Audit CSV saved')));
                        } finally {
                          if (mounted) setState(() => _exporting = false);
                        }
                      },
                icon: _exporting
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.file_download_outlined),
                label: Text(_exporting ? 'Exporting…' : 'Download audit CSV'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminScheduledReportScreen extends ConsumerWidget {
  const AdminScheduledReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defs = ref.watch(adminReportDefinitionsProvider);

    return AdminPageFrame(
      title: 'Scheduled Reports',
      subtitle: 'Registered report definitions (scheduling managed by analytics jobs).',
      children: [
        AdminSectionCard(
          title: 'Report definitions',
          child: defs.when(
            loading: () => const AdminPageLoading(cardCount: 3),
            error: (e, _) => Text('$e'),
            data: (list) {
              if (list.isEmpty) {
                return Text(
                  'No report definitions configured.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                );
              }
              return AdminDataTable(
                columns: const ['Name', 'Type', 'Params'],
                rows: list
                    .map((r) => [r.name, r.reportType, r.paramsJson ?? '—'])
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
