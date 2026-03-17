// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — DOWNLOADS SCREEN (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Matches React ref2: Download.tsx
// Shows downloadable certificates (PDF with Vyuh watermark). Data from backend.
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/certificate_pdf_service.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// DOWNLOAD DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════════

class _DownloadItem {
  final int id;
  final String name;
  final String type;
  final String size;
  final String date;
  final IconData icon;
  final Color iconColor;

  const _DownloadItem({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.date,
    required this.icon,
    required this.iconColor,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN — Real data from certificatesProvider
// ═══════════════════════════════════════════════════════════════════════════════

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificatesAsync = ref.watch(certificatesProvider);

    return certificatesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: PharmaColors.emerald600)),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 16),
            Text('Failed to load downloads', style: PharmaTypography.headingSmall),
            const SizedBox(height: 8),
            Text('$e', style: PharmaTypography.caption),
          ],
        ),
      ),
      data: (certificates) {
        final dateFormat = DateFormat('MMM d, yyyy');
        final certList = certificates
            .where((c) => c.status == 'active' || c.status == 'expired' || c.status == 'obsolete')
            .toList();
        final downloads = certList
            .map((cert) => _DownloadItem(
                  id: cert.id ?? 0,
                  name: cert.courseVersion?.course?.title ?? 'Certificate #${cert.id}',
                  type: 'PDF',
                  size: 'Certificate',
                  date: dateFormat.format(cert.issuedAt),
                  icon: Icons.picture_as_pdf_rounded,
                  iconColor: const Color(0xFFDC2626),
                ))
            .toList();
        final pdfCount = downloads.length;

        return RefreshIndicator(
          color: PharmaColors.emerald600,
          onRefresh: () async {
            ref.invalidate(certificatesProvider);
            await ref.refresh(certificatesProvider.future);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Downloads', style: PharmaTypography.headingLarge),
                        const SizedBox(height: 8),
                        Text(
                          'Access your certificates (PDF with Vyuh watermark)',
                          style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: PharmaSpacing.gridGap,
                      crossAxisSpacing: PharmaSpacing.gridGap,
                      childAspectRatio: 2.2,
                      children: [
                        _StatCard(
                          title: 'Total Files',
                          value: '${downloads.length}',
                          icon: Icons.description_outlined,
                          iconColor: PharmaColors.textTertiary,
                        ),
                        _StatCard(
                          title: 'Certificates (PDF)',
                          value: '$pdfCount',
                          icon: Icons.picture_as_pdf_outlined,
                          iconColor: const Color(0xFFDC2626),
                        ),
                        _StatCard(
                          title: 'Spreadsheets',
                          value: '0',
                          icon: Icons.table_chart_outlined,
                          iconColor: const Color(0xFF16A34A),
                        ),
                        _StatCard(
                          title: 'Total Size',
                          value: '—',
                          icon: Icons.download_outlined,
                          iconColor: PharmaColors.textTertiary,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: PharmaSpacing.sectionGap),

                if (downloads.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(48),
                    decoration: BoxDecoration(
                      color: PharmaColors.cardBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(color: PharmaColors.borderLight),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.download_outlined, size: 48, color: PharmaColors.textQuaternary),
                          const SizedBox(height: 16),
                          Text('No certificates to download', style: PharmaTypography.headingMedium),
                          const SizedBox(height: 8),
                          Text(
                            'Complete courses to earn certificates, then download them here.',
                            style: PharmaTypography.body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      color: PharmaColors.cardBg,
                      borderRadius: PharmaRadius.cardRadius,
                      border: Border.all(color: PharmaColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < downloads.length; i++) ...[
                          _DownloadRow(
                            item: downloads[i],
                            certificate: certList[i],
                            onDownload: () => _downloadCertificate(context, certList[i]),
                          ),
                          if (i < downloads.length - 1)
                            Divider(height: 1, color: PharmaColors.borderLight),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> _downloadCertificate(BuildContext context, Certificate certificate) async {
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// DOWNLOAD ROW
// From React: File icon + info + download button
// ═══════════════════════════════════════════════════════════════════════════════

class _DownloadRow extends StatefulWidget {
  const _DownloadRow({
    required this.item,
    required this.certificate,
    required this.onDownload,
  });

  final _DownloadItem item;
  final Certificate certificate;
  final VoidCallback onDownload;

  @override
  State<_DownloadRow> createState() => _DownloadRowState();
}

class _DownloadRowState extends State<_DownloadRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: PharmaDurations.fast,
        padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
        color: _isHovered ? PharmaColors.gray50 : Colors.transparent,
        child: Row(
          children: [
            // File icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: PharmaColors.gray100,
                borderRadius: PharmaRadius.buttonRadius,
              ),
              child: Icon(widget.item.icon, size: 24, color: widget.item.iconColor),
            ),
            const SizedBox(width: PharmaSpacing.cardPadding),

            // File info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(widget.item.type, style: PharmaTypography.caption),
                      _dot(),
                      Text(widget.item.size, style: PharmaTypography.caption),
                      _dot(),
                      Text(widget.item.date, style: PharmaTypography.caption),
                    ],
                  ),
                ],
              ),
            ),

            TextButton.icon(
              onPressed: widget.onDownload,
              icon: const Icon(Icons.download_rounded, size: 16),
              label: const Text('Download'),
              style: TextButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text('•', style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD & OUTLINE BUTTON
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: PharmaTypography.headingLarge.copyWith(fontSize: 28)),
        ],
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  const _OutlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: PharmaDurations.fast,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? PharmaColors.gray50 : Colors.transparent,
            borderRadius: PharmaRadius.buttonRadius,
            border: Border.all(color: PharmaColors.borderMedium),
          ),
          child: Text(widget.label, style: PharmaTypography.button),
        ),
      ),
    );
  }
}
