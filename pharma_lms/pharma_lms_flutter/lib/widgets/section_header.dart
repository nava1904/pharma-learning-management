import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Odoo-style section header with icon and optional action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.color,
    this.action,
  });

  final IconData icon;
  final String title;
  final Color? color;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.indigo600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: c),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate800,
                  ),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
