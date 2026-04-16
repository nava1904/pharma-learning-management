// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE COMPLIANCE DETAIL SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/compliance
// Shows personal compliance score, overdue breakdown, e-signature log,
// certificate expiry countdown, and gap analysis.
// Uses: AppColors/AppTypography from design_system/tokens.dart
// Backend: compliance.getUserCompliance, training.listElectronicSignatures
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../design_system/tokens.dart';
import '../../../design_system/components.dart';
import '../../../providers/employee_portal_providers.dart';
import '../../../providers/dashboard_providers.dart';

class EmployeeComplianceDetailScreen extends ConsumerWidget {
  const EmployeeComplianceDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complianceAsync = ref.watch(employeeComplianceDetailProvider);
    final overdueAsync = ref.watch(overdueEnrollmentsProvider);
    final dueSoonAsync = ref.watch(dueSoonEnrollmentsProvider);
    final certsAsync = ref.watch(certificatesProvider);
    final signaturesAsync = ref.watch(employeeSignaturesProvider);
    final pendingAckAsync = ref.watch(pendingAcknowledgementsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Compliance Status', style: AppTypography.display.copyWith(
            fontSize: 32, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Your personal 21 CFR Part 11 compliance overview',
            style: AppTypography.body.copyWith(color: AppColors.n500),
          ),
          const SizedBox(height: AppSpacing.s7),

          // ─── Compliance Score Card ───
          complianceAsync.when(
            loading: () => SkeletonLoader(height: 120, borderRadius: AppRadius.br3),
            error: (e, _) => _ErrorCard(message: 'Unable to load compliance data: $e'),
            data: (metrics) => _ComplianceScoreCard(metrics: metrics),
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Stats Row ───
          Row(
            children: [
              Expanded(child: overdueAsync.when(
                loading: () => const StatCardSkeleton(),
                error: (_, _) => _MiniStatCard(value: '—', label: 'Overdue', color: AppColors.danger),
                data: (list) => _MiniStatCard(
                  value: '${list.length}', label: 'Overdue', color: AppColors.danger,
                ),
              )),
              const SizedBox(width: AppSpacing.s4),
              Expanded(child: dueSoonAsync.when(
                loading: () => const StatCardSkeleton(),
                error: (_, _) => _MiniStatCard(value: '—', label: 'Due Soon', color: AppColors.warning),
                data: (list) => _MiniStatCard(
                  value: '${list.length}', label: 'Due This Month', color: AppColors.warning,
                ),
              )),
              const SizedBox(width: AppSpacing.s4),
              Expanded(child: pendingAckAsync.when(
                loading: () => const StatCardSkeleton(),
                error: (_, _) => _MiniStatCard(value: '—', label: 'Pending Ack', color: AppColors.teal),
                data: (list) => _MiniStatCard(
                  value: '${list.length}', label: 'Pending Ack', color: AppColors.teal,
                ),
              )),
              const SizedBox(width: AppSpacing.s4),
              Expanded(child: certsAsync.when(
                loading: () => const StatCardSkeleton(),
                error: (_, _) => _MiniStatCard(value: '—', label: 'Certificates', color: AppColors.blue),
                data: (list) => _MiniStatCard(
                  value: '${list.length}', label: 'Certificates', color: AppColors.blue,
                ),
              )),
            ],
          ),
          const SizedBox(height: AppSpacing.s7),

          // ─── Overdue Training Section ───
          overdueAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (overdue) {
              if (overdue.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 20),
                      const SizedBox(width: AppSpacing.s2),
                      Text('Overdue Training', style: AppTypography.headline.copyWith(
                        fontSize: 18, color: AppColors.danger,
                      )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  ...overdue.map((e) => _EnrollmentRow(
                    enrollment: e,
                    statusColor: AppColors.danger,
                    onTap: () => context.go('/employee/course/${e.courseVersion?.course?.id ?? e.courseVersionId}', extra: {
                      'courseVersionId': e.courseVersionId.toString(),
                      'enrollmentId': e.id?.toString(),
                    }),
                  )),
                  const SizedBox(height: AppSpacing.s6),
                ],
              );
            },
          ),

          // ─── Certificate Expiry Countdown ───
          certsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (certs) {
              final expiring = certs.where((c) =>
                  c.expiresAt != null &&
                  c.expiresAt!.isAfter(DateTime.now()) &&
                  c.expiresAt!.isBefore(DateTime.now().add(const Duration(days: 90)))).toList();
              if (expiring.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: AppColors.warning, size: 20),
                      const SizedBox(width: AppSpacing.s2),
                      Text('Expiring Certifications', style: AppTypography.headline.copyWith(
                        fontSize: 18, color: AppColors.warning,
                      )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  ...expiring.map((c) {
                    final daysLeft = c.expiresAt!.difference(DateTime.now()).inDays;
                    return _CertExpiryRow(
                      title: c.courseVersion?.course?.title ?? 'Certificate',
                      expiresAt: c.expiresAt!,
                      daysLeft: daysLeft,
                    );
                  }),
                  const SizedBox(height: AppSpacing.s6),
                ],
              );
            },
          ),

          // ─── E-Signature Audit Log ───
          Text('E-Signature Log', style: AppTypography.headline.copyWith(fontSize: 18)),
          const SizedBox(height: AppSpacing.s4),
          signaturesAsync.when(
            loading: () => SkeletonLoader(height: 200, borderRadius: AppRadius.br2),
            error: (e, _) => _ErrorCard(message: 'Unable to load signatures: $e'),
            data: (signatures) {
              if (signatures.isEmpty) {
                return AppEmptyState(
                  icon: Icons.draw_outlined,
                  title: 'No Electronic Signatures',
                  description: 'E-signatures will appear here after you complete training or acknowledge SOPs.',
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.n0,
                  borderRadius: AppRadius.br2,
                  boxShadow: AppShadows.sh1,
                ),
                child: Column(
                  children: signatures.take(10).map((sig) => _SignatureRow(signature: sig)).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ────────────────────────────────────────────────────────────

class _ComplianceScoreCard extends StatelessWidget {
  const _ComplianceScoreCard({this.metrics});
  final dynamic metrics;

  @override
  Widget build(BuildContext context) {
    final rate = (metrics?.complianceRate as num?)?.toDouble() ?? 0;
    final isCompliant = rate >= 80;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCompliant
              ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
              : [AppColors.dangerDark, AppColors.danger],
        ),
        borderRadius: AppRadius.br3,
        boxShadow: AppShadows.sh2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCompliant ? 'Compliant' : 'Action Required',
                  style: AppTypography.headline.copyWith(
                    color: AppColors.n0,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: AppSpacing.s2),
                Text(
                  isCompliant
                      ? 'All training requirements are on track'
                      : 'You have overdue or incomplete required training',
                  style: AppTypography.body.copyWith(color: AppColors.n300),
                ),
                const SizedBox(height: AppSpacing.s4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3, vertical: AppSpacing.s1),
                  decoration: BoxDecoration(
                    color: AppColors.n0.withValues(alpha: 0.15),
                    borderRadius: AppRadius.br5,
                  ),
                  child: Text(
                    'Compliance threshold: ≥80%',
                    style: AppTypography.caption.copyWith(color: AppColors.n200),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s6),
          SizedBox(
            width: 100,
            height: 100,
            child: ProgressRing(
              percent: rate / 100,
              size: 100,
              strokeWidth: 8,
              color: isCompliant ? AppColors.success : AppColors.danger,
              backgroundColor: AppColors.n0.withValues(alpha: 0.2),
              label: '${rate.toInt()}%',
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({required this.value, required this.label, required this.color});
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        boxShadow: AppShadows.sh1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTypography.headline.copyWith(
            fontSize: 28, fontWeight: FontWeight.w700, color: color,
          )),
          const SizedBox(height: AppSpacing.s1),
          Text(label, style: AppTypography.caption.copyWith(color: AppColors.n500)),
        ],
      ),
    );
  }
}

class _EnrollmentRow extends StatelessWidget {
  const _EnrollmentRow({required this.enrollment, required this.statusColor, this.onTap});
  final dynamic enrollment;
  final Color statusColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final course = enrollment.courseVersion?.course;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Material(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        child: InkWell(
          borderRadius: AppRadius.br2,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: BoxDecoration(
              borderRadius: AppRadius.br2,
              border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              boxShadow: AppShadows.sh1,
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: AppRadius.br5,
                  ),
                ),
                const SizedBox(width: AppSpacing.s4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course?.title ?? 'Training',
                        style: AppTypography.title.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: AppSpacing.s1),
                      Text(
                        course?.sopNumber ?? '',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.n400,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.n400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CertExpiryRow extends StatelessWidget {
  const _CertExpiryRow({required this.title, required this.expiresAt, required this.daysLeft});
  final String title;
  final DateTime expiresAt;
  final int daysLeft;

  @override
  Widget build(BuildContext context) {
    final urgency = daysLeft <= 30 ? AppColors.danger : AppColors.warning;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: AppColors.n0,
          borderRadius: AppRadius.br2,
          border: Border.all(color: urgency.withValues(alpha: 0.3)),
          boxShadow: AppShadows.sh1,
        ),
        child: Row(
          children: [
            Icon(Icons.workspace_premium_outlined, color: urgency, size: 20),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.title.copyWith(fontSize: 15)),
                  Text('Expires ${DateFormat('MMM d, yyyy').format(expiresAt)}',
                      style: AppTypography.caption.copyWith(color: AppColors.n500)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3, vertical: AppSpacing.s1),
              decoration: BoxDecoration(
                color: urgency.withValues(alpha: 0.1),
                borderRadius: AppRadius.br5,
              ),
              child: Text(
                '$daysLeft days',
                style: AppTypography.caption.copyWith(
                  color: urgency,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignatureRow extends StatelessWidget {
  const _SignatureRow({required this.signature});
  final dynamic signature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.n200)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_outlined, color: AppColors.success, size: 18),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signature.signatureMeaning ?? 'E-Signature',
                  style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  signature.timestamp != null
                      ? DateFormat('MMM d, yyyy HH:mm').format(signature.timestamp!)
                      : '',
                  style: AppTypography.caption.copyWith(color: AppColors.n400, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Text(
            signature.entityType ?? '',
            style: AppTypography.caption.copyWith(color: AppColors.n400),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.dangerLight,
        borderRadius: AppRadius.br2,
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.danger, size: 20),
          const SizedBox(width: AppSpacing.s3),
          Expanded(child: Text(message, style: AppTypography.body.copyWith(color: AppColors.danger))),
        ],
      ),
    );
  }
}
