import 'package:flutter/material.dart';
import '../../../design_system/pharma_design_system.dart';
import '../../../design_system/pharma_components.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ADMIN PAGE SCAFFOLD — Phase 5 shared page-level wrappers
// ═══════════════════════════════════════════════════════════════════════════════
//
// Follows the "Clinical Archive" tonal architecture:
//   - Surface-container-low background
//   - No-border cards, atmospheric shadow
//   - Indigo-700 accent, DC2626 critical, 059669 success
//
// AdminPageScaffold  — responsive padding + page header (for NEW screens)
// AdminPageLoading   — skeleton shimmer matching admin tonal palette
// AdminPageError     — error state with retry (clinical styling)
// AdminPageEmpty     — empty state (clinical styling)
// ═══════════════════════════════════════════════════════════════════════════════

/// Admin accent colour — indigo-700 from clinical archive palette
const kAdminAccent = PharmaColors.clinicalPrimary;

// ─── ADMIN PAGE SCAFFOLD ─────────────────────────────────────────────────────

/// Top-level page wrapper for admin screens that don't already use AdminPageFrame.
/// Provides responsive padding, a page header, and optional action row.
class AdminPageScaffold extends StatelessWidget {
  const AdminPageScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actions = const [],
    required this.child,
    this.scrollable = true,
    this.onRefresh,
    this.versionBadge,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget> actions;
  final Widget child;
  final bool scrollable;
  final Future<void> Function()? onRefresh;
  final String? versionBadge;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final hPad = width > 1200 ? 32.0 : width > 800 ? 24.0 : 16.0;

    Widget body = Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Version badge
          if (versionBadge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: PharmaColors.clinicalSurfaceContainerHighest,
                borderRadius: PharmaRadius.clinicalCardRadius,
              ),
              child: Text(
                versionBadge!,
                style: PharmaTypography.clinicalLabel.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Page header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 28, color: kAdminAccent),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: PharmaTypography.clinicalHeadline),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: PharmaTypography.clinicalBody,
                      ),
                    ],
                  ],
                ),
              ),
              if (actions.isNotEmpty)
                Wrap(spacing: 8, runSpacing: 8, children: actions),
            ],
          ),
          const SizedBox(height: 24),
          // Content
          if (scrollable)
            Expanded(child: child)
          else
            child,
        ],
      ),
    );

    if (onRefresh != null) {
      body = RefreshIndicator(onRefresh: onRefresh!, child: body);
    }

    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      child: body,
    );
  }
}

// ─── ADMIN PAGE LOADING ──────────────────────────────────────────────────────

/// Skeleton shimmer state for admin portal pages.
/// Uses the clinical tonal palette for a cohesive look.
class AdminPageLoading extends StatelessWidget {
  const AdminPageLoading({super.key, this.cardCount = 3});

  /// How many placeholder cards to show.
  final int cardCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer header
          const PharmaSkeletonLoader(
            width: 220,
            height: 24,
            borderRadius: 6,
          ),
          const SizedBox(height: 8),
          const PharmaSkeletonLoader(
            width: 160,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 24),
          // KPI row shimmer
          Row(
            children: List.generate(
              3,
              (_) => const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: PharmaSkeletonLoader(
                    width: double.infinity,
                    height: 72,
                    borderRadius: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Card placeholders
          ...List.generate(
            cardCount,
            (i) => const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: PharmaSkeletonLoader(
                width: double.infinity,
                height: 80,
                borderRadius: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── ADMIN PAGE ERROR ────────────────────────────────────────────────────────

/// Error state for admin portal pages with a retry button.
class AdminPageError extends StatelessWidget {
  const AdminPageError({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      padding: const EdgeInsets.all(48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: PharmaColors.dangerBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded,
                    size: 32, color: PharmaColors.danger),
              ),
              const SizedBox(height: 20),
              Text(
                'Something went wrong',
                style: PharmaTypography.clinicalTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: PharmaTypography.clinicalBody,
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Try again'),
                  style: FilledButton.styleFrom(
                    backgroundColor: kAdminAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── ADMIN PAGE EMPTY ────────────────────────────────────────────────────────

/// Empty-state for admin portal pages.
class AdminPageEmpty extends StatelessWidget {
  const AdminPageEmpty({
    super.key,
    this.icon = Icons.folder_open_rounded,
    required this.title,
    this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PharmaColors.clinicalSurfaceContainerLow,
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: PharmaColors.clinicalSurfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  size: 32,
                  color: PharmaColors.clinicalOnSurfaceVariant),
            ),
            const SizedBox(height: 20),
            Text(title,
                style: PharmaTypography.clinicalTitle,
                textAlign: TextAlign.center),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!,
                  style: PharmaTypography.clinicalBody,
                  textAlign: TextAlign.center),
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
