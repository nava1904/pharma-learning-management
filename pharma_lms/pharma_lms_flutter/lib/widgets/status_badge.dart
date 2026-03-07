import 'package:flutter/material.dart';

/// Status chip for training assignments.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  static Color _backgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFFDCFCE7);
      case 'in_progress':
      case 'in-progress':
        return const Color(0xFFDBEAFE);
      case 'overdue':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFFEF9C3);
    }
  }

  static Color _foregroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF166534);
      case 'in_progress':
      case 'in-progress':
        return const Color(0xFF1D4ED8);
      case 'overdue':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF854D0E);
    }
  }

  String get _displayText {
    return status.replaceAll('-', ' ').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor(status),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _displayText,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _foregroundColor(status),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
