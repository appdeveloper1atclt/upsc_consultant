import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

ThemeData appTheme() {
  const fontFamily = 'PlusJakartaSans';

  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.scaffold,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.gold,
      surface: AppColors.card,

      onPrimary: AppColors.white,
      onSecondary: AppColors.primary,
      onSurface: AppColors.textPrimary,

      error: AppColors.error,
      onError: AppColors.white,
    ),

    dividerColor: AppColors.divider,

    cardColor: AppColors.card,

    shadowColor: AppColors.shadow,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(fontFamily: fontFamily, fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w800),
      displayMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,

      hintStyle: const TextStyle(fontFamily: fontFamily, color: AppColors.textHint, fontSize: 14),

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.primary,
        minimumSize: const Size(64, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.border),
        minimumSize: const Size(64, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentTextStyle: const TextStyle(fontFamily: fontFamily, color: AppColors.white, fontSize: 13),
    ),

    dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 1),
  );
}
