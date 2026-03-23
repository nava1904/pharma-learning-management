import 'package:flutter/material.dart';

class AccessReviewESignatureDialog extends StatefulWidget {
  final void Function(String password, String reason) onSign;
  const AccessReviewESignatureDialog({super.key, required this.onSign});

  @override
  State<AccessReviewESignatureDialog> createState() => _AccessReviewESignatureDialogState();
}

class _AccessReviewESignatureDialogState extends State<AccessReviewESignatureDialog> {
  final _passwordController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('E-Signature Required (21 CFR 11.50)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reasonController,
            decoration: const InputDecoration(labelText: 'Signing Reason'),
          ),
          const SizedBox(height: 12),
          const Text(
            'I certify that this action represents my electronic signature and is legally binding.',
            style: TextStyle(fontSize: 12),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_passwordController.text.isEmpty || _reasonController.text.isEmpty) {
              setState(() => _error = 'Password and reason are required');
              return;
            }
            widget.onSign(_passwordController.text, _reasonController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Sign'),
        ),
      ],
    );
  }
}
