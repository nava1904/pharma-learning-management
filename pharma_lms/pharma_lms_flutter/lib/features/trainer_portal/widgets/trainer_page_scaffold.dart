// =============================================================================
// Vyuh lms -- TRAINER PAGE SCAFFOLD
// =============================================================================
//
// Shared page wrapper for every trainer portal screen.
// Provides: responsive padding, page header with status badge,
// optional action buttons, loading/error/empty states.
//
// Usage:
//   TrainerPageScaffold(
//     title: 'Course Library',
//     subtitle: '12 courses',
//     icon: Icons.menu_book_rounded,
//     actions: [PharmaButton(...)],
//     child: _buildContent(),
//   )
// =============================================================================

import 'package:flutter/material.dart';

import '../../../design_system/pharma_design_system.dart';
import '../../../design_system/pharma_components.dart';
import '../../../design_system/responsive.dart';

// Trainer accent color used across the portal
const Color kTrainerAccent = PharmaColors.emerald600;

/// Consistent page wrapper for all trainer portal content screens.
///
/// Provides:
/// - Responsive padding (16px mobile / 24px tablet / 32px desktop)
/// - Page header with icon, title, subtitle, optional status badge
/// - Optional action buttons row
/// - Standard loading / error / empty states
class TrainerPageScaffold extends StatelessWidget {
  const TrainerPageScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actions,
    this.statusBadge,
    required this.child,
    this.scrollable = true,
    this.onRefresh,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;

  /// Optional status badge shown next to title (e.g., "DRAFT", "QA APPROVED")
  final Widget? statusBadge;

  final Widget child;
  final bool scrollable;
  final Future<void> Function()? onRefresh;

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
          // -- PAGE HEADER --
          _TrainerPageHeader(
            title: title,
            subtitle: subtitle,
            icon: icon,
            actions: actions,
            statusBadge: statusBadge,
          ),
          const SizedBox(height: PharmaSpacing.lg),
          // -- CONTENT --
          if (scrollable) Expanded(child: child) else child,
        ],
      ),
    );

    if (scrollable) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: body)],
      );
    }

    if (onRefresh != null) {
      return RefreshIndicator(
        color: kTrainerAccent,
        onRefresh: onRefresh!,
        child: body,
      );
    }
    return body;
  }
}

// ---------------------------------------------------------------------------
// PAGE HEADER
// ---------------------------------------------------------------------------

class _TrainerPageHeader extends StatelessWidget {
  const _TrainerPageHeader({
    required this.title,
    this.subtitle,
    this.icon,
    this.actions,
    this.statusBadge,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;
  final Widget? statusBadge;

  @override
  Widget build(BuildContext context) {
    final bp = context.responsive;
    final isNarrow = bp == Breakpoint.mobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNarrow && actions != null && actions!.isNotEmpty)
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
              if (actions != null)
                ...actions!.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: a,
                  ),
                ),
            ],
          ),
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
          Icon(icon, size: 24, color: kTrainerAccent),
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
        if (statusBadge != null) ...[
          const SizedBox(width: PharmaSpacing.sm),
          statusBadge!,
        ],
      ],
    );
  }
}

// =============================================================================
// LOADING STATE
// =============================================================================

/// Animated loading skeleton for trainer pages.
class TrainerPageLoading extends StatelessWidget {
  const TrainerPageLoading({super.key, this.cardCount = 3});

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
          PharmaSkeletonLoader(
            width: 220,
            height: 24,
            borderRadius: PharmaRadius.sm,
          ),
          const SizedBox(height: 6),
          PharmaSkeletonLoader(
            width: 320,
            height: 14,
            borderRadius: PharmaRadius.sm,
          ),
          const SizedBox(height: PharmaSpacing.xl),
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

// =============================================================================
// ERROR STATE
// =============================================================================

class TrainerPageError extends StatelessWidget {
  const TrainerPageError({
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
            Text('Something went wrong', style: PharmaTypography.headingMedium),
            const SizedBox(height: 8),
            Text(
              message,
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: PharmaSpacing.lg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Try Again'),
                style: FilledButton.styleFrom(
                  backgroundColor: kTrainerAccent,
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

// =============================================================================
// EMPTY STATE
// =============================================================================

class TrainerPageEmpty extends StatelessWidget {
  const TrainerPageEmpty({
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
              child: Icon(icon, size: 48, color: kTrainerAccent),
            ),
            const SizedBox(height: PharmaSpacing.lg),
            Text(title, style: PharmaTypography.headingMedium),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
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

// =============================================================================
// WORKFLOW STATUS BADGE — used with TrainerPageScaffold.statusBadge
// =============================================================================

/// Small pill badge for course workflow status (DRAFT, UNDER REVIEW, etc.)
class WorkflowStatusBadge extends StatelessWidget {
  const WorkflowStatusBadge({super.key, required this.label, this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? PharmaColors.gray500;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: PharmaRadius.pillRadius,
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: PharmaTypography.labelSmall.copyWith(
          color: c,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
