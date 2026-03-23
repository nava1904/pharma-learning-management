// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINER REPORTS HUB
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/reports
// Single place to access and export trainer reports: learner progress,
// compliance, analytics, audit log.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

class TrainerReportsScreen extends ConsumerStatefulWidget {
  const TrainerReportsScreen({super.key});

  @override
  ConsumerState<TrainerReportsScreen> createState() =>
      _TrainerReportsScreenState();
}

class _TrainerReportsScreenState extends ConsumerState<TrainerReportsScreen> {
  bool _exportingLearnerProgress = false;
  bool _exportingAudit = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: PharmaColors.emerald600, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reports',
                    style: PharmaTypography.headingLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Access and export compliance, progress, and audit reports',
                    style: PharmaTypography.body
                        .copyWith(color: PharmaColors.textTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _ReportCard(
          icon: Icons.people_outlined,
          title: 'Learner Progress',
          subtitle: 'Per-learner training history, compliance status, certifications',
          onOpen: () => context.go('/trainer/reports/learner-progress'),
          onExport: _exportLearnerProgressCsv,
          exportLabel: 'Export CSV',
          exporting: _exportingLearnerProgress,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.shield_outlined,
          title: 'Compliance',
          subtitle: 'Department and role compliance rates, overdue training',
          onOpen: () => context.go('/trainer/compliance'),
          exportLabel: null,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.analytics_outlined,
          title: 'Analytics',
          subtitle: 'Course analytics, completion rates, score distribution',
          onOpen: () => context.go('/trainer/analytics'),
          exportLabel: null,
        ),
        const SizedBox(height: 12),
        _ReportCard(
          icon: Icons.history_outlined,
          title: 'Audit Log',
          subtitle: 'Immutable audit trail — 21 CFR Part 11 compliant',
          onOpen: () => context.go('/trainer/audit-log'),
          onExport: _exportAuditCsv,
          exportLabel: 'Export CSV',
          exporting: _exportingAudit,
        ),
      ],
    );
  }

  Future<void> _exportLearnerProgressCsv() async {
    setState(() => _exportingLearnerProgress = true);
    try {
      final user = await ref.read(currentUserProvider.future);
      final csv = await client.analytics.exportLearnerProgressCsv(
        organizationId: user?.organizationId,
      );
      if (!mounted) return;
      await Clipboard.setData(ClipboardData(text: csv));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Learner progress CSV copied to clipboard')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingLearnerProgress = false);
    }
  }

  Future<void> _exportAuditCsv() async {
    setState(() => _exportingAudit = true);
    try {
      final csv = await client.audit.exportAuditCsv(
        from: DateTime.now().subtract(const Duration(days: 30)),
        to: DateTime.now(),
        limit: 1000,
      );
      if (!mounted) return;
      await Clipboard.setData(ClipboardData(text: csv));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audit log CSV copied to clipboard')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingAudit = false);
    }
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onOpen,
    this.onExport,
    this.exportLabel,
    this.exporting = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onOpen;
  final VoidCallback? onExport;
  final String? exportLabel;
  final bool exporting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: PharmaColors.emerald50,
              borderRadius: BorderRadius.circular(PharmaRadius.sm),
            ),
            child: Icon(icon, size: 24, color: PharmaColors.emerald600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: PharmaTypography.caption
                      .copyWith(color: PharmaColors.textTertiary),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: onOpen,
            style: FilledButton.styleFrom(
              backgroundColor: PharmaColors.emerald600,
              foregroundColor: PharmaColors.cardBg,
            ),
            child: const Text('Open'),
          ),
          if (exportLabel != null && onExport != null) ...[
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: exporting ? null : onExport,
              child: exporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(exportLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
