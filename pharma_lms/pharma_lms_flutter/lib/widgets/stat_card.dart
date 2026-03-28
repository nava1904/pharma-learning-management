import 'package:flutter/material.dart';

import '../design_system/pharma_design_system.dart';

/// Stat card for dashboard metrics (label, value, icon).
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconBackgroundColor = PharmaColors.infoBg,
    this.iconColor = PharmaColors.info,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: PharmaTypography.headingMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: PharmaColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: PharmaSpacing.sm),
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.md),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: PharmaRadius.cardRadius,
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
        ],
      ),
    );
  }
}
