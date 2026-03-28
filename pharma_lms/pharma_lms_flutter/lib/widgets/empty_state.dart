import 'package:flutter/material.dart';

import '../design_system/pharma_design_system.dart';

/// Empty state — headline, subtext, optional CTA.
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
      padding: const EdgeInsets.all(PharmaSpacing.xxxl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.xxl),
              decoration: const BoxDecoration(
                color: PharmaColors.gray100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: PharmaColors.textQuaternary,
              ),
            ),
            const SizedBox(height: PharmaSpacing.xxl),
            Text(
              headline ?? message,
              style: PharmaTypography.headingSmall.copyWith(
                fontWeight: FontWeight.w600,
                color: PharmaColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtext != null) ...[
              const SizedBox(height: PharmaSpacing.sm),
              Text(
                subtext!,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ] else if (headline != null) ...[
              const SizedBox(height: PharmaSpacing.sm),
              Text(
                message,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: PharmaSpacing.xxl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
