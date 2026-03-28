import 'package:flutter/material.dart';

/// Vyuh lms color palette - Odoo-inspired with warmer neutrals.
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF030213);

  // Slate palette (50-900) - slightly warmer neutrals
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Indigo (primary brand)
  static const Color indigo50 = Color(0xFFEEF2FF);
  static const Color indigo100 = Color(0xFFE0E7FF);
  static const Color indigo200 = Color(0xFFC7D2FE);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo700 = Color(0xFF4338CA);
  static const Color indigo800 = Color(0xFF3730A3);
  static const Color indigo900 = Color(0xFF312E81);

  // Teal/emerald - success and progress (Odoo-inspired accent)
  static const Color teal50 = Color(0xFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal500 = Color(0xFF14B8A6);
  static const Color teal600 = Color(0xFF0D9488);
  static const Color teal700 = Color(0xFF0F766E);

  // Semantic
  static const Color destructive = Color(0xFFD4183D);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFCA8A04);
  static const Color info = Color(0xFF2563EB);

  // Muted
  static const Color muted = Color(0xFFECECF0);
  static const Color mutedForeground = Color(0xFF717182);

  // Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF8FAFC);

  // Gradients (Odoo-style soft gradients)
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEFF6FF), Color(0xFFE0E7FF)],
  );
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
  );
  static const LinearGradient progressGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
  );

  // Added amber600 color
  static const Color amber600 = Color(0xFFFFB300);
}
