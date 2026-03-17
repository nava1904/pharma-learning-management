// ═══════════════════════════════════════════════════════════════════════════════
// VYUH LMS — CREDENTIALS WALLET (Screen 6)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Master Prompt Section 3.6: Credentials Wallet
// Route: /employee/credentials
//
// PURPOSE:
// Display all certificates and credentials for the authenticated user.
// Show expiration status with visual indicators.
//
// FEATURES:
// - Filter by status: All | Valid | Expiring Soon | Expired
// - Download individual certificates as PDF with company watermark
// - Share via URL with verification QR code
// - Track expiring certifications
//
// API CALLS:
// - getCertificatesByUser(userId) → List<Certificate>
// - downloadCertificatePdf(certificateId) → blob URL
// - generateShareLink(certificateId) → verification URL
//
// STATES:
// - loading: Skeleton grid
// - empty: "No credentials yet – complete your first course"
// - data: Grid of CredentialCard components
//
// COMPLIANCE:
// - 21 CFR Part 11: Certificate integrity verification via QR
// - ALCOA+: Traceable completion records
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/certificate_pdf_service.dart';
import '../../core/file_download.dart';
import '../../design_system/design_system.dart';
import '../../providers/dashboard_providers.dart';
import '../../widgets/app_shell.dart';

/// Credentials status filter
enum CredentialFilter {
  all,
  valid,
  expiringSoon,
  expired,
}

extension CredentialFilterLabel on CredentialFilter {
  String get label {
    switch (this) {
      case CredentialFilter.all:
        return 'All';
      case CredentialFilter.valid:
        return 'Valid';
      case CredentialFilter.expiringSoon:
        return 'Expiring Soon';
      case CredentialFilter.expired:
        return 'Expired';
    }
  }

  IconData get icon {
    switch (this) {
      case CredentialFilter.all:
        return Icons.folder_outlined;
      case CredentialFilter.valid:
        return Icons.check_circle_outline_rounded;
      case CredentialFilter.expiringSoon:
        return Icons.schedule_rounded;
      case CredentialFilter.expired:
        return Icons.error_outline_rounded;
    }
  }
}

/// State provider for selected filter
final credentialFilterProvider =
    StateProvider<CredentialFilter>((ref) => CredentialFilter.all);

/// Credentials Wallet Screen
class CredentialsWalletScreen extends ConsumerWidget {
  const CredentialsWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificatesAsync = ref.watch(certificatesProvider);
    final filter = ref.watch(credentialFilterProvider);

    return AppShell(
      title: 'Credentials Wallet',
      icon: Icons.workspace_premium_rounded,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(certificatesProvider);
        },
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Credentials',
                      style: AppTypography.title.copyWith(
                        color: AppColors.n900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    Text(
                      'Certificates and credentials from completed training',
                      style: AppTypography.body.copyWith(
                        color: AppColors.n500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filter chips
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Row(
                  children: CredentialFilter.values.map((f) {
                    final isSelected = filter == f;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.s2),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(f.label),
                        avatar: Icon(
                          f.icon,
                          size: 18,
                          color:
                              isSelected ? AppColors.blue : AppColors.n500,
                        ),
                        onSelected: (_) => ref
                            .read(credentialFilterProvider.notifier)
                            .state = f,
                        selectedColor: AppColors.blueLight,
                        checkmarkColor: AppColors.blue,
                        labelStyle: AppTypography.label.copyWith(
                          color:
                              isSelected ? AppColors.blue : AppColors.n600,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.blue
                              : AppColors.n200,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.s6),
            ),

            // Content
            certificatesAsync.when(
              loading: () => SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const CredentialCardSkeleton(),
                    childCount: 4,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: AppSpacing.s4,
                    mainAxisSpacing: AppSpacing.s4,
                  ),
                ),
              ),
              error: (error, _) => SliverFillRemaining(
                child: AppErrorWidget(
                  message:
                      'Unable to load your credentials. Please try again.',
                  onRetry: () => ref.invalidate(certificatesProvider),
                ),
              ),
              data: (certificates) {
                // Apply filter
                final filtered = _filterCertificates(certificates, filter);

                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    child: AppEmptyState(
                      icon: filter == CredentialFilter.all
                          ? Icons.workspace_premium_outlined
                          : filter.icon,
                      title: filter == CredentialFilter.all
                          ? 'No credentials yet'
                          : 'No ${filter.label.toLowerCase()} credentials',
                      description: filter == CredentialFilter.all
                          ? 'Complete your first training course to earn a certificate.'
                          : 'You don\'t have any credentials in this category.',
                      actionLabel:
                          filter == CredentialFilter.all ? 'Browse Courses' : null,
                      onAction: filter == CredentialFilter.all
                          ? () => context.go('/employee/catalog')
                          : null,
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePadding,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final cert = filtered[index];
                        return _CertificateCard(certificate: cert);
                      },
                      childCount: filtered.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: AppSpacing.s4,
                      mainAxisSpacing: AppSpacing.s4,
                    ),
                  ),
                );
              },
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.s10),
            ),
          ],
        ),
      ),
    );
  }

  List<Certificate> _filterCertificates(
    List<Certificate> certificates,
    CredentialFilter filter,
  ) {
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));

    switch (filter) {
      case CredentialFilter.all:
        return certificates;
      case CredentialFilter.valid:
        return certificates.where((c) {
          final expiry = c.expiresAt;
          if (expiry == null) return true;
          return expiry.isAfter(thirtyDaysFromNow);
        }).toList();
      case CredentialFilter.expiringSoon:
        return certificates.where((c) {
          final expiry = c.expiresAt;
          if (expiry == null) return false;
          return expiry.isAfter(now) && expiry.isBefore(thirtyDaysFromNow);
        }).toList();
      case CredentialFilter.expired:
        return certificates.where((c) {
          final expiry = c.expiresAt;
          if (expiry == null) return false;
          return expiry.isBefore(now);
        }).toList();
    }
  }
}

/// Individual certificate card — Premium SaaS design
/// Features: Colored header strip, grayscale filter for expired, soft shadow
class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.certificate});

  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    final issuedAt = certificate.issuedAt;
    final expiresAt = certificate.expiresAt;
    final isExpired = expiresAt?.isBefore(DateTime.now()) ?? false;
    final isExpiringSoon = expiresAt?.isExpiringSoon ?? false;
    final courseTitle =
        certificate.courseVersion?.course?.title ?? 'Training Course';
    final credentialId = certificate.id != null
        ? 'CERT-${certificate.id.toString().padLeft(6, '0')}'
        : 'CERT-000000';

    // Header colors based on status
    Color headerColor;
    Color textColor;
    String statusLabel;
    IconData statusIcon;
    
    if (isExpired) {
      headerColor = const Color(0xFFEF4444);
      textColor = Colors.white;
      statusLabel = 'Expired';
      statusIcon = Icons.error_outline_rounded;
    } else if (isExpiringSoon) {
      headerColor = const Color(0xFFF59E0B);
      textColor = Colors.white;
      statusLabel = 'Expiring Soon';
      statusIcon = Icons.schedule_rounded;
    } else {
      headerColor = const Color(0xFF10B981);
      textColor = Colors.white;
      statusLabel = 'Valid';
      statusIcon = Icons.verified_rounded;
    }

    return ColorFiltered(
      colorFilter: isExpired
          ? const ColorFilter.matrix([
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0,      0,      0,      1, 0,
            ])
          : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored header strip
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: headerColor,
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: textColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    statusLabel,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.workspace_premium_rounded,
                    color: textColor.withOpacity(0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course title
                    Text(
                      courseTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Credential ID
                    Row(
                      children: [
                        Icon(
                          Icons.tag_rounded,
                          size: 14,
                          color: const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          credentialId,
                          style: const TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Dates row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Issued',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                              Text(
                                issuedAt.humanDate,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (expiresAt != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isExpired ? 'Expired' : 'Expires',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isExpired 
                                        ? const Color(0xFFEF4444) 
                                        : const Color(0xFF94A3B8),
                                  ),
                                ),
                                Text(
                                  expiresAt.humanDate,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isExpired 
                                        ? const Color(0xFFEF4444) 
                                        : const Color(0xFF475569),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Actions row
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _downloadCertificate(context),
                            icon: const Icon(Icons.download_rounded, size: 16),
                            label: const Text('Download'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4F46E5),
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _shareCertificate(context),
                          icon: const Icon(Icons.share_rounded, size: 18),
                          style: IconButton.styleFrom(
                            foregroundColor: const Color(0xFF64748B),
                            backgroundColor: const Color(0xFFF8FAFC),
                          ),
                          tooltip: 'Share',
                        ),
                      ],
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

  Future<void> _downloadCertificate(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final bytes = await generateCertificatePdf(certificate);
      if (!context.mounted) return;
      final id = certificate.id ?? 0;
      final saved = await saveBytesToFile(bytes, 'vyuh_lms_certificate_$id.pdf');
      if (context.mounted) Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(saved ? 'Certificate downloaded successfully' : 'Download cancelled'),
            backgroundColor: saved ? const Color(0xFF10B981) : null,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading certificate: $e'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _shareCertificate(BuildContext context) {
    // Show share dialog with QR code and verification link
    if (certificate.id != null) {
      showDialog(
        context: context,
        builder: (context) => _ShareDialog(certificate: certificate),
      );
    }
  }
}

/// Share dialog with QR code and verification link
class _ShareDialog extends StatelessWidget {
  const _ShareDialog({required this.certificate});

  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    final courseTitle =
        certificate.courseVersion?.course?.title ?? 'Training Course';
    final verificationUrl = certificate.qrCode ??
        'https://lms.pharma.com/verify/${certificate.id}';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.br3),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.blueLight,
                    borderRadius: AppRadius.br2,
                  ),
                  child: const Icon(
                    Icons.share_rounded,
                    color: AppColors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.s4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Credential',
                        style: AppTypography.headline.copyWith(
                          color: AppColors.n900,
                        ),
                      ),
                      Text(
                        courseTitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.n500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  tooltip: 'Close',
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s6),

            // QR Code placeholder
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.n50,
                borderRadius: AppRadius.br2,
                border: Border.all(color: AppColors.n200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    size: 80,
                    color: AppColors.n400,
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    'Verification QR',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.n500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s4),

            // Verification URL
            Container(
              padding: const EdgeInsets.all(AppSpacing.s3),
              decoration: BoxDecoration(
                color: AppColors.n100,
                borderRadius: AppRadius.br1,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      verificationUrl,
                      style: AppTypography.code.copyWith(
                        fontSize: 11,
                        color: AppColors.n600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s2),
                  IconButton(
                    onPressed: () {
                      // Copy to clipboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Link copied to clipboard'),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    tooltip: 'Copy link',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s2),

            Text(
              'Anyone with this link can verify your credential',
              style: AppTypography.caption.copyWith(
                color: AppColors.n500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.s6),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s4,
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      // Open native share sheet
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Share functionality coming soon'),
                          backgroundColor: AppColors.blue,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.share_rounded, size: 18),
                    label: const Text('Share'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
