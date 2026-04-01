// ═══════════════════════════════════════════════════════════════════════════════
// Vyuh lms — design system v2
// ═══════════════════════════════════════════════════════════════════════════════
//
// Reverse-engineered from React/Tailwind reference learner dashboard patterns.
// This is the single source of truth for all visual tokens.
//
// Color Palette extracted from Tailwind classes:
// - bg-gray-50, bg-white, border-gray-200
// - text-gray-900, text-gray-600, text-gray-500
// - bg-emerald-600, text-emerald-600 (Primary accent)
// - bg-emerald-100, text-emerald-700 (Success states)
// - bg-blue-100, text-blue-700 (In Progress states)
// - bg-green-100, text-green-700 (Completed states)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE — EXACT TAILWIND MATCHES
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaColors {
  PharmaColors._();

  // ─────────────────────────────────────────────────────────────────────────────
  // BACKGROUNDS (From React: bg-gray-50, bg-white)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color pageBg = Color(0xFFF9FAFB);        // gray-50: Main app background
  static const Color cardBg = Color(0xFFFFFFFF);        // white: Cards, panels, sidebar
  static const Color sidebarBg = Color(0xFFFFFFFF);     // white: Sidebar background
  static const Color inputBg = Color(0xFFFFFFFF);       // white: Input fields

  // ─────────────────────────────────────────────────────────────────────────────
  // BORDERS (From React: border-gray-200, border-gray-300)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color borderLight = Color(0xFFE5E7EB);   // gray-200: Card borders, dividers
  static const Color borderMedium = Color(0xFFD1D5DB);  // gray-300: Button borders
  static const Color borderFocus = Color(0xFF10B981);   // emerald-500: Focus rings

  // ─────────────────────────────────────────────────────────────────────────────
  // TEXT COLORS (From React: text-gray-900, text-gray-600, text-gray-500)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111827);   // gray-900: Headings, emphasis
  static const Color textSecondary = Color(0xFF4B5563); // gray-600: Body text
  static const Color textTertiary = Color(0xFF6B7280);  // gray-500: Muted/helper text
  static const Color textQuaternary = Color(0xFF9CA3AF); // gray-400: Placeholders

  // ─────────────────────────────────────────────────────────────────────────────
  // PRIMARY BRAND — EMERALD (From React: bg-emerald-600, text-emerald-600)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald200 = Color(0xFFA7F3D0);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);    // PRIMARY CTA color
  static const Color emerald700 = Color(0xFF047857);    // Hover state

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: SUCCESS / COMPLETED (From React: bg-green-100, text-green-700)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color successBg = Color(0xFFDCFCE7);     // green-100
  static const Color successText = Color(0xFF15803D);   // green-700
  static const Color success = Color(0xFF16A34A);       // green-600

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: INFO / IN PROGRESS (From React: bg-blue-100, text-blue-700)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color infoBg = Color(0xFFDBEAFE);        // blue-100
  static const Color infoText = Color(0xFF1D4ED8);      // blue-700
  static const Color info = Color(0xFF2563EB);          // blue-600

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: WARNING / OVERDUE — PHARMA COMPLIANCE CRITICAL
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color warningBg = Color(0xFFFEF3C7);     // amber-100
  static const Color warningText = Color(0xFFB45309);   // amber-700
  static const Color warning = Color(0xFFD97706);       // amber-600

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: DANGER / ERROR — FDA 21 CFR PART 11 ALERTS
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color dangerBg = Color(0xFFFEE2E2);      // red-100
  static const Color dangerText = Color(0xFFB91C1C);    // red-700
  static const Color danger = Color(0xFFDC2626);        // red-600

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: ORANGE — SOP RETRAINING (FRD SCR-18)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color orangeBg = Color(0xFFFFF7ED);       // orange-50
  static const Color orangeText = Color(0xFFC2410C);    // orange-700
  static const Color orange = Color(0xFFEA580C);        // orange-600

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC: PURPLE — CAPA / WAIVER / DEVIATION (FRD SCR-19)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color purpleBg = Color(0xFFF5F3FF);       // violet-50
  static const Color purpleText = Color(0xFF6D28D9);    // violet-700
  static const Color purple = Color(0xFF7C3AED);        // violet-600

  // ─────────────────────────────────────────────────────────────────────────────
  // ICON CONTAINERS (From React: bg-gray-900 for stat icons)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color iconContainerDark = Color(0xFF111827);  // gray-900
  static const Color iconContainerLight = Color(0xFFF3F4F6); // gray-100

  // ─────────────────────────────────────────────────────────────────────────────
  // CHARTS — Alternating bar colors from React design
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color chartPrimary = Color(0xFF10B981);   // emerald-500
  static const Color chartSecondary = Color(0xFFF97316); // orange-500 (alternating bars)
  static const Color chartTertiary = Color(0xFF06B6D4);  // cyan-500

  // ─────────────────────────────────────────────────────────────────────────────
  // GRAY SCALE (Full Tailwind gray palette)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Aliases for common use
  static const Color background = pageBg;
  static const Color surface = cardBg;
  static const Color border = borderLight;
  static const Color primary = emerald600;

  // ─────────────────────────────────────────────────────────────────────────────
  // STITCH "CLINICAL ARCHIVE" DESIGN SYSTEM — Admin Portal Palette
  // ─────────────────────────────────────────────────────────────────────────────
  // From stitch_compliance_focused_dashboard DESIGN.md
  // Tonal Architecture: No borders — depth through color shifts
  // ─────────────────────────────────────────────────────────────────────────────

  // PRIMARY — Deep Navy (authority, actions, navigation headers)
  static const Color clinicalPrimary = Color(0xFF545F73);
  static const Color clinicalPrimaryDim = Color(0xFF485367);
  static const Color clinicalPrimaryContainer = Color(0xFFD8E3FB);
  static const Color clinicalPrimaryFixed = Color(0xFFD8E3FB);
  static const Color clinicalOnPrimary = Color(0xFFF6F7FF);
  static const Color clinicalOnPrimaryContainer = Color(0xFF475266);
  static const Color clinicalOnPrimaryFixed = Color(0xFF354053);

  // SECONDARY — Signature Green (e-signatures, validated, audit-passed)
  static const Color clinicalSecondary = Color(0xFF006D4B);
  static const Color clinicalSecondaryDim = Color(0xFF005F41);
  static const Color clinicalSecondaryContainer = Color(0xFF85F8C4);
  static const Color clinicalOnSecondary = Color(0xFFE6FFEF);
  static const Color clinicalOnSecondaryContainer = Color(0xFF005E40);

  // TERTIARY — Audit Red (non-compliance, overdue, critical)
  static const Color clinicalTertiary = Color(0xFFC00815);
  static const Color clinicalTertiaryDim = Color(0xFFAB000F);
  static const Color clinicalTertiaryContainer = Color(0xFFFA3D38);
  static const Color clinicalOnTertiary = Color(0xFFFFF7F6);

  // ERROR — Clinical
  static const Color clinicalError = Color(0xFF9F403D);
  static const Color clinicalErrorContainer = Color(0xFFFE8983);

  // SURFACE HIERARCHY — Tonal Architecture (no borders)
  static const Color clinicalBackground = Color(0xFFF9F9FF);
  static const Color clinicalSurface = Color(0xFFF9F9FF);
  static const Color clinicalSurfaceBright = Color(0xFFF9F9FF);
  static const Color clinicalSurfaceContainerLowest = Color(0xFFFFFFFF); // Cards, high-priority
  static const Color clinicalSurfaceContainerLow = Color(0xFFF0F3FF); // Main workspace
  static const Color clinicalSurfaceContainer = Color(0xFFE7EEFF); // Structural zones
  static const Color clinicalSurfaceContainerHigh = Color(0xFFDEE8FF);
  static const Color clinicalSurfaceContainerHighest = Color(0xFFD5E3FF);
  static const Color clinicalSurfaceDim = Color(0xFFC8DBFF);
  static const Color clinicalSurfaceVariant = Color(0xFFD5E3FF);

  // ON-SURFACE — Text on clinical surfaces
  static const Color clinicalOnSurface = Color(0xFF003265);
  static const Color clinicalOnSurfaceVariant = Color(0xFF3B6095);
  static const Color clinicalOnBackground = Color(0xFF003265);

  // OUTLINE — Ghost Border (felt, not seen)
  static const Color clinicalOutline = Color(0xFF587CB3);
  static const Color clinicalOutlineVariant = Color(0xFF90B3EE);

  // INVERSE
  static const Color clinicalInverseSurface = Color(0xFF040E1F);
  static const Color clinicalInverseOnSurface = Color(0xFF929DB4);

  // CRITICAL BANNER — DC2626 red for overdue alerts
  static const Color clinicalCriticalBanner = Color(0xFFDC2626);
}

// ═══════════════════════════════════════════════════════════════════════════════
// BRAND — Vyuh LMS (logo asset, name)
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaBrand {
  PharmaBrand._();

  /// Asset path for the Vyuh logo image (use with Image.asset or VyuhLogo widget).
  static const String logoAssetPath = 'assets/images/logo_vyuh.png';

  /// Display name for the product.
  static const String name = 'Vyuh lms';
}

// ═══════════════════════════════════════════════════════════════════════════════
// SPACING — 8pt Grid System (Tailwind spacing)
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaSpacing {
  PharmaSpacing._();

  static const double xs = 4.0;    // 1
  static const double sm = 8.0;    // 2
  static const double md = 12.0;   // 3
  static const double lg = 16.0;   // 4
  static const double xl = 20.0;   // 5
  static const double xxl = 24.0;  // 6
  static const double xxxl = 32.0; // 8

  // Semantic spacing
  static const double cardPadding = 24.0;    // p-6 from React
  static const double sectionGap = 24.0;     // space-y-6 from React
  static const double pagePadding = 32.0;    // p-8 from React
  static const double sidebarPadding = 16.0; // p-4 from React
  static const double gridGap = 24.0;        // gap-6 from React
}

// ═══════════════════════════════════════════════════════════════════════════════
// PORTAL LAYOUT — Shared employee / trainer / admin / QA shells
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PortalLayout {
  PortalLayout._();

  static const double sidebarWidth = 256.0;
  static const double headerHeight = 64.0;
  static const double breakpointDesktop = 1024.0;
  static const double breakpointTablet = 768.0;

  /// Main content padding when a screen does not add its own (prefer ListView padding).
  static const double contentPadding = PharmaSpacing.pagePadding;
}

// ═══════════════════════════════════════════════════════════════════════════════
// BORDER RADIUS — From Tailwind rounded-* classes
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaRadius {
  PharmaRadius._();

  static const double sm = 4.0;       // rounded
  static const double md = 6.0;       // rounded-md
  static const double lg = 8.0;       // rounded-lg (cards, inputs)
  static const double xl = 12.0;      // rounded-xl
  static const double xxl = 16.0;     // rounded-2xl
  static const double full = 9999.0;  // rounded-full (pills, avatars)

  static BorderRadius get cardRadius => BorderRadius.circular(lg);
  static BorderRadius get buttonRadius => BorderRadius.circular(lg);
  static BorderRadius get inputRadius => BorderRadius.circular(lg);
  static BorderRadius get pillRadius => BorderRadius.circular(full);
  static BorderRadius get avatarRadius => BorderRadius.circular(full);
  static BorderRadius get badgeRadius => BorderRadius.circular(full);

  // ─── STITCH: Clinical Archive Radii (strict, professional) ───
  // DEFAULT: 0.125rem (2px), lg: 0.25rem (4px), xl: 0.5rem (8px)
  static const double clinicalDefault = 2.0;   // 0.125rem
  static const double clinicalLg = 4.0;        // 0.25rem
  static const double clinicalXl = 8.0;        // 0.5rem
  static const double clinicalFull = 12.0;     // 0.75rem

  static BorderRadius get clinicalCardRadius => BorderRadius.circular(clinicalDefault);
  static BorderRadius get clinicalButtonRadius => BorderRadius.circular(clinicalDefault);
  static BorderRadius get clinicalChipRadius => BorderRadius.circular(clinicalLg);
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHADOWS — From Tailwind shadow-sm, shadow-md
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaShadows {
  PharmaShadows._();

  // shadow-sm (subtle card shadow)
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.05),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
  
  // Alias for sm shadow
  static List<BoxShadow> get sm => cardShadow;

  // shadow-md (hover state)
  static List<BoxShadow> get cardHoverShadow => [
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.1),
      blurRadius: 6,
      spreadRadius: -1,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.06),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  // Alias for md shadow
  static List<BoxShadow> get md => cardHoverShadow;

  // shadow-lg (modals, elevated cards)
  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.1),
      blurRadius: 15,
      spreadRadius: -3,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.05),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
  ];
  
  // Alias for lg shadow
  static List<BoxShadow> get lg => elevated;

  // ─── STITCH: Atmospheric Shadow (derived from on_surface, not black) ───
  static List<BoxShadow> get atmospheric => [
    BoxShadow(
      color: const Color(0xFF003265).withValues(alpha: 0.08),
      blurRadius: 30,
      spreadRadius: -5,
      offset: const Offset(0, 10),
    ),
  ];

  // Subtle atmospheric for filter cards
  static List<BoxShadow> get atmosphericLight => [
    BoxShadow(
      color: const Color(0xFF003265).withValues(alpha: 0.05),
      blurRadius: 30,
      spreadRadius: -5,
      offset: const Offset(0, 10),
    ),
  ];

  // E-signature prompt shadow
  static List<BoxShadow> get eSignature => [
    BoxShadow(
      color: const Color(0xFF003265).withValues(alpha: 0.15),
      blurRadius: 50,
      spreadRadius: -12,
      offset: const Offset(0, 15),
    ),
  ];
}

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY — System font stack matching React
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaTypography {
  PharmaTypography._();

  // Font family (system stack from React)
  static const String fontFamily = '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto';

  // Display / Hero headings
  static TextStyle get displayLarge => const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: PharmaColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Page headings (h1 text-2xl font-semibold)
  static TextStyle get headingLarge => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: PharmaColors.textPrimary,
    height: 1.3,
  );

  // Section headings (h2 text-lg font-semibold)
  static TextStyle get headingMedium => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: PharmaColors.textPrimary,
    height: 1.4,
  );

  // Card titles (h3 font-semibold)
  static TextStyle get headingSmall => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: PharmaColors.textPrimary,
    height: 1.4,
  );

  // Body text (text-sm)
  static TextStyle get body => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: PharmaColors.textSecondary,
    height: 1.5,
  );

  // Body medium weight
  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: PharmaColors.textPrimary,
    height: 1.5,
  );

  // Small/caption text (text-xs)
  static TextStyle get caption => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: PharmaColors.textTertiary,
    height: 1.4,
  );

  // Stat numbers (text-3xl font-semibold)
  static TextStyle get statNumber => const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: PharmaColors.textPrimary,
    height: 1.2,
  );

  // Button text
  static TextStyle get button => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  // Nav item text
  static TextStyle get navItem => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: PharmaColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get navItemActive => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: PharmaColors.textPrimary,
    height: 1.4,
  );

  // Label styles (for badges, chips, form labels)
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: PharmaColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: PharmaColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get labelSmall => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: PharmaColors.textTertiary,
    height: 1.4,
  );

  // ─── STITCH: Clinical Archive Typography ─────────────────────────────────
  // Inter font, sentence case, tight tracking, compliance labels

  /// Stitch section title (headline-sm, tight tracking)
  static TextStyle get clinicalHeadline => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: PharmaColors.clinicalOnSurface,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Stitch card/section title
  static TextStyle get clinicalTitle => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: PharmaColors.clinicalOnSurface,
    height: 1.3,
    letterSpacing: -0.01,
  );

  /// Stitch compliance label (10px bold uppercase tracking-widest)
  static TextStyle get clinicalLabel => TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: PharmaColors.clinicalOnSurfaceVariant,
    height: 1.4,
    letterSpacing: 1.5,
  );

  /// Stitch table header (10px bold uppercase tracking-widest)
  static TextStyle get clinicalTableHeader => TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: PharmaColors.clinicalOnSurfaceVariant,
    height: 1.4,
    letterSpacing: 1.5,
  );

  /// Stitch body text on clinical surfaces
  static TextStyle get clinicalBody => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: PharmaColors.clinicalOnSurfaceVariant,
    height: 1.5,
  );

  /// Stitch KPI large number (4xl extrabold)
  static TextStyle get clinicalKpiValue => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: PharmaColors.clinicalOnSurface,
    height: 1.1,
    letterSpacing: -1.5,
  );

  /// Stitch mono/HMAC text
  static TextStyle get clinicalMono => TextStyle(
    fontFamily: 'monospace',
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: PharmaColors.clinicalOnSurfaceVariant.withValues(alpha: 0.7),
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Stitch table cell text
  static TextStyle get clinicalTableCell => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: PharmaColors.clinicalOnSurface,
    height: 1.5,
  );

  /// Stitch table cell bold
  static TextStyle get clinicalTableCellBold => const TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: PharmaColors.clinicalOnSurface,
    height: 1.5,
  );

  /// Stitch nav label (xs uppercase tracking-widest)
  static TextStyle get clinicalNavLabel => TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: PharmaColors.clinicalOnSurfaceVariant,
    height: 1.4,
    letterSpacing: 1.5,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ANIMATION DURATIONS
// ═══════════════════════════════════════════════════════════════════════════════

abstract class PharmaDurations {
  PharmaDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
}

// ═══════════════════════════════════════════════════════════════════════════════
// SEMANTIC STATUS HELPERS
// ═══════════════════════════════════════════════════════════════════════════════

enum PharmaStatus {
  notStarted,
  inProgress,
  completed,
  overdue,
  sopUpdate,
  expiring,
  expired,
  revoked,
  obsolete,
  locked,
  superseded,
  waived,
}

extension PharmaStatusColors on PharmaStatus {
  Color get backgroundColor {
    switch (this) {
      case PharmaStatus.notStarted:
        return PharmaColors.gray100;
      case PharmaStatus.inProgress:
        return PharmaColors.infoBg;
      case PharmaStatus.completed:
        return PharmaColors.successBg;
      case PharmaStatus.overdue:
        return PharmaColors.dangerBg;
      case PharmaStatus.sopUpdate:
        return PharmaColors.orangeBg;
      case PharmaStatus.expiring:
        return PharmaColors.warningBg;
      case PharmaStatus.expired:
        return PharmaColors.dangerBg;
      case PharmaStatus.revoked:
        return PharmaColors.dangerBg;
      case PharmaStatus.obsolete:
        return PharmaColors.gray100;
      case PharmaStatus.locked:
        return PharmaColors.gray100;
      case PharmaStatus.superseded:
        return PharmaColors.orangeBg;
      case PharmaStatus.waived:
        return PharmaColors.purpleBg;
    }
  }

  Color get textColor {
    switch (this) {
      case PharmaStatus.notStarted:
        return PharmaColors.gray700;
      case PharmaStatus.inProgress:
        return PharmaColors.infoText;
      case PharmaStatus.completed:
        return PharmaColors.successText;
      case PharmaStatus.overdue:
        return PharmaColors.dangerText;
      case PharmaStatus.sopUpdate:
        return PharmaColors.orangeText;
      case PharmaStatus.expiring:
        return PharmaColors.warningText;
      case PharmaStatus.expired:
        return PharmaColors.dangerText;
      case PharmaStatus.revoked:
        return PharmaColors.dangerText;
      case PharmaStatus.obsolete:
        return PharmaColors.gray600;
      case PharmaStatus.locked:
        return PharmaColors.gray600;
      case PharmaStatus.superseded:
        return PharmaColors.orangeText;
      case PharmaStatus.waived:
        return PharmaColors.purpleText;
    }
  }

  String get label {
    switch (this) {
      case PharmaStatus.notStarted:
        return 'Not Started';
      case PharmaStatus.inProgress:
        return 'In Progress';
      case PharmaStatus.completed:
        return 'Completed';
      case PharmaStatus.overdue:
        return 'Overdue';
      case PharmaStatus.sopUpdate:
        return 'SOP Update Required';
      case PharmaStatus.expiring:
        return 'Expiring Soon';
      case PharmaStatus.expired:
        return 'Expired';
      case PharmaStatus.revoked:
        return 'Revoked';
      case PharmaStatus.obsolete:
        return 'Obsolete';
      case PharmaStatus.locked:
        return 'Locked';
      case PharmaStatus.superseded:
        return 'Superseded';
      case PharmaStatus.waived:
        return 'Waived';
    }
  }

  IconData get icon {
    switch (this) {
      case PharmaStatus.notStarted:
        return Icons.circle_outlined;
      case PharmaStatus.inProgress:
        return Icons.play_circle_rounded;
      case PharmaStatus.completed:
        return Icons.check_circle_rounded;
      case PharmaStatus.overdue:
        return Icons.error_rounded;
      case PharmaStatus.sopUpdate:
        return Icons.description_outlined;
      case PharmaStatus.expiring:
        return Icons.schedule_rounded;
      case PharmaStatus.expired:
        return Icons.timer_off_rounded;
      case PharmaStatus.revoked:
        return Icons.cancel_rounded;
      case PharmaStatus.obsolete:
        return Icons.archive_rounded;
      case PharmaStatus.locked:
        return Icons.lock_rounded;
      case PharmaStatus.superseded:
        return Icons.swap_horiz_rounded;
      case PharmaStatus.waived:
        return Icons.verified_user_rounded;
    }
  }
}
