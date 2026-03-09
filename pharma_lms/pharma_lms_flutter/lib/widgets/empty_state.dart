import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Empty state - Odoo-inspired with headline, subtext, optional CTA.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.message = 'No data',
    this.icon = Icons.inbox_outlined,
    this.headline,
    this.subtext,
    this.action,
  });

  final String message;
  final IconData icon;
  final String? headline;
  final String? subtext;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppColors.slate400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              headline ?? message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
              textAlign: TextAlign.center,
            ),
            if (subtext != null) ...[
              const SizedBox(height: 8),
              Text(
                subtext!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate600,
                    ),
                textAlign: TextAlign.center,
              ),
            ] else if (headline != null) ...[
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
