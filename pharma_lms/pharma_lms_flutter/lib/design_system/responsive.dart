// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — RESPONSIVE UTILITIES
// ═══════════════════════════════════════════════════════════════════════════════
//
// Breakpoint-aware layout helpers for mobile/tablet/desktop/wide screens.
// Based on Tailwind CSS breakpoint system:
//   mobile:  < 600px    (phones, portrait)
//   tablet:  600–1024px (tablets, small laptops)
//   desktop: 1024–1440px (standard laptops/monitors)
//   wide:    > 1440px   (ultrawide / large monitors)
//
// Usage:
//   ResponsiveBuilder(
//     mobile: (ctx) => MobileLayout(),
//     tablet: (ctx) => TabletLayout(),
//     desktop: (ctx) => DesktopLayout(),
//   )
//
//   // or via context extension:
//   context.responsive   // → Breakpoint enum
//   context.isMobile     // → bool
//   context.isTabletUp   // → bool
//
//   // typed per-breakpoint value:
//   final cols = ResponsiveValue<int>(mobile: 1, tablet: 2, desktop: 3).resolve(context);
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BREAKPOINTS
// ─────────────────────────────────────────────────────────────────────────────

enum Breakpoint { mobile, tablet, desktop, wide }

abstract class PharmaBreakpoints {
  PharmaBreakpoints._();

  static const double mobile = 0;
  static const double tablet = 600;
  static const double desktop = 1024;
  static const double wide = 1440;

  /// Returns the current [Breakpoint] for [width].
  static Breakpoint resolve(double width) {
    if (width >= wide) return Breakpoint.wide;
    if (width >= desktop) return Breakpoint.desktop;
    if (width >= tablet) return Breakpoint.tablet;
    return Breakpoint.mobile;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTEXT EXTENSIONS
// ─────────────────────────────────────────────────────────────────────────────

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  Breakpoint get responsive => PharmaBreakpoints.resolve(screenWidth);

  bool get isMobile => responsive == Breakpoint.mobile;
  bool get isTablet => responsive == Breakpoint.tablet;
  bool get isDesktop => responsive == Breakpoint.desktop;
  bool get isWide => responsive == Breakpoint.wide;

  /// True for tablet and above.
  bool get isTabletUp => screenWidth >= PharmaBreakpoints.tablet;

  /// True for desktop and above.
  bool get isDesktopUp => screenWidth >= PharmaBreakpoints.desktop;

  /// True for wide and above.
  bool get isWideUp => screenWidth >= PharmaBreakpoints.wide;

  /// Resolve a per-breakpoint value.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? wide,
  }) {
    switch (responsive) {
      case Breakpoint.wide:
        return wide ?? desktop ?? tablet ?? mobile;
      case Breakpoint.desktop:
        return desktop ?? tablet ?? mobile;
      case Breakpoint.tablet:
        return tablet ?? mobile;
      case Breakpoint.mobile:
        return mobile;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE VALUE
// ─────────────────────────────────────────────────────────────────────────────

/// A typed, per-breakpoint value that resolves at build time.
///
/// ```dart
/// final padding = ResponsiveValue<double>(
///   mobile: 16,
///   tablet: 24,
///   desktop: 32,
/// ).resolve(context);
/// ```
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? wide;

  T resolve(BuildContext context) {
    return context.responsiveValue(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      wide: wide,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE BUILDER
// ─────────────────────────────────────────────────────────────────────────────

/// Widget that rebuilds based on current breakpoint.
///
/// Falls back gracefully: if no `tablet` builder is supplied, uses `mobile`.
///
/// ```dart
/// ResponsiveBuilder(
///   mobile: (_) => SingleColumnLayout(),
///   tablet: (_) => TwoColumnLayout(),
///   desktop: (_) => ThreeColumnLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
  });

  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  final Widget Function(BuildContext context)? wide;

  @override
  Widget build(BuildContext context) {
    switch (context.responsive) {
      case Breakpoint.wide:
        return (wide ?? desktop ?? tablet ?? mobile)(context);
      case Breakpoint.desktop:
        return (desktop ?? tablet ?? mobile)(context);
      case Breakpoint.tablet:
        return (tablet ?? mobile)(context);
      case Breakpoint.mobile:
        return mobile(context);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE GRID
// ─────────────────────────────────────────────────────────────────────────────

/// Auto-column grid that adapts to breakpoints.
///
/// ```dart
/// ResponsiveGrid(
///   mobileColumns: 1,
///   tabletColumns: 2,
///   desktopColumns: 3,
///   spacing: 16,
///   children: cards,
/// )
/// ```
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.wideColumns,
    this.spacing = 16,
    this.runSpacing = 16,
    this.childAspectRatio = 1.0,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final int? wideColumns;
  final double spacing;
  final double runSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final columns = context.responsiveValue(
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
      wide: wideColumns,
    );

    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: runSpacing,
      crossAxisSpacing: spacing,
      childAspectRatio: childAspectRatio,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE PADDING
// ─────────────────────────────────────────────────────────────────────────────

/// Applies breakpoint-aware padding.
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobilePadding = const EdgeInsets.all(16),
    this.tabletPadding,
    this.desktopPadding,
    this.widePadding,
  });

  final Widget child;
  final EdgeInsetsGeometry mobilePadding;
  final EdgeInsetsGeometry? tabletPadding;
  final EdgeInsetsGeometry? desktopPadding;
  final EdgeInsetsGeometry? widePadding;

  @override
  Widget build(BuildContext context) {
    final padding = context.responsiveValue(
      mobile: mobilePadding,
      tablet: tabletPadding,
      desktop: desktopPadding,
      wide: widePadding,
    );
    return Padding(padding: padding, child: child);
  }
}
