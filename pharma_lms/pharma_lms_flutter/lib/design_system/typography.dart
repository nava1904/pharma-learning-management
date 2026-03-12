import 'package:flutter/material.dart';

/// Pharma LMS design system typography.
class DesignTypography {
  DesignTypography._();

  static TextStyle displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge ?? const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  static TextStyle displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static TextStyle displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);

  static TextStyle headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge ?? const TextStyle(fontSize: 16);

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 14);

  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall ?? const TextStyle(fontSize: 12);

  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  static TextStyle labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall ?? const TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
}
