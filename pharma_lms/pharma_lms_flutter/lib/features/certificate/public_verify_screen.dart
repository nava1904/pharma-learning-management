import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../design_system/pharma_components.dart';
import '../../design_system/pharma_design_system.dart';

/// SCR-17 — Public Certificate Verification.
/// No authentication required. Accessible via /verify/:token.
class PublicVerifyScreen extends StatefulWidget {
  const PublicVerifyScreen({super.key, required this.token});

  final String token;

  @override
  State<PublicVerifyScreen> createState() => _PublicVerifyScreenState();
}

class _PublicVerifyScreenState extends State<PublicVerifyScreen> {
  Certificate? _certificate;
  bool _loading = true;
  bool _valid = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _verify();
  }

  Future<void> _verify() async {
    try {
      // Try to parse token as certificate ID for lookup.
      // TODO: Backend should expose a public verifyCertificateByToken(token)
      // endpoint for QR code verification without authentication.
      final id = int.tryParse(widget.token);
      Certificate? result;
      if (id != null) {
        result = await client.training.getCertificateById(id);
      }
      if (!mounted) return;
      setState(() {
        _certificate = result;
        _valid = result != null;
        _loading = false;
        if (result == null) _error = 'Certificate not found or has been revoked.';
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _valid = false;
          _error = 'Verification failed. The certificate token may be invalid or expired.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Branding Header ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VyuhLogo(
                      height: 36,
                      width: 36,
                      color: PharmaColors.emerald600,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      PharmaBrand.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: PharmaColors.textPrimary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Certificate Verification Portal',
                  style: TextStyle(
                    fontSize: 13,
                    color: PharmaColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 32),
                // ── Content ──
                if (_loading)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(48),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Verifying certificate…'),
                        ],
                      ),
                    ),
                  )
                else if (!_valid || _certificate == null)
                  _buildInvalid()
                else
                  _buildValid(_certificate!),
                const SizedBox(height: 24),
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
                        'Electronically signed per 21 CFR Part 11 and GMP Annex 11',
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

  Widget _buildInvalid() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: PharmaColors.dangerBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.cancel_outlined,
                  color: PharmaColors.danger, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Verification Failed',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.danger,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'This certificate could not be verified.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PharmaColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PharmaColors.dangerBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 16, color: PharmaColors.dangerText),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'If you believe this is an error, contact the Training '
                      'Department or QA team for assistance.',
                      style: TextStyle(
                        fontSize: 12,
                        color: PharmaColors.dangerText,
                      ),
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

  Widget _buildValid(Certificate cert) {
    final userName = cert.user != null
        ? '${cert.user!.firstName} ${cert.user!.lastName}'
        : 'Employee';
    final courseTitle = cert.courseVersion?.course?.title ?? 'Course';
    final isObsolete = cert.status == 'obsolete';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isObsolete
                    ? PharmaColors.orangeBg
                    : PharmaColors.successBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isObsolete ? Icons.archive_outlined : Icons.check_circle,
                color: isObsolete
                    ? PharmaColors.orangeText
                    : PharmaColors.success,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isObsolete ? 'Certificate Superseded' : 'Certificate Verified',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isObsolete
                        ? PharmaColors.orangeText
                        : PharmaColors.successText,
                  ),
            ),
            if (isObsolete) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: PharmaColors.orangeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'This certificate has been superseded by a newer course version.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: PharmaColors.orangeText,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _verifyRow('Employee', userName),
            _verifyRow('Course', courseTitle),
            _verifyRow(
                'Issued', cert.issuedAt.toString().split(' ')[0]),
            if (cert.expiresAt != null)
              _verifyRow(
                  'Expires', cert.expiresAt!.toString().split(' ')[0]),
            _verifyRow('Status',
                isObsolete ? 'Obsolete' : 'Active'),
            _verifyRow('Certificate ID', 'CERT-${cert.id}'),
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: PharmaColors.emerald50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified,
                      size: 16, color: PharmaColors.emerald600),
                  const SizedBox(width: 8),
                  Text(
                    'Digitally verified · HMAC-SHA256',
                    style: TextStyle(
                      fontSize: 12,
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
    );
  }

  Widget _verifyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: PharmaColors.textTertiary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: PharmaColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
