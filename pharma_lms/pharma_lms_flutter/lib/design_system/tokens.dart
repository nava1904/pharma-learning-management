// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — DESIGN TOKEN SYSTEM
// ═══════════════════════════════════════════════════════════════════════════════
//
// This file is the single source of truth for all visual design values.
// NEVER use hardcoded hex values, pixels, or durations outside this file.
//
// Design References Applied:
// - Apple HIG: Clarity, Deference, Depth
// - Refactoring UI: Visual hierarchy through size/weight/color
// - Don't Make Me Think: Self-evident interfaces
// - Laws of UX: Fitts's, Jakob's, Hick's, Miller's, Doherty
// - UI is Communication: Color = meaning
// - Practical UI: Whitespace, consistency
//
// Typography Stack:
// - Headings: Bricolage Grotesque (700, 600)
// - Body: DM Sans (400, 500)
// - Code/IDs: JetBrains Mono (400)
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR TOKENS
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────────────────────────────────────
  // BRAND COLORS
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color blue = Color(0xFF1A56DB);
  static const Color blueDark = Color(0xFF1345B7);
  static const Color blueLight = Color(0xFFEBF2FF);

  // ─────────────────────────────────────────────────────────────────────────────
  // SEMANTIC COLORS (UI IS COMMUNICATION)
  // ─────────────────────────────────────────────────────────────────────────────
  // OVERDUE = RED. Not orange, not yellow. Red = danger, urgency, regulatory risk.
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerLight = Color(0xFFFEF2F2);
  static const Color dangerDark = Color(0xFFB91C1C);

  // COMPLETED = GREEN. Communicates success and safety.
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFF0FDF4);
  static const Color successDark = Color(0xFF15803D);

  // WARNING = AMBER. Approaching deadline, needs attention.
  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFFFBEB);
  static const Color warningDark = Color(0xFFB45309);

  // IN_PROGRESS = BLUE. Work in motion, trustworthy.
  static const Color teal = Color(0xFF0D9488);
  static const Color tealLight = Color(0xFFCCFBF1);
  static const Color tealDark = Color(0xFF0F766E);

  // ─────────────────────────────────────────────────────────────────────────────
  // NEUTRAL SCALE (Slate)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color n0 = Color(0xFFFFFFFF);
  static const Color n50 = Color(0xFFF8FAFC);
  static const Color n100 = Color(0xFFF1F5F9);
  static const Color n200 = Color(0xFFE2E8F0);
  static const Color n300 = Color(0xFFCBD5E1);
  static const Color n400 = Color(0xFF94A3B8);
  static const Color n500 = Color(0xFF64748B);
  static const Color n600 = Color(0xFF475569);
  static const Color n700 = Color(0xFF334155);
  static const Color n800 = Color(0xFF1E293B);
  static const Color n900 = Color(0xFF0F172A);

  // ─────────────────────────────────────────────────────────────────────────────
  // MATERIAL LAYERS (Apple HIG Depth)
  // ─────────────────────────────────────────────────────────────────────────────
  static const Color layer0 = Color(0xFFF1F5F9); // Page background
  static const Color layer1 = Color(0xFFFFFFFF); // Cards/panels
  static const Color layer2 = Color(0xFFFFFFFF); // Elevated modals/sheets
  static const Color layer3 = Color(0xFFFFFFFF); // Overlays/toasts
}

// ═══════════════════════════════════════════════════════════════════════════════
// SPACING TOKENS (8pt Grid — Refactoring UI)
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppSpacing {
  AppSpacing._();

  static const double s1 = 4.0; // Micro only — never for layout
  static const double s2 = 8.0;
  static const double s3 = 12.0;
  static const double s4 = 16.0;
  static const double s5 = 20.0;
  static const double s6 = 24.0;
  static const double s7 = 32.0;
  static const double s8 = 40.0;
  static const double s9 = 48.0;
  static const double s10 = 64.0;

  // Common semantic spacing
  static const double cardPadding = 20.0;
  static const double sectionPadding = 24.0;
  static const double pagePadding = 24.0;
}

// ═══════════════════════════════════════════════════════════════════════════════
// RADIUS TOKENS
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppRadius {
  AppRadius._();

  static const Radius r1 = Radius.circular(6);
  static const Radius r2 = Radius.circular(10);
  static const Radius r3 = Radius.circular(14);
  static const Radius r4 = Radius.circular(20);
  static const Radius r5 = Radius.circular(100); // Pill

  static const BorderRadius br1 = BorderRadius.all(r1);
  static const BorderRadius br2 = BorderRadius.all(r2);
  static const BorderRadius br3 = BorderRadius.all(r3);
  static const BorderRadius br4 = BorderRadius.all(r4);
  static const BorderRadius br5 = BorderRadius.all(r5);
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHADOW TOKENS (Refactoring UI)
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppShadows {
  AppShadows._();

  static const List<BoxShadow> sh1 = [
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> sh2 = [
    BoxShadow(
      color: Color(0x12000000), // 7% black
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0A000000), // 4% black
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> sh3 = [
    BoxShadow(
      color: Color(0x14000000), // 8% black
      blurRadius: 48,
      offset: Offset(0, 16),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> sh4 = [
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      blurRadius: 80,
      offset: Offset(0, 32),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}

// ═══════════════════════════════════════════════════════════════════════════════
// DURATION TOKENS (Motion — Apple HIG)
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 120);
  static const Duration base = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 350);
  static const Duration page = Duration(milliseconds: 280);

  // Stagger delay for list animations
  static const Duration stagger = Duration(milliseconds: 40);
}

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY TOKENS
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppTypography {
  AppTypography._();

  // Font families
  static const String fontHeading = 'Bricolage Grotesque';
  static const String fontBody = 'DM Sans';
  static const String fontMono = 'JetBrains Mono';

  // Display: Bricolage Grotesque 700, -0.04em tracking
  static const TextStyle display = TextStyle(
    fontFamily: fontHeading,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.44, // -0.04em
    height: 1.2,
    color: AppColors.n900,
  );

  // Title: Bricolage Grotesque 600, -0.03em
  static const TextStyle title = TextStyle(
    fontFamily: fontHeading,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.72, // -0.03em
    height: 1.3,
    color: AppColors.n900,
  );

  // Headline: Bricolage Grotesque 600
  static const TextStyle headline = TextStyle(
    fontFamily: fontHeading,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    height: 1.4,
    color: AppColors.n900,
  );

  // Body: DM Sans 400, 0.01em, 1.6 line-height
  static const TextStyle body = TextStyle(
    fontFamily: fontBody,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.16, // 0.01em
    height: 1.6,
    color: AppColors.n700,
  );

  // Body Small
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontBody,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
    height: 1.5,
    color: AppColors.n600,
  );

  // Caption: DM Sans 500, 0.04em uppercase
  static const TextStyle caption = TextStyle(
    fontFamily: fontBody,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.48, // 0.04em
    height: 1.4,
    color: AppColors.n500,
  );

  // Label: DM Sans 500
  static const TextStyle label = TextStyle(
    fontFamily: fontBody,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.14,
    height: 1.4,
    color: AppColors.n700,
  );

  // Code: JetBrains Mono 400
  static const TextStyle code = TextStyle(
    fontFamily: fontMono,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.n600,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontFamily: fontBody,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.14,
    height: 1.4,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SIZING TOKENS
// ═══════════════════════════════════════════════════════════════════════════════

abstract class AppSizing {
  AppSizing._();

  // Navigation
  static const double sidebarWidth = 240.0;
  static const double sidebarWidthExpanded = 280.0;
  static const double topBarHeight = 56.0;
  static const double bottomNavHeight = 64.0;

  // Components
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double inputHeight = 44.0;
  static const double minTapTarget = 44.0; // Apple HIG minimum

  // Course viewer
  static const double courseOutlineWidth = 320.0;

  // Cards
  static const double cardMaxWidth = 380.0;
  static const double courseCardHeight = 280.0;
  static const double credentialCardHeight = 200.0;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TRAINING STATUS — Human-readable display helpers
// ═══════════════════════════════════════════════════════════════════════════════
// NEVER pass raw enum .name to any Text widget. ALWAYS use these extensions.

enum TrainingStatus {
  notStarted,
  inProgress,
  completed,
  overdue,
  sopUpdate,
}

extension TrainingStatusDisplay on TrainingStatus {
  /// Human-readable label — ALWAYS use this, never raw enum
  String get label {
    switch (this) {
      case TrainingStatus.notStarted:
        return 'Not Started';
      case TrainingStatus.inProgress:
        return 'In Progress';
      case TrainingStatus.completed:
        return 'Completed';
      case TrainingStatus.overdue:
        return 'Overdue';
      case TrainingStatus.sopUpdate:
        return 'SOP Update Required';
    }
  }

  /// Primary color for this status
  Color get color {
    switch (this) {
      case TrainingStatus.notStarted:
        return AppColors.n400;
      case TrainingStatus.inProgress:
        return AppColors.blue;
      case TrainingStatus.completed:
        return AppColors.success;
      case TrainingStatus.overdue:
      case TrainingStatus.sopUpdate:
        return AppColors.danger;
    }
  }

  /// Background tint color (5-8% opacity semantic)
  Color get bgColor {
    switch (this) {
      case TrainingStatus.notStarted:
        return AppColors.n100;
      case TrainingStatus.inProgress:
        return AppColors.blueLight;
      case TrainingStatus.completed:
        return AppColors.successLight;
      case TrainingStatus.overdue:
      case TrainingStatus.sopUpdate:
        return AppColors.dangerLight;
    }
  }

  /// Icon for this status
  IconData get icon {
    switch (this) {
      case TrainingStatus.notStarted:
        return Icons.circle_outlined;
      case TrainingStatus.inProgress:
        return Icons.play_circle_rounded;
      case TrainingStatus.completed:
        return Icons.check_circle_rounded;
      case TrainingStatus.overdue:
        return Icons.error_rounded;
      case TrainingStatus.sopUpdate:
        return Icons.update_rounded;
    }
  }

  /// CTA button label
  String get ctaLabel {
    switch (this) {
      case TrainingStatus.notStarted:
        return 'Start Course';
      case TrainingStatus.inProgress:
        return 'Resume';
      case TrainingStatus.completed:
        return 'View Certificate';
      case TrainingStatus.overdue:
        return 'Start Now — Overdue';
      case TrainingStatus.sopUpdate:
        return 'Review Changes';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COURSE TYPE
// ═══════════════════════════════════════════════════════════════════════════════

enum CourseType {
  pdf,
  video,
  scorm,
  mixed,
}

extension CourseTypeDisplay on CourseType {
  String get label {
    switch (this) {
      case CourseType.pdf:
        return 'PDF';
      case CourseType.video:
        return 'Video';
      case CourseType.scorm:
        return 'SCORM';
      case CourseType.mixed:
        return 'Mixed';
    }
  }

  IconData get icon {
    switch (this) {
      case CourseType.pdf:
        return Icons.description_outlined;
      case CourseType.video:
        return Icons.play_circle_outline_rounded;
      case CourseType.scorm:
        return Icons.widgets_outlined;
      case CourseType.mixed:
        return Icons.folder_outlined;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DATE FORMATTING — ALWAYS human-readable
// ═══════════════════════════════════════════════════════════════════════════════
// Dates are ALWAYS human-readable: "Mar 11, 2026" never "2026-03-11"

extension DateDisplay on DateTime {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  /// Human-readable date: "Mar 11, 2026"
  String get humanDate {
    return '${_months[month - 1]} $day, $year';
  }

  /// Short date: "Mar 11"
  String get humanDateShort {
    return '${_months[month - 1]} $day';
  }

  /// Due date label with overdue indication
  String get dueDateLabel {
    final now = DateTime.now();
    final diff = difference(now);

    if (diff.isNegative) {
      // Overdue
      final days = diff.inDays.abs();
      if (days == 0) return 'Due today';
      if (days == 1) return '1 day overdue';
      return '$days days overdue';
    } else {
      // Upcoming
      final days = diff.inDays;
      if (days == 0) return 'Due today';
      if (days == 1) return 'Due tomorrow';
      if (days < 7) return 'Due in $days days';
      return 'Due $humanDate';
    }
  }

  /// Full due date string: "Due Mar 11, 2026 · 21 days overdue"
  String get fullDueDateLabel {
    final now = DateTime.now();
    final diff = difference(now);

    if (diff.isNegative) {
      final days = diff.inDays.abs();
      if (days == 0) return 'Due today';
      return 'Due $humanDate · $days day${days == 1 ? '' : 's'} overdue';
    }
    return 'Due $humanDate';
  }

  /// Check if date is overdue
  bool get isOverdue => isBefore(DateTime.now());

  /// Check if date is expiring within 30 days
  bool get isExpiringSoon =>
      isAfter(DateTime.now()) &&
      isBefore(DateTime.now().add(const Duration(days: 30)));

  /// Relative time: "2 hours ago", "3 days ago"
  String get relativeTime {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return humanDate;
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DURATION FORMATTING
// ═══════════════════════════════════════════════════════════════════════════════

extension DurationDisplay on int {
  /// Format minutes as "~2h 30m" or "45 min"
  String get durationLabel {
    if (this < 60) return '$this min';
    final hours = this ~/ 60;
    final mins = this % 60;
    if (mins == 0) return '~${hours}h';
    return '~${hours}h ${mins}m';
  }

  /// Format seconds as "3m 45s"
  String get timerLabel {
    final mins = this ~/ 60;
    final secs = this % 60;
    if (mins == 0) return '${secs}s';
    return '${mins}m ${secs}s';
  }
}
