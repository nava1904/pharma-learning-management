import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/certificate_pdf_service.dart';
import '../../core/client.dart';
import '../../core/file_download.dart';
import '../../design_system/pharma_design_system.dart';

/// Certificate display with QR code for verification.
class CertificateScreen extends StatefulWidget {
  const CertificateScreen({
    super.key,
    required this.certificateId,
    this.certificate,
  });

  final String certificateId;
  final Certificate? certificate;

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  Certificate? _certificate;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.certificate != null) {
      _certificate = widget.certificate;
      _loading = false;
    } else {
      _load();
    }
  }

  Future<void> _load() async {
    final id = int.tryParse(widget.certificateId);
    if (id == null) {
      setState(() {
        _error = 'Invalid certificate ID.';
        _loading = false;
      });
      return;
    }
    try {
      final cert = await client.training.getCertificateById(id);
      if (mounted) {
        setState(() {
          _certificate = cert;
          _loading = false;
          if (cert == null) _error = 'Certificate not found.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load certificate: $e';
          _loading = false;
        });
      }
    }
  }

  Future<void> _downloadPdf(BuildContext context, Certificate cert) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: PharmaColors.emerald600)),
    );
    try {
      final bytes = await generateCertificatePdf(cert);
      final id = cert.id ?? 0;
      final saved = await saveBytesToFile(bytes, 'vyuh_lms_certificate_$id.pdf');
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(saved ? 'Certificate downloaded' : 'Download cancelled'),
          backgroundColor: saved ? PharmaColors.emerald600 : null,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text('Download failed: $e'),
          backgroundColor: PharmaColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Certificate')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null || _certificate == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Certificate')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error ?? 'Certificate not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/employee'),
                child: const Text('Back to Dashboard'),
              ),
            ],
          ),
        ),
      );
    }

    final cert = _certificate!;
    final userName = cert.user != null
        ? '${cert.user!.firstName} ${cert.user!.lastName}'
        : 'User';
    final courseTitle = cert.courseVersion?.course?.title ?? 'Course';
    final verificationUrl = cert.qrCode != null
        ? 'https://pharma-lms.demo/verify/${cert.qrCode}'
        : 'CERT-${cert.id}';
    final isObsolete = cert.status == 'obsolete';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Certificate'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/employee'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () => _downloadPdf(context, cert),
            tooltip: 'Download PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                // ── Certificate Card ──
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Lottie.asset(
                            'assets/lottie/certificate.json',
                            fit: BoxFit.contain,
                            repeat: false,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Certificate of Completion',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isObsolete
                                    ? PharmaColors.orangeBg
                                    : PharmaColors.successBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isObsolete ? 'Obsolete' : 'Active',
                                style: TextStyle(
                                  color: isObsolete
                                      ? PharmaColors.orangeText
                                      : PharmaColors.successText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isObsolete)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: PharmaColors.orangeBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: PharmaColors.orange.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                'This certificate is superseded by a newer course version.',
                                style: TextStyle(
                                  color: PharmaColors.orangeText,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                        Text.rich(
                          TextSpan(
                            text: courseTitle,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            children: [
                              if (cert.courseVersion?.version != null)
                                TextSpan(
                                  text: ' · v${cert.courseVersion!.version}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: PharmaColors.textTertiary,
                                      ),
                                ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'This certifies that',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'has successfully completed the required training.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // ── Dates Row ──
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: PharmaColors.pageBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 14, color: PharmaColors.textTertiary),
                              const SizedBox(width: 6),
                              Text(
                                'Issued: ${cert.issuedAt.toString().split(' ')[0]}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: PharmaColors.textSecondary,
                                ),
                              ),
                              if (cert.expiresAt != null) ...[
                                const SizedBox(width: 16),
                                const Icon(Icons.event,
                                    size: 14, color: PharmaColors.textTertiary),
                                const SizedBox(width: 6),
                                Text(
                                  'Expires: ${cert.expiresAt!.toString().split(' ')[0]}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: PharmaColors.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // ── QR Code ──
                        if (cert.qrCode != null)
                          QrImageView(
                            data: verificationUrl,
                            version: QrVersions.auto,
                            size: 120,
                          )
                        else
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: PharmaColors.pageBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'ID: ${cert.id}',
                              style: const TextStyle(
                                color: PharmaColors.textTertiary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          'Verification: $verificationUrl',
                          style: const TextStyle(
                            color: PharmaColors.textTertiary,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ── E-Signature Details ──
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.draw_outlined,
                                size: 18, color: PharmaColors.emerald600),
                            const SizedBox(width: 8),
                            Text(
                              'E-Signature Record',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _certDetailRow('Signer', userName),
                        _certDetailRow(
                            'Date',
                            cert.issuedAt.toString().split(' ')[0]),
                        _certDetailRow('Meaning', 'I have read and understood'),
                        _certDetailRow('Method', 'Password Re-authentication'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: PharmaColors.emerald50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.verified,
                                  size: 14, color: PharmaColors.emerald600),
                              const SizedBox(width: 6),
                              Text(
                                '21 CFR Part 11 Compliant',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: PharmaColors.emerald700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ── ALCOA+ Footer ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PharmaColors.pageBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: PharmaColors.borderLight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Attributable · Legible · Contemporaneous · Original · Accurate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: PharmaColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All training records are electronically signed per '
                        '21 CFR Part 11 and GMP Annex 11',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: PharmaColors.textQuaternary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _certDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: PharmaColors.textTertiary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: PharmaColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
