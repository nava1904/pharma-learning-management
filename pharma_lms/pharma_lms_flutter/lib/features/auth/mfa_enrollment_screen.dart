import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// MFA enrollment screen. User scans QR with authenticator app and verifies with TOTP.
class MfaEnrollmentScreen extends ConsumerStatefulWidget {
  const MfaEnrollmentScreen({super.key});

  @override
  ConsumerState<MfaEnrollmentScreen> createState() => _MfaEnrollmentScreenState();
}

class _MfaEnrollmentScreenState extends ConsumerState<MfaEnrollmentScreen> {
  MfaEnrollResult? _enrollResult;
  MfaStatusResult? _status;
  bool _loading = true;
  bool _verifying = false;
  String _code = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final status = await client.mfa.getMfaStatus();
      if (mounted) {
        setState(() {
          _status = status;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _startEnrollment() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await client.mfa.enrollMfa();
      if (mounted) {
        setState(() {
          _enrollResult = result;
          _loading = false;
          _code = '';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _verifyEnrollment() async {
    if (_code.length != 6) {
      setState(() => _error = 'Enter a 6-digit code');
      return;
    }
    setState(() {
      _verifying = true;
      _error = null;
    });
    try {
      final ok = await client.mfa.verifyMfaEnrollment(_code);
      if (mounted) {
        if (ok) {
          setState(() {
            _enrollResult = null;
            _verifying = false;
            _code = '';
          });
          await _loadStatus();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('MFA enabled successfully'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        } else {
          setState(() {
            _verifying = false;
            _error = 'Invalid code. Try again.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _verifying = false;
          _error = e.toString();
        });
      }
    }
  }

  Future<void> _disableMfa() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await client.mfa.disableMfa();
      if (mounted) {
        setState(() {
          _enrollResult = null;
          _loading = false;
        });
        await _loadStatus();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('MFA disabled')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Factor Authentication'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.destructive.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _error!,
                        style: TextStyle(color: AppColors.destructive),
                      ),
                    ),
                  ],
                  if (_enrollResult != null) _buildEnrollStep(),
                  if (_enrollResult == null && _status != null) _buildStatus(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatus() {
    final enabled = _status!.mfaEnabled;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      enabled ? Icons.verified_user : Icons.security,
                      size: 48,
                      color: enabled ? AppColors.success : AppColors.slate500,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            enabled ? 'MFA is enabled' : 'MFA is not enabled',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          if (enabled && _status!.enrolledAt != null)
                            Text(
                              'Enrolled ${_status!.enrolledAt!.toLocal()}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (enabled)
                  OutlinedButton(
                    onPressed: _disableMfa,
                    child: const Text('Disable MFA'),
                  )
                else
                  ElevatedButton(
                    onPressed: _startEnrollment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.indigo600,
                    ),
                    child: const Text('Enable MFA'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnrollStep() {
    final result = _enrollResult!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan QR code with your authenticator app',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Center(
              child: QrImageView(
                data: result.otpauthUrl,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Or enter this secret manually:',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            SelectableText(
              result.secretBase32,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
            const SizedBox(height: 24),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Enter 6-digit code',
                hintText: '000000',
                counterText: '',
              ),
              onChanged: (v) => setState(() => _code = v),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifying ? null : _verifyEnrollment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.indigo600,
                ),
                child: _verifying
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Verify and enable MFA'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _verifying ? null : () => setState(() => _enrollResult = null),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
