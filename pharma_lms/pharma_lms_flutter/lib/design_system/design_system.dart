// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — DESIGN SYSTEM BARREL EXPORT
// ═══════════════════════════════════════════════════════════════════════════════
//
// Import this file to access all design tokens, components, and utilities:
//
//   import 'package:pharma_lms_flutter/design_system/design_system.dart';
//
// Canonical token system:
// - pharma_design_system.dart: PharmaColors, PharmaSpacing, PharmaRadius,
//                              PharmaShadows, PharmaTypography, PharmaDurations,
//                              PharmaSizing, PortalLayout, PharmaBrand,
//                              PharmaStatus enum
//
// Components:
// - pharma_components.dart:    PharmaCard, VyuhLogo, etc.
// - components.dart:           StatusPill, ComplianceAlertBanner, ProgressRing,
//                              CourseCard, StatCard, etc.
//
// Legacy compatibility (tokens.dart): AppColors, AppSpacing, AppRadius,
//   AppShadows, AppDurations, AppTypography, AppSizing, TrainingStatus, etc.
//
// Responsive utilities:
// - responsive.dart:           ResponsiveBuilder, ResponsiveValue, ResponsiveGrid,
//                              Breakpoint, PharmaBreakpoints, context extensions
// ═══════════════════════════════════════════════════════════════════════════════

// ─── Canonical design tokens (use these for all new code) ───
export 'pharma_design_system.dart';

// ─── Components ───
export 'pharma_components.dart';
export 'components.dart';

// ─── Legacy compatibility (old tokens still used by many screens) ───
export 'tokens.dart';

// ─── Responsive utilities ───
export 'responsive.dart';
