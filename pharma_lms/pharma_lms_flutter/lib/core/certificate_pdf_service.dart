// ═══════════════════════════════════════════════════════════════════════════════
// Certificate PDF generation with Vyuh LMS watermark (platform-agnostic).
// Used by CertificationScreenV2, CertificateScreen, CredentialsWalletScreen,
// and Downloads screen.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

/// Formats a date for PDF display (e.g. "Jan 15, 2026").
String _formatPdfDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

/// Generates a certificate PDF with Vyuh LMS diagonal watermark.
/// [certificate] must have courseVersion.course, user, and optionally user.organization loaded.
Future<Uint8List> generateCertificatePdf(Certificate certificate) async {
  final courseTitle = certificate.courseVersion?.course?.title ?? 'Training Course';
  final courseCode = certificate.courseVersion?.version ?? 'v1.0';
  final issuedAt = certificate.issuedAt;
  final expiresAt = certificate.expiresAt;
  final credentialId = certificate.id != null
      ? 'CERT-${certificate.id.toString().padLeft(6, '0')}'
      : 'CERT-000000';
  final holderName = certificate.user?.firstName != null
      ? '${certificate.user!.firstName} ${certificate.user?.lastName ?? ''}'.trim()
      : 'Certificate Holder';
  final organizationName = certificate.user?.organization?.name ?? 'Organization';

  const brandPrimary = PdfColor.fromInt(0xFF0066FF);
  const brandTeal = PdfColor.fromInt(0xFF0D9488);
  const goldAccent = PdfColor.fromInt(0xFFD4AF37);
  const textDark = PdfColor.fromInt(0xFF1E293B);
  const textLight = PdfColor.fromInt(0xFF64748B);

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            // Watermark - VYUH LMS diagonal
            pw.Positioned.fill(
              child: pw.Center(
                child: pw.Transform.rotate(
                  angle: -0.3,
                  child: pw.Opacity(
                    opacity: 0.04,
                    child: pw.Text(
                      'VYUH LMS',
                      style: pw.TextStyle(
                        fontSize: 120,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Main content
            pw.Container(
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'VYUH LMS',
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: brandPrimary,
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            'Enterprise Learning Management',
                            style: pw.TextStyle(fontSize: 10, color: textLight),
                          ),
                        ],
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: brandTeal, width: 1),
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Text(
                          '21 CFR Part 11 Compliant',
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: brandTeal,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                  pw.Text(
                    'CERTIFICATE OF COMPLETION',
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                      color: goldAccent,
                      letterSpacing: 4,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Container(
                    width: 100,
                    height: 2,
                    color: goldAccent,
                  ),
                  pw.SizedBox(height: 30),
                  pw.Text(
                    'This is to certify that',
                    style: pw.TextStyle(fontSize: 12, color: textLight),
                  ),
                  pw.SizedBox(height: 12),
                  pw.Text(
                    holderName.toUpperCase(),
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    organizationName,
                    style: pw.TextStyle(fontSize: 14, color: textLight),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'has successfully completed the training program',
                    style: pw.TextStyle(fontSize: 12, color: textLight),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: pw.BoxDecoration(
                      color: const PdfColor.fromInt(0xFFF1F5F9),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          courseTitle,
                          style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            color: brandPrimary,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Course Code: $courseCode',
                          style: pw.TextStyle(fontSize: 10, color: textLight),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      _buildInfoBox('Issued', _formatPdfDate(issuedAt), brandPrimary),
                      pw.SizedBox(width: 20),
                      if (expiresAt != null) ...[
                        _buildInfoBox('Valid Until', _formatPdfDate(expiresAt), brandTeal),
                        pw.SizedBox(width: 20),
                      ],
                      _buildInfoBox('Credential ID', credentialId, goldAccent),
                    ],
                  ),
                  pw.Spacer(),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: const PdfColor.fromInt(0xFFE2E8F0)),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Verification URL',
                              style: pw.TextStyle(fontSize: 8, color: textLight),
                            ),
                            pw.Text(
                              'https://lms.vyuh.tech/verify/$credentialId',
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: brandPrimary,
                              ),
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Powered by Vyuh LMS',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                                color: textDark,
                              ),
                            ),
                            pw.Text(
                              'GxP Compliant Learning Management',
                              style: pw.TextStyle(fontSize: 8, color: textLight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  return Uint8List.fromList(await pdf.save());
}

pw.Widget _buildInfoBox(String label, String value, PdfColor color) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: color, width: 1),
      borderRadius: pw.BorderRadius.circular(4),
    ),
    child: pw.Column(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 8,
            color: const PdfColor.fromInt(0xFF64748B),
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}
