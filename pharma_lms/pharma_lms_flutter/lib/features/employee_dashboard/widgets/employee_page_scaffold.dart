// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — EMPLOYEE PAGE SCAFFOLD
// ═══════════════════════════════════════════════════════════════════════════════
//
// Shared page wrapper for every employee portal screen.
// Provides: responsive padding, page header, optional breadcrumbs,
// optional action buttons, pull-to-refresh, and loading/error states.
//
// Usage:
//   EmployeePageScaffold(
//     title: 'My Learning',
//     subtitle: 'Your enrolled courses',
//     icon: Icons.school_rounded,
//     actions: [PharmaButton(...)],
//     child: _buildContent(),
//   )
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

import '../../../design_system/pharma_design_system.dart';
import '../../../design_system/pharma_components.dart';
import '../../../design_system/responsive.dart';

/// Consistent page wrapper for all employee portal content screens.
///
/// Provides:
/// - Responsive padding (16px mobile / 24px tablet / 32px desktop)
/// - Page header with icon, title, subtitle
/// - Optional action buttons row
/// - Optional pull-to-refresh
/// - Standard loading / error / empty states
class EmployeePageScaffold extends StatelessWidget {
  const EmployeePageScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actions,
    this.onRefresh,
    required this.child,
    this.floatingActionButton,
    this.scrollable = true,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;
  final Future<void> Function()? onRefresh;
  final Widget child;
  final Widget? floatingActionButton;

  /// When true, wraps child in SingleChildScrollView. Set false if child
  /// already scrolls (e.g., ListView, CustomScrollView).
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final bp = context.responsive;
    final horizontalPad = switch (bp) {
      Breakpoint.mobile => PharmaSpacing.md,
      Breakpoint.tablet => PharmaSpacing.lg,
      _ => PharmaSpacing.xl,
    };

    Widget body = Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: PharmaSpacing.md),
          // ── PAGE HEADER ──
          _PageHeader(
            title: title,
            subtitle: subtitle,
            icon: icon,
            actions: actions,
          ),
          const SizedBox(height: PharmaSpacing.lg),
          // ── CONTENT ──
          if (scrollable)
            Expanded(child: child)
          else
            child,
        ],
      ),
    );

    if (scrollable) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: body),
        ],
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        color: PharmaColors.emerald600,
        onRefresh: onRefresh!,
        child: body,
      );
    }
    return body;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.title,
    this.subtitle,
    this.icon,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final bp = context.responsive;
    final isNarrow = bp == Breakpoint.mobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row (icon + title + actions)
        if (isNarrow && actions != null && actions!.isNotEmpty)
          // Stack vertically on mobile
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(),
              const SizedBox(height: PharmaSpacing.sm),
              Wrap(spacing: 8, runSpacing: 8, children: actions!),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildTitleRow()),
              if (actions != null) ...actions!.map((a) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: a,
              )),
            ],
          ),
        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: PharmaTypography.body.copyWith(
              color: PharmaColors.textTertiary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 24, color: PharmaColors.emerald600),
          const SizedBox(width: PharmaSpacing.sm),
        ],
        Flexible(
          child: Text(
            title,
            style: PharmaTypography.headingLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// LOADING STATE — used by employee screens with EmployeePageScaffold
// ═══════════════════════════════════════════════════════════════════════════════

/// Animated loading skeleton for employee pages.
/// Shows a shimmer header + 3 skeleton cards.
class EmployeePageLoading extends StatelessWidget {
  const EmployeePageLoading({super.key, this.cardCount = 3});

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final bp = context.responsive;
    final horizontalPad = switch (bp) {
      Breakpoint.mobile => PharmaSpacing.md,
      Breakpoint.tablet => PharmaSpacing.lg,
      _ => PharmaSpacing.xl,
    };

    return Padding(
      padding: EdgeInsets.all(horizontalPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: PharmaSpacing.md),
          // Title skeleton
          PharmaSkeletonLoader(
            width: 200,
            height: 24,
            borderRadius: PharmaRadius.sm,
          ),
          const SizedBox(height: 6),
          PharmaSkeletonLoader(
            width: 300,
            height: 14,
            borderRadius: PharmaRadius.sm,
          ),
          const SizedBox(height: PharmaSpacing.xl),
          // Card skeletons
          for (var i = 0; i < cardCount; i++) ...[
            PharmaSkeletonLoader(
              width: double.infinity,
              height: 120,
              borderRadius: PharmaRadius.lg,
            ),
            const SizedBox(height: PharmaSpacing.md),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ERROR STATE — used by employee screens with EmployeePageScaffold
// ═══════════════════════════════════════════════════════════════════════════════

/// Standard error state for employee pages.
class EmployeePageError extends StatelessWidget {
  const EmployeePageError({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
  });

  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: PharmaColors.danger.withValues(alpha: 0.6)),
            const SizedBox(height: PharmaSpacing.md),
            Text(
              'Something went wrong',
              style: PharmaTypography.headingMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: PharmaTypography.body.copyWith(
                color: PharmaColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: PharmaSpacing.lg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Try Again'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  padding: const EdgeInsets.symmetric(
                    horizontal: PharmaSpacing.lg,
                    vertical: PharmaSpacing.md,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPTY STATE — used by employee screens
// ═══════════════════════════════════════════════════════════════════════════════

/// Standard empty state for employee pages.
class EmployeePageEmpty extends StatelessWidget {
  const EmployeePageEmpty({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_rounded,
    this.action,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PharmaSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(PharmaSpacing.lg),
              decoration: BoxDecoration(
                color: PharmaColors.emerald50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: PharmaColors.emerald600),
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Text(title, style: PharmaTypography.headingMedium),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: PharmaSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
