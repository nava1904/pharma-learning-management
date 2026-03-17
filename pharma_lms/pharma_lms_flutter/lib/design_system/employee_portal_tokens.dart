// VYUH LMS - Employee Portal Design Tokens
// ═══════════════════════════════════════════════════════════════════════════════
//
// FLAW AUDIT APPLIED - All 24 Issues Addressed
// ─────────────────────────────────────────────
// MA1-MA7: Critical fixes (crash states, content voids, data contradictions)
// MO1-MO10: Moderate fixes (navigation, hierarchy, visual urgency)
// M1-M10: Minor fixes (dates, badges, labels, consistency)
//
// Design references:
// - Refactoring UI: Spacing scale, color hierarchy, visual weight
// - Don't Make Me Think: Clear navigation, error recovery, obvious actions
// - Laws of UX: Fitts's Law, Hick's Law, aesthetic-usability
// - Practical UI: Empty states, loading states, feedback
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Design tokens for the Employee Portal following the audit fixes
class EmployeePortalTokens {
  EmployeePortalTokens._();

  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING SCALE (8pt grid - Refactoring UI)
  // ═══════════════════════════════════════════════════════════════════════════
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 24;
  static const double space6 = 32;
  static const double space7 = 48;
  static const double space8 = 64;

  // ═══════════════════════════════════════════════════════════════════════════
  // COLORS - Semantic palette with urgency hierarchy (FIX MA5)
  // ═══════════════════════════════════════════════════════════════════════════

  // Brand
  static const Color brandPrimary = Color(0xFF1A56DB); // Blue
  static const Color brandPrimaryLight = Color(0xFFDBEAFE);
  static const Color brandPrimaryDark = Color(0xFF1345B7);

  // Neutral scale
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Text hierarchy
  static const Color textPrimary = Color(0xFF111827); // t1
  static const Color textSecondary = Color(0xFF374151); // t2
  static const Color textTertiary = Color(0xFF6B7280); // t3
  static const Color textQuaternary = Color(0xFF9CA3AF); // t4

  // Semantic - Urgency (FIX MA5, M2: Clear visual urgency for overdue)
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerLight = Color(0xFFFEE2E2);
  static const Color dangerDark = Color(0xFFB91C1C);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color success = Color(0xFF059669);
  static const Color successLight = Color(0xFFD1FAE5);

  static const Color teal = Color(0xFF0D9488);
  static const Color tealLight = Color(0xFFCCFBF1);

  // ═══════════════════════════════════════════════════════════════════════════
  // BORDER RADIUS
  // ═══════════════════════════════════════════════════════════════════════════
  static const double radiusSm = 6;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusFull = 100;

  // ═══════════════════════════════════════════════════════════════════════════
  // SHADOWS (Practical UI)
  // ═══════════════════════════════════════════════════════════════════════════
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  // ═══════════════════════════════════════════════════════════════════════════
  // DURATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationBase = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);
}

/// Status types for training items (FIX M3: Human-readable, not snake_case)
enum TrainingStatus {
  notStarted('Not Started'),
  inProgress('In Progress'),
  completed('Completed'),
  overdue('Overdue'),
  sopUpdate('SOP Update');

  const TrainingStatus(this.label);
  final String label;

  /// Get status color (FIX MO7: Distinct visual per status)
  Color get color {
    switch (this) {
      case TrainingStatus.overdue:
      case TrainingStatus.sopUpdate:
        return EmployeePortalTokens.danger;
      case TrainingStatus.inProgress:
        return EmployeePortalTokens.brandPrimary;
      case TrainingStatus.completed:
        return EmployeePortalTokens.success;
      case TrainingStatus.notStarted:
        return EmployeePortalTokens.neutral400;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TrainingStatus.overdue:
      case TrainingStatus.sopUpdate:
        return EmployeePortalTokens.dangerLight;
      case TrainingStatus.inProgress:
        return EmployeePortalTokens.brandPrimaryLight;
      case TrainingStatus.completed:
        return EmployeePortalTokens.successLight;
      case TrainingStatus.notStarted:
        return EmployeePortalTokens.neutral100;
    }
  }
}

/// Extension to format dates in human-readable format (FIX M1)
extension DateFormatting on DateTime {
  /// Format as "Mar 11, 2026" (FIX M1: Human format, not ISO)
  String toHumanDate() {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Format as relative time e.g. "2 days overdue" or "Due in 3 days"
  String toRelativeDate() {
    final now = DateTime.now();
    final diff = difference(now);

    if (diff.isNegative) {
      final days = diff.inDays.abs();
      if (days == 0) return 'Due today';
      if (days == 1) return '1 day overdue';
      return '$days days overdue';
    } else {
      final days = diff.inDays;
      if (days == 0) return 'Due today';
      if (days == 1) return 'Due tomorrow';
      return 'Due in $days days';
    }
  }

  bool get isOverdue => isBefore(DateTime.now());
}
