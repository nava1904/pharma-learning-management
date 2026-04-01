import 'package:flutter/material.dart';

import '../../design_system/pharma_design_system.dart';
import 'app_typography.dart';

/// App spacing constants (0.625rem = 10px base).
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// App radius (0.625rem = 10px).
class AppRadius {
  AppRadius._();

  static const double sm = 6;
  static const double md = 8;
  static const double lg = 10;
  static const double xl = 12;
  static const double xxl = 16;
}

/// Vyuh lms theme — unified with PharmaDesignSystem tokens.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: PharmaColors.emerald600,
        onPrimary: Colors.white,
        primaryContainer: PharmaColors.emerald100,
        onPrimaryContainer: PharmaColors.emerald700,
        secondary: PharmaColors.gray200,
        onSecondary: PharmaColors.gray900,
        error: PharmaColors.danger,
        onError: Colors.white,
        surface: PharmaColors.cardBg,
        onSurface: PharmaColors.textPrimary,
        surfaceContainerHighest: PharmaColors.gray100,
        outline: PharmaColors.borderMedium,
      ),
      scaffoldBackgroundColor: PharmaColors.pageBg,
      textTheme: AppTypography.textTheme(PharmaColors.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: PharmaColors.cardBg,
        foregroundColor: PharmaColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: PharmaTypography.headingMedium,
      ),
      cardTheme: CardThemeData(
        color: PharmaColors.cardBg,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.cardRadius,
          side: const BorderSide(color: PharmaColors.borderLight, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: PharmaColors.emerald600,
          foregroundColor: Colors.white,
          disabledBackgroundColor: PharmaColors.gray200,
          disabledForegroundColor: PharmaColors.textTertiary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          minimumSize: const Size(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: PharmaRadius.buttonRadius,
          ),
          textStyle: PharmaTypography.button,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PharmaColors.emerald600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          minimumSize: const Size(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: PharmaRadius.buttonRadius,
          ),
          textStyle: PharmaTypography.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PharmaColors.textSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          minimumSize: const Size(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: PharmaRadius.buttonRadius,
          ),
          side: const BorderSide(color: PharmaColors.borderMedium),
          textStyle: PharmaTypography.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PharmaColors.emerald600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: PharmaTypography.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PharmaColors.inputBg,
        border: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: const BorderSide(color: PharmaColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: const BorderSide(color: PharmaColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: const BorderSide(color: PharmaColors.emerald600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: const BorderSide(color: PharmaColors.danger),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary),
        labelStyle: PharmaTypography.labelLarge,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: PharmaColors.inputBg,
          border: OutlineInputBorder(
            borderRadius: PharmaRadius.inputRadius,
            borderSide: const BorderSide(color: PharmaColors.borderLight),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: PharmaColors.gray100,
        labelStyle: PharmaTypography.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.pillRadius,
          side: const BorderSide(color: PharmaColors.borderLight),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: PharmaColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PharmaRadius.xl),
        ),
        titleTextStyle: PharmaTypography.headingMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: PharmaColors.cardBg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: PharmaColors.emerald600,
        unselectedLabelColor: PharmaColors.textTertiary,
        indicatorColor: PharmaColors.emerald600,
        labelStyle: PharmaTypography.labelLarge,
        unselectedLabelStyle: PharmaTypography.body,
      ),
      dividerTheme: const DividerThemeData(
        color: PharmaColors.borderLight,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: PharmaColors.gray900,
        contentTextStyle: PharmaTypography.body.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: PharmaRadius.cardRadius,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: PharmaColors.gray800,
          borderRadius: PharmaRadius.cardRadius,
        ),
        textStyle: PharmaTypography.caption.copyWith(color: Colors.white),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: PharmaColors.emerald600,
        linearTrackColor: PharmaColors.gray100,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return PharmaColors.emerald600;
          return PharmaColors.gray400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return PharmaColors.emerald200;
          return PharmaColors.gray200;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return PharmaColors.emerald600;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: PharmaColors.borderMedium, width: 1.5),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return PharmaColors.emerald600;
          return PharmaColors.borderMedium;
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PharmaColors.emerald600,
        foregroundColor: Colors.white,
      ),
    );
  }
}
