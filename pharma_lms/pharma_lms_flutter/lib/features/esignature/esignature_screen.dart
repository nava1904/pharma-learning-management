import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/biometric_storage.dart';
import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Shows e-signature as a modal dialog. Returns esignatureId on success, null on cancel/expiry.
Future<int?> showEsignatureModal(
  BuildContext context, {
  required String entityType,
  required String entityId,
  String? signatureMeaning,
  int? userId,
}) {
  return showGeneralDialog<int?>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.8),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, _animation, _secondaryAnimation) => EsignatureModal(
      entityType: entityType,
      entityId: entityId,
      signatureMeaning: signatureMeaning,
      userId: userId,
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    },
  );
}

/// Modal e-signature form (signature meaning, password, countdown, Submit/Cancel).
class EsignatureModal extends StatefulWidget {
  const EsignatureModal({
    super.key,
    required this.entityType,
    required this.entityId,
    this.signatureMeaning,
    this.userId,
  });

  final String entityType;
  final String entityId;
  final String? signatureMeaning;
  final int? userId;

  @override
  State<EsignatureModal> createState() => _EsignatureModalState();
}

class _EsignatureModalState extends State<EsignatureModal> {
  final _passwordController = TextEditingController();
  bool _signing = false;
  String? _error;
  List<SignatureMeaning> _meanings = [];
  String? _selectedMeaning;
  bool _loadingMeanings = true;
  int _countdownSeconds = 60;
  bool _windowExpired = false;
  Timer? _countdownTimer;
  bool _biometricAvailable = false;
  bool _hasStoredToken = false;
  bool _biometricChecked = false;

  @override
  void initState() {
    super.initState();
    _loadMeanings();
    _checkBiometric();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _countdownSeconds--;
        if (_countdownSeconds <= 0) {
          _countdownSeconds = 0;
          _windowExpired = true;
          _countdownTimer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometric() async {
    final userId = widget.userId;
    if (userId == null) return;
    final available = await BiometricStorage.isBiometricAvailable;
    final hasToken = await BiometricStorage.hasStoredToken(userId);
    if (mounted) {
      setState(() {
        _biometricAvailable = available;
        _hasStoredToken = hasToken;
        _biometricChecked = true;
      });
    }
  }

  Future<void> _loadMeanings() async {
    try {
      final meanings = await client.training.listSignatureMeanings();
      if (mounted) {
        setState(() {
          _meanings = meanings;
          if (meanings.isNotEmpty) {
            final preferred = widget.signatureMeaning;
            _selectedMeaning = (preferred != null &&
                    meanings.any((m) => m.meaning == preferred))
                ? preferred
                : meanings.first.meaning;
          } else {
            _selectedMeaning =
                widget.signatureMeaning ?? 'I have read and understood';
          }
          _loadingMeanings = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _selectedMeaning =
              widget.signatureMeaning ?? 'I have read and understood';
          _loadingMeanings = false;
        });
      }
    }
  }

  void _pop(int? result) => Navigator.of(context).pop(result);

  Future<void> _sign() async {
    if (_windowExpired) return;
    final userId = widget.userId;
    if (userId == null) {
      _pop(null);
      return;
    }

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password is required for re-authentication.');
      return;
    }

    setState(() {
      _signing = true;
      _error = null;
    });

    final meaning = _selectedMeaning ?? 'I have read and understood';
    try {
      final esignatureId = await client.training.createTrainingSignature(
        userId: userId,
        signatureMeaning: meaning,
        entityType: widget.entityType,
        entityId: widget.entityId,
        passwordReauth: password,
      );
      if (!mounted) return;
      _pop(esignatureId);
      // Plan 6B: store biometric token for next time
      try {
        final token = await client.training.issueBiometricToken(
          userId: userId,
          passwordReauth: password,
        );
        await BiometricStorage.storeToken(userId, token);
      } catch (_) {}
    } catch (e) {
      setState(() {
        _signing = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _signWithBiometric() async {
    if (_windowExpired) return;
    final userId = widget.userId;
    if (userId == null) {
      _pop(null);
      return;
    }
    setState(() {
      _signing = true;
      _error = null;
    });
    final authenticated = await BiometricStorage.authenticateWithBiometric(
      reason: 'Authenticate to sign',
    );
    if (!mounted) return;
    if (!authenticated) {
      setState(() {
        _signing = false;
        _error = 'Biometric authentication failed or was cancelled.';
      });
      return;
    }
    final token = await BiometricStorage.readToken(userId);
    if (token == null || token.isEmpty) {
      setState(() {
        _signing = false;
        _error = 'No stored credential. Sign with password first.';
      });
      return;
    }
    final meaning = _selectedMeaning ?? 'I have read and understood';
    try {
      final esignatureId = await client.training.createTrainingSignature(
        userId: userId,
        signatureMeaning: meaning,
        entityType: widget.entityType,
        entityId: widget.entityId,
        biometricToken: token,
      );
      if (mounted) _pop(esignatureId);
    } catch (e) {
      setState(() {
        _signing = false;
        _error = e.toString().contains('expired') || e.toString().contains('invalid')
            ? 'Session expired. Sign with password to continue.'
            : e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Electronic Signature',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  if (!_windowExpired)
                    Text(
                      '$_countdownSeconds s',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _countdownSeconds <= 10
                            ? AppColors.destructive
                            : AppColors.teal600,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (_windowExpired) ...[
                Card(
                  color: AppColors.destructive.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_off, color: AppColors.destructive),
                            const SizedBox(width: 12),
                            Text(
                              'Re-auth window expired',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.destructive,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Re-open your result to sign.',
                          style: TextStyle(color: AppColors.slate700),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => _pop(null),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                if (_loadingMeanings)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_meanings.isNotEmpty)
                  DropdownButtonFormField<String>(
                    value: _selectedMeaning,
                    decoration: const InputDecoration(
                      labelText: 'Signature Meaning',
                      border: OutlineInputBorder(),
                    ),
                    items: _meanings
                        .map((m) => DropdownMenuItem<String>(
                              value: m.meaning,
                              child: Text(m.meaning),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedMeaning = v ?? _selectedMeaning),
                  )
                else
                  Text(
                    _selectedMeaning ?? 'I have read and understood',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                const SizedBox(height: 8),
                const Text(
                  '21 CFR Part 11 compliant. Re-authentication required.',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 16),
                if (_biometricChecked && _biometricAvailable && _hasStoredToken) ...[
                  FilledButton.icon(
                    onPressed: (_signing || _windowExpired) ? null : _signWithBiometric,
                    icon: const Icon(Icons.fingerprint, size: 22),
                    label: const Text('Sign with Biometric'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or sign with password',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password (re-authentication required)',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sign(),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: _windowExpired ? null : () => _pop(null),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: (_signing || _windowExpired) ? null : _sign,
                        child: _signing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Sign with Password'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EsignatureScreen extends StatefulWidget {
  const EsignatureScreen({
    super.key,
    required this.entityType,
    required this.entityId,
    this.signatureMeaning,
    this.userId,
  });

  final String entityType;
  final String entityId;
  final String? signatureMeaning;
  final int? userId;

  @override
  State<EsignatureScreen> createState() => _EsignatureScreenState();
}

class _EsignatureScreenState extends State<EsignatureScreen> {
  final _passwordController = TextEditingController();
  bool _signing = false;
  String? _error;
  List<SignatureMeaning> _meanings = [];
  String? _selectedMeaning;
  bool _loadingMeanings = true;
  int _countdownSeconds = 60;
  bool _windowExpired = false;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _loadMeanings();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _countdownSeconds--;
        if (_countdownSeconds <= 0) {
          _countdownSeconds = 0;
          _windowExpired = true;
          _countdownTimer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadMeanings() async {
    try {
      final meanings = await client.training.listSignatureMeanings();
      if (mounted) {
        setState(() {
          _meanings = meanings;
          if (meanings.isNotEmpty) {
            final preferred = widget.signatureMeaning;
            _selectedMeaning = (preferred != null &&
                    meanings.any((m) => m.meaning == preferred))
                ? preferred
                : meanings.first.meaning;
          } else {
            _selectedMeaning =
                widget.signatureMeaning ?? 'I have read and understood';
          }
          _loadingMeanings = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _selectedMeaning =
              widget.signatureMeaning ?? 'I have read and understood';
          _loadingMeanings = false;
        });
      }
    }
  }

  Future<void> _sign() async {
    if (_windowExpired) return;
    final userId = widget.userId;
    if (userId == null) {
      if (mounted) Navigator.of(context).pop<int?>(null);
      return;
    }

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _error = 'Password is required for re-authentication.');
      return;
    }

    setState(() {
      _signing = true;
      _error = null;
    });

    final meaning = _selectedMeaning ?? 'I have read and understood';
    try {
      final esignatureId = await client.training.createTrainingSignature(
        userId: userId,
        signatureMeaning: meaning,
        entityType: widget.entityType,
        entityId: widget.entityId,
        passwordReauth: password,
      );
      if (mounted) {
        Navigator.of(context).pop<int>(esignatureId);
      }
    } catch (e) {
      setState(() {
        _signing = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronic Signature'),
        actions: [
          if (!_windowExpired)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '$_countdownSeconds s',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _countdownSeconds <= 10
                        ? AppColors.destructive
                        : AppColors.teal600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_windowExpired) ...[
              Card(
                color: AppColors.destructive.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_off, color: AppColors.destructive),
                          const SizedBox(width: 12),
                          Text(
                            'Re-auth window expired',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.destructive,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Re-open your result to sign.',
                        style: TextStyle(color: AppColors.slate700),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop<int?>(null),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_loadingMeanings)
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ))
                    else if (_meanings.isNotEmpty)
                      DropdownButtonFormField<String>(
                        value: _selectedMeaning,
                        decoration: const InputDecoration(
                          labelText: 'Signature Meaning',
                          border: OutlineInputBorder(),
                        ),
                        items: _meanings
                            .map((m) => DropdownMenuItem<String>(
                                  value: m.meaning,
                                  child: Text(m.meaning),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedMeaning = v ?? _selectedMeaning),
                      )
                    else
                      Text(
                        _selectedMeaning ?? 'I have read and understood',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    const SizedBox(height: 8),
                    const Text(
                      '21 CFR Part 11 compliant. Password re-authentication required.',
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password (re-authentication required)',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sign(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'By signing, you confirm your identity and intent.',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Colors.red[700]),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (_signing || _windowExpired) ? null : _sign,
              child: _signing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_windowExpired ? 'Expired' : 'Sign'),
            ),
            ],
          ],
        ),
      ),
    );
  }
}
