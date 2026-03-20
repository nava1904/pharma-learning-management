// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — NOT FOUND / INVALID ROUTE
// ═══════════════════════════════════════════════════════════════════════════════
//
// Shown when the user navigates to an unknown route. Fills the viewport with
// no side gaps; provides a clear message and link back to home/dashboard.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/pharma_design_system.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    this.message,
    this.uri,
  });

  final String? message;
  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PharmaColors.pageBg,
      body: SizedBox.expand(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64,
                  color: PharmaColors.textTertiary,
                ),
                const SizedBox(height: PharmaSpacing.lg),
                Text(
                  'Page not found',
                  style: PharmaTypography.headingMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  message ??
                      (uri != null
                          ? 'The path "${uri!.path}" could not be found.'
                          : 'The page you\'re looking for doesn\'t exist or has been moved.'),
                  style: PharmaTypography.body.copyWith(
                    color: PharmaColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: PharmaSpacing.xxl),
                FilledButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.home_rounded, size: 18),
                  label: const Text('Go to home'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    foregroundColor: PharmaColors.cardBg,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: PharmaRadius.buttonRadius,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
