import 'package:flutter/material.dart';

class AccessReviewJustificationDialog extends StatefulWidget {
  final String action;
  final void Function(String justification) onSubmit;
  const AccessReviewJustificationDialog({super.key, required this.action, required this.onSubmit});

  @override
  State<AccessReviewJustificationDialog> createState() => _AccessReviewJustificationDialogState();
}

class _AccessReviewJustificationDialogState extends State<AccessReviewJustificationDialog> {
  final _controller = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.action} Access'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('A justification is required to ${widget.action.toLowerCase()} this user.'),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Justification',
              errorText: _error,
            ),
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
            if (_controller.text.trim().isEmpty) {
              setState(() => _error = 'Justification cannot be empty');
              return;
            }
            widget.onSubmit(_controller.text.trim());
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
