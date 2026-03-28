import 'package:flutter/material.dart';

import '../core/client.dart';
import '../design_system/pharma_design_system.dart';

/// Part 11 step-up: printed name, UTC timestamp, meaning, password verification
/// (uses [TrainingEndpoint.issueBiometricToken] to verify password without creating a signature row).
Future<bool> showPart11StepUpDialog({
  required BuildContext context,
  required int userId,
  required String printedName,
  required String title,
  required String attestText,
  List<String>? meanings,
}) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => _Part11StepUpDialog(
          userId: userId,
          printedName: printedName,
          title: title,
          attestText: attestText,
          meanings: meanings,
        ),
      ) ??
      false;
}

class _Part11StepUpDialog extends StatefulWidget {
  const _Part11StepUpDialog({
    required this.userId,
    required this.printedName,
    required this.title,
    required this.attestText,
    this.meanings,
  });

  final int userId;
  final String printedName;
  final String title;
  final String attestText;
  final List<String>? meanings;

  @override
  State<_Part11StepUpDialog> createState() => _Part11StepUpDialogState();
}

class _Part11StepUpDialogState extends State<_Part11StepUpDialog> {
  final _passwordController = TextEditingController();
  String? _selectedMeaning;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final m = widget.meanings;
    _selectedMeaning = (m != null && m.isNotEmpty) ? m.first : 'I attest to the statement below.';
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pw = _passwordController.text.trim();
    if (pw.isEmpty) {
      setState(() => _error = 'Password is required for re-authentication.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await client.training.issueBiometricToken(
        userId: widget.userId,
        passwordPlaintext: pw,
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = 'Re-authentication failed. Check your password.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final ts =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} UTC';

    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Signature manifestation',
              style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text('Signer (printed name): ${widget.printedName}', style: PharmaTypography.body),
            const SizedBox(height: 4),
            Text('Timestamp: $ts', style: PharmaTypography.caption.copyWith(fontFamily: 'monospace')),
            const SizedBox(height: 12),
            Text(widget.attestText, style: PharmaTypography.body),
            const SizedBox(height: 16),
            if (widget.meanings != null && widget.meanings!.length > 1)
              DropdownButtonFormField<String>(
                initialValue: _selectedMeaning,
                decoration: const InputDecoration(
                  labelText: 'Meaning',
                  border: OutlineInputBorder(),
                ),
                items: widget.meanings!
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMeaning = v),
              )
            else
              Text(
                'Meaning: $_selectedMeaning',
                style: PharmaTypography.caption,
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password (re-authentication)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Colors.red.shade700, fontSize: 12)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Continue'),
        ),
      ],
    );
  }
}
