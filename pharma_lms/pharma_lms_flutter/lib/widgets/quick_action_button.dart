import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Large action button with icon and text for dashboards.
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.indigo50,
    this.borderColor = AppColors.indigo200,
    this.iconColor = AppColors.indigo600,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
