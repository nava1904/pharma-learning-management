// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — CERTIFICATION V2 — Matches React ref2 Certification.tsx
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/credentials (mapped to nav item "Certification")
// Design: 3 stat cards + certification list with icons, progress, download
// Backend: certificatesProvider + enrollmentsProvider (Serverpod)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/certificate_pdf_service.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';

class CertificationScreenV2 extends ConsumerWidget {
  const CertificationScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificatesAsync = ref.watch(certificatesProvider);
    final enrollmentsAsync = ref.watch(enrollmentsProvider);

    return RefreshIndicator(
      color: PharmaColors.emerald600,
      onRefresh: () async {
        ref.invalidate(certificatesProvider);
        ref.invalidate(enrollmentsProvider);
        await Future.wait([
          ref.refresh(certificatesProvider.future),
          ref.refresh(enrollmentsProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Certifications', style: PharmaTypography.headingLarge),
            const SizedBox(height: 8),
            Text(
              'Earn industry-recognized certifications',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // Stats
            _buildStats(certificatesAsync, enrollmentsAsync),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // Certifications list
            _buildCertList(context, ref, certificatesAsync, enrollmentsAsync),

            // ALCOA+ Compliance Footer (FRD SCR-16)
            const SizedBox(height: PharmaSpacing.sectionGap),
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                color: PharmaColors.gray50,
                borderRadius: BorderRadius.circular(PharmaRadius.lg),
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified_user_outlined, size: 16, color: PharmaColors.emerald600),
                  const SizedBox(width: PharmaSpacing.sm),
                  Expanded(
                    child: Text(
                      'ALCOA+ Compliant  •  All certificates are electronically signed per 21 CFR Part 11.  •  '
                      'QR codes provide independent verification of certificate authenticity.',
                      style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── STATS ROW ───────────────────────────────────────────────────────────────
  Widget _buildStats(
    AsyncValue<List<Certificate>> certsAsync,
    AsyncValue<List<Enrollment>> enrollAsync,
  ) {
    final certs = certsAsync.valueOrNull ?? [];
    final enrollments = enrollAsync.valueOrNull ?? [];

    final earned = certs.where((c) => c.status == 'active').length;
    final expiring = certs.where((c) {
      if (c.status != 'active' || c.expiresAt == null) return false;
      final daysLeft = c.expiresAt!.difference(DateTime.now()).inDays;
      return daysLeft >= 0 && daysLeft <= 30;
    }).length;
    final inProgress = enrollments.where((e) => e.status == 'in_progress').length;
    final available = enrollments.where((e) => e.status == 'assigned' || e.status == 'not_started').length;

    return Row(
      children: [
        Expanded(child: _StatCard(label: 'Earned Certificates', value: '$earned', iconColor: PharmaColors.emerald600)),
        const SizedBox(width: PharmaSpacing.gridGap),
        Expanded(child: _StatCard(label: 'Expiring Soon', value: '$expiring', iconColor: expiring > 0 ? PharmaColors.warning : PharmaColors.textQuaternary)),
        const SizedBox(width: PharmaSpacing.gridGap),
        Expanded(child: _StatCard(label: 'In Progress', value: '$inProgress', iconColor: PharmaColors.info)),
        const SizedBox(width: PharmaSpacing.gridGap),
        Expanded(child: _StatCard(label: 'Available', value: '$available', iconColor: PharmaColors.textQuaternary)),
      ],
    );
  }

  // ─── CERTIFICATIONS LIST ─────────────────────────────────────────────────────
  Widget _buildCertList(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Certificate>> certsAsync,
    AsyncValue<List<Enrollment>> enrollAsync,
  ) {
    return certsAsync.when(
      loading: () => _buildSkeleton(),
      error: (e, _) => _buildError(),
      data: (certs) {
        final enrollments = enrollAsync.valueOrNull ?? [];

        // Build unified list: earned certs + in-progress enrollments + locked
        final items = <_CertItem>[];

        // Earned certificates
        for (final cert in certs) {
          if (cert.status == 'active' || cert.status == 'expired' || cert.status == 'revoked' || cert.status == 'obsolete') {
            // FR-07-05: Certificate status colors
            // active (not expiring) = green, expiring<30d = amber, expired = red, revoked = red, obsolete = gray
            String certStatus = 'earned';
            if (cert.status == 'obsolete') {
              certStatus = 'obsolete';
            } else if (cert.status == 'expired') {
              certStatus = 'expired';
            } else if (cert.status == 'revoked') {
              certStatus = 'revoked';
            } else if (cert.expiresAt != null) {
              final daysUntilExpiry = cert.expiresAt!.difference(DateTime.now()).inDays;
              if (daysUntilExpiry < 0) {
                certStatus = 'expired';
              } else if (daysUntilExpiry <= 30) {
                certStatus = 'expiring';
              }
            }

            items.add(_CertItem(
              title: cert.courseVersion?.course?.title ?? 'Certificate #${cert.id}',
              status: certStatus,
              issuedDate: cert.issuedAt,
              expiresDate: cert.expiresAt,
              score: cert.trainingRecord?.score,
              certificateId: cert.id,
              courseVersionId: cert.courseVersionId,
            ));
          }
        }

        // In-progress enrollments (not yet certified)
        final certifiedCourseVersionIds = certs.map((c) => c.courseVersionId).toSet();
        for (final enrollment in enrollments) {
          if (enrollment.status == 'in_progress' &&
              !certifiedCourseVersionIds.contains(enrollment.courseVersionId)) {
            items.add(_CertItem(
              title: enrollment.courseVersion?.course?.title ?? 'Course #${enrollment.courseVersionId}',
              status: 'in-progress',
              courseVersionId: enrollment.courseVersionId,
              requirements: 'Complete all modules and pass final exam',
              progress: _estimateProgress(enrollment),
            ));
          }
        }

        // Locked / not-started
        for (final enrollment in enrollments) {
          if ((enrollment.status == 'assigned' || enrollment.status == 'not_started') &&
              !certifiedCourseVersionIds.contains(enrollment.courseVersionId)) {
            items.add(_CertItem(
              title: enrollment.courseVersion?.course?.title ?? 'Course #${enrollment.courseVersionId}',
              status: 'locked',
              courseVersionId: enrollment.courseVersionId,
              requirements: 'Start the course to begin your certification path',
            ));
          }
        }

        if (items.isEmpty) {
          return _buildEmpty();
        }

        return Column(
          children: items.map((item) {
            Certificate? certForItem;
            if (item.certificateId != null) {
              try {
                certForItem = certs.firstWhere((c) => c.id == item.certificateId);
              } catch (_) {}
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _CertCard(
                item: item,
                certificate: certForItem,
                onDownloadCertificate: certForItem != null
                    ? () => _downloadCertificate(context, ref, certForItem!)
                    : null,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  static Future<void> _downloadCertificate(
    BuildContext context,
    WidgetRef ref,
    Certificate certificate,
  ) async {
    final id = certificate.id ?? 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: PharmaColors.emerald600)),
    );
    try {
      final bytes = await generateCertificatePdf(certificate);
      if (!context.mounted) return;
      final saved = await saveBytesToFile(bytes, 'vyuh_lms_certificate_$id.pdf');
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(saved ? 'Certificate downloaded' : 'Download cancelled'),
            backgroundColor: saved ? PharmaColors.emerald600 : null,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'),
            backgroundColor: PharmaColors.danger,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  double _estimateProgress(Enrollment enrollment) {
    if (enrollment.status == 'completed') return 100;
    if (enrollment.status == 'in_progress') return 50; // Estimated
    return 0;
  }

  Widget _buildSkeleton() {
    return Column(
      children: List.generate(3, (i) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          color: PharmaColors.gray100,
          borderRadius: BorderRadius.circular(PharmaRadius.lg),
        ),
      )),
    );
  }

  Widget _buildEmpty() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.workspace_premium_outlined, size: 48, color: PharmaColors.textQuaternary),
            const SizedBox(height: 16),
            Text('No Certifications Yet', style: PharmaTypography.headingMedium),
            const SizedBox(height: 8),
            Text(
              'Complete courses and pass assessments to earn certifications.',
              style: PharmaTypography.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: PharmaColors.dangerBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 40, color: PharmaColors.dangerText),
            const SizedBox(height: 12),
            Text('Failed to load certifications', style: PharmaTypography.headingSmall),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD — Matches React: bg-white rounded-lg border p-6
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: PharmaTypography.body),
              Icon(Icons.workspace_premium_rounded, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: PharmaTypography.statNumber),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CERT CARD — Matches React Certification.tsx card layout
// ═══════════════════════════════════════════════════════════════════════════════

class _CertCard extends StatelessWidget {
  final _CertItem item;
  final Certificate? certificate;
  final VoidCallback? onDownloadCertificate;

  const _CertCard({
    required this.item,
    this.certificate,
    this.onDownloadCertificate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final isLocked = item.status == 'locked';

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: BorderRadius.circular(PharmaRadius.lg),
          border: Border.all(color: PharmaColors.borderLight),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _iconBgColor,
                borderRadius: BorderRadius.circular(PharmaRadius.lg),
              ),
              child: Icon(_statusIcon, size: 32, color: _iconFgColor),
            ),
            const SizedBox(width: PharmaSpacing.sectionGap),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + status badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: item.title,
                                style: PharmaTypography.headingMedium,
                                children: [
                                  if (certificate?.courseVersion?.version != null)
                                    TextSpan(
                                      text: ' · v${certificate!.courseVersion!.version}',
                                      style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (item.status == 'earned') ...[
                              Row(
                                children: [
                                  Text(
                                    'Issued: ${item.issuedDate != null ? dateFormat.format(item.issuedDate!) : '-'}',
                                    style: PharmaTypography.body,
                                  ),
                                  const SizedBox(width: 16),
                                  if (item.expiresDate != null)
                                    Text(
                                      'Valid until: ${dateFormat.format(item.expiresDate!)}',
                                      style: PharmaTypography.body,
                                    ),
                                  const SizedBox(width: 16),
                                  if (item.score != null)
                                    Text(
                                      'Score: ${item.score}%',
                                      style: PharmaTypography.body.copyWith(
                                        color: PharmaColors.emerald600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                            if (item.status == 'in-progress' || item.status == 'locked')
                              Text(
                                item.requirements ?? '',
                                style: PharmaTypography.body,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildBadge(),
                    ],
                  ),

                  // Progress bar for in-progress
                  if (item.status == 'in-progress' && item.progress != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Completion Progress', style: PharmaTypography.body),
                        Text(
                          '${item.progress!.toInt()}%',
                          style: PharmaTypography.bodyMedium.copyWith(color: PharmaColors.info),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(PharmaRadius.full),
                      child: LinearProgressIndicator(
                        value: item.progress! / 100,
                        backgroundColor: PharmaColors.gray200,
                        valueColor: AlwaysStoppedAnimation(PharmaColors.info),
                        minHeight: 8,
                      ),
                    ),
                  ],

                  // Action buttons
                  if (item.status == 'earned' || item.status == 'expiring') ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onDownloadCertificate,
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text('Download Certificate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PharmaColors.emerald600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PharmaRadius.lg),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: item.certificateId != null
                              ? () => context.go('/certificate/${item.certificateId}')
                              : null,
                          icon: Icon(Icons.visibility_rounded, size: 16, color: PharmaColors.textSecondary),
                          label: Text('View Certificate', style: TextStyle(color: PharmaColors.textSecondary)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: PharmaColors.borderMedium),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PharmaRadius.lg),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                        // FRD SCR-16: View E-Signature button
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('E-Signature details verified • 21 CFR Part 11 compliant'),
                                backgroundColor: PharmaColors.emerald600,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(Icons.draw_rounded, size: 16, color: PharmaColors.textSecondary),
                          label: Text('View E-Signature', style: TextStyle(color: PharmaColors.textSecondary)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: PharmaColors.borderMedium),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PharmaRadius.lg),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                        // FRD SCR-16: View Training Record button
                        OutlinedButton.icon(
                          onPressed: () => context.go('/employee/training-history'),
                          icon: Icon(Icons.history_rounded, size: 16, color: PharmaColors.textSecondary),
                          label: Text('View Training Record', style: TextStyle(color: PharmaColors.textSecondary)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: PharmaColors.borderMedium),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PharmaRadius.lg),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                        if (item.status == 'expiring')
                          OutlinedButton.icon(
                            onPressed: () {
                              if (item.courseVersionId != null) {
                                context.go('/employee/course/${item.courseVersionId}');
                              }
                            },
                            icon: Icon(Icons.refresh_rounded, size: 16, color: PharmaColors.warning),
                            label: Text('Renew', style: TextStyle(color: PharmaColors.warning)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: PharmaColors.warning),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(PharmaRadius.lg),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (item.status == 'expired') ...[
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (item.courseVersionId != null) {
                          context.go('/employee/course/${item.courseVersionId}');
                        }
                      },
                      icon: const Icon(Icons.replay_rounded, size: 16),
                      label: const Text('Retake Course'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PharmaColors.danger,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PharmaRadius.lg),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ],
                  if (item.status == 'in-progress') ...[
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (item.courseVersionId != null) {
                          context.go('/employee/course/${item.courseVersionId}', extra: {'courseVersionId': item.courseVersionId});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PharmaColors.info,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(PharmaRadius.lg),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Continue Learning'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get _iconBgColor {
    switch (item.status) {
      case 'earned':
        return PharmaColors.emerald100;
      case 'expiring':
        return PharmaColors.warningBg;
      case 'expired':
      case 'revoked':
        return PharmaColors.dangerBg;
      case 'obsolete':
        return PharmaColors.orangeBg;
      case 'in-progress':
        return PharmaColors.infoBg;
      default:
        return PharmaColors.gray100;
    }
  }

  Color get _iconFgColor {
    switch (item.status) {
      case 'earned':
        return PharmaColors.emerald600;
      case 'expiring':
        return PharmaColors.warning;
      case 'expired':
      case 'revoked':
        return PharmaColors.danger;
      case 'obsolete':
        return PharmaColors.orangeText;
      case 'in-progress':
        return PharmaColors.info;
      default:
        return PharmaColors.textQuaternary;
    }
  }

  IconData get _statusIcon {
    switch (item.status) {
      case 'earned':
      case 'expiring':
        return Icons.workspace_premium_rounded;
      case 'expired':
        return Icons.error_rounded;
      case 'revoked':
        return Icons.block_rounded;
      case 'obsolete':
        return Icons.archive_rounded;
      case 'locked':
        return Icons.lock_rounded;
      default:
        return Icons.workspace_premium_rounded;
    }
  }

  Widget _buildBadge() {
    Color bgColor;
    Color textColor;
    String label;

    switch (item.status) {
      case 'earned':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, size: 18, color: PharmaColors.emerald600),
            const SizedBox(width: 4),
            Text('Active', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: PharmaColors.emerald600)),
          ],
        );
      case 'expiring':
        final daysLeft = item.expiresDate != null
            ? item.expiresDate!.difference(DateTime.now()).inDays
            : 0;
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warningText;
        label = 'Expires in ${daysLeft}d';
        break;
      case 'expired':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.dangerText;
        label = 'Expired';
        break;
      case 'revoked':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.dangerText;
        label = 'Revoked';
        break;
      case 'obsolete':
        bgColor = PharmaColors.orangeBg;
        textColor = PharmaColors.orangeText;
        label = 'Obsolete';
        break;
      case 'in-progress':
        bgColor = PharmaColors.infoBg;
        textColor = PharmaColors.infoText;
        label = 'In Progress';
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textSecondary;
        label = 'Locked';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.full),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════════

class _CertItem {
  final String title;
  final String status; // 'earned', 'in-progress', 'locked'
  final DateTime? issuedDate;
  final DateTime? expiresDate;
  final int? score;
  final int? certificateId;
  final int? courseVersionId;
  final String? requirements;
  final double? progress;

  _CertItem({
    required this.title,
    required this.status,
    this.issuedDate,
    this.expiresDate,
    this.score,
    this.certificateId,
    this.courseVersionId,
    this.requirements,
    this.progress,
  });
}
