import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _font = 'PlusJakartaSans';

  // ==========================================================================
  // DISPLAY
  // ==========================================================================

  static const TextStyle displayLarge = TextStyle(
    fontFamily: _font,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.1,
    letterSpacing: -.5,
  );

  static const TextStyle displayMedium = TextStyle(fontFamily: _font, fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.white, height: 1.2);

  static const TextStyle displaySmall = TextStyle(fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.white);

  // ==========================================================================
  // HEADLINE
  // ==========================================================================

  static const TextStyle headlineLarge = TextStyle(fontFamily: _font, fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.white);

  static const TextStyle headlineMedium = TextStyle(fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white);

  static const TextStyle headlineSmall = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);

  // ==========================================================================
  // PAGE
  // ==========================================================================

  static const TextStyle pageTitle = TextStyle(fontFamily: _font, fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary);

  static const TextStyle pageSubtitle = TextStyle(fontFamily: _font, fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  // ==========================================================================
  // APP BAR
  // ==========================================================================

  static const TextStyle appBarTitle = TextStyle(fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  // ==========================================================================
  // SECTION
  // ==========================================================================

  static const TextStyle sectionTitle = TextStyle(fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const TextStyle sectionSubtitle = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  // ==========================================================================
  // CARD
  // ==========================================================================

  static const TextStyle cardTitle = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const TextStyle cardSubtitle = TextStyle(fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  // ==========================================================================
  // BODY
  // ==========================================================================

  static const TextStyle bodyLarge = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.6);

  static const TextStyle bodyMedium = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.6);

  static const TextStyle bodySmall = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textHint);

  // ==========================================================================
  // LABEL
  // ==========================================================================

  static const TextStyle labelLarge = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const TextStyle labelMedium = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  static const TextStyle labelSmall = TextStyle(fontFamily: _font, fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textHint);

  // ==========================================================================
  // BRAND
  // ==========================================================================

  static const TextStyle brandTitle = TextStyle(fontFamily: _font, fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.gold, letterSpacing: 1);

  static const TextStyle brandSubtitle = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.goldLight,
    letterSpacing: 1.5,
  );

  // ==========================================================================
  // BUTTON
  // ==========================================================================

  static const TextStyle buttonText = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary);

  static const TextStyle buttonTextLight = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white);

  static const TextStyle buttonSmall = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary);

  // ==========================================================================
  // INPUT
  // ==========================================================================

  static const TextStyle inputText = TextStyle(fontFamily: _font, fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.white);

  static const TextStyle inputHint = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textHint);

  // ==========================================================================
  // STATS
  // ==========================================================================

  static const TextStyle statNumber = TextStyle(fontFamily: _font, fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.primary);

  static const TextStyle percentage = TextStyle(fontFamily: _font, fontSize: 42, fontWeight: FontWeight.w800, color: AppColors.success);

  static const TextStyle statTitle = TextStyle(fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  // ==========================================================================
  // CHIPS
  // ==========================================================================

  static const TextStyle chipSelected = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.goldDark);

  static const TextStyle chipUnselected = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary);

  // ==========================================================================
  // BOTTOM NAVIGATION
  // ==========================================================================

  static const TextStyle bottomBarSelected = TextStyle(fontFamily: _font, fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.gold);

  static const TextStyle bottomBarUnselected = TextStyle(fontFamily: _font, fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary);

  // ==========================================================================
  // MENTOR
  // ==========================================================================

  static const TextStyle mentorName = TextStyle(fontFamily: _font, fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const TextStyle designation = TextStyle(fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  // ==========================================================================
  // PRICE
  // ==========================================================================

  static const TextStyle price = TextStyle(fontFamily: _font, fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.goldDark);

  static const TextStyle badge = TextStyle(fontFamily: _font, fontSize: 10, fontWeight: FontWeight.w700);

  static const TextStyle caption = TextStyle(fontFamily: _font, fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textHint);
}

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8))];

  static const List<BoxShadow> button = [BoxShadow(color: Color(0x33C89B3C), blurRadius: 18, offset: Offset(0, 8))];

  static const List<BoxShadow> goldGlow = [BoxShadow(color: Color(0x55C89B3C), blurRadius: 30, spreadRadius: 2)];
}
