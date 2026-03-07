import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/client.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Certificate'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/employee'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Certificate of Completion',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      courseTitle,
                      style: Theme.of(context).textTheme.titleLarge,
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'has successfully completed the required training.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Issued: ${cert.issuedAt.toString().split(' ')[0]}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (cert.expiresAt != null)
                      Text(
                        'Expires: ${cert.expiresAt!.toString().split(' ')[0]}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    const SizedBox(height: 24),
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
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: Text(
                          'ID: ${cert.id}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Verification: $verificationUrl',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
