import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _font = AppFonts.PlusJakartaSans;

  // ==========================================================================
  // BLACK STYLES
  // ==========================================================================
  static const TextStyle black18bold = TextStyle(fontFamily: _font, fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle black16bold = TextStyle(fontFamily: _font, fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle black14bold = TextStyle(fontFamily: _font, fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle black12semibold = TextStyle(fontFamily: _font, fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600);

  static const TextStyle black12normal = TextStyle(fontFamily: _font, fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500);

  // ==========================================================================
  // WHITE STYLES
  // ==========================================================================
  static const TextStyle white36extraBold = TextStyle(
    fontFamily: _font,
    fontSize: 36,
    color: Colors.white,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -.5,
  );

  static const TextStyle white28bold = TextStyle(fontFamily: _font, fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700, height: 1.2);

  static const TextStyle white22bold = TextStyle(fontFamily: _font, fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700);

  static const TextStyle white20bold = TextStyle(fontFamily: _font, fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700);

  static const TextStyle white18semibold = TextStyle(fontFamily: _font, fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);

  static const TextStyle white16semibold = TextStyle(fontFamily: _font, fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600);

  static const TextStyle white16bold = TextStyle(fontFamily: _font, fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700);

  static const TextStyle white15medium = TextStyle(fontFamily: _font, fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);

  static const TextStyle white14bold = TextStyle(fontFamily: _font, fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);

  static const TextStyle white10normal = TextStyle(fontFamily: _font, fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400);

  static const TextStyle white13normal = TextStyle(fontFamily: _font, fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400);

  static const TextStyle white12normal = TextStyle(fontFamily: _font, fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400);

  static const TextStyle white9semibold = TextStyle(fontFamily: _font, fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600);

  // ==========================================================================
  // TEXT PRIMARY STYLES
  // ==========================================================================
  static const TextStyle textPrimary28extraBold = TextStyle(fontFamily: _font, fontSize: 22, color: AppColors.textPrimary, fontWeight: FontWeight.w800);

  static const TextStyle textPrimary26bold = TextStyle(fontFamily: _font, fontSize: 26, color: AppColors.textPrimary, fontWeight: FontWeight.w800);

  static const TextStyle textPrimary22bold = TextStyle(fontFamily: _font, fontSize: 18, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary18bold = TextStyle(fontFamily: _font, fontSize: 18, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary17bold = TextStyle(fontFamily: _font, fontSize: 17, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary16bold = TextStyle(fontFamily: _font, fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary14semibold = TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w600);

  static const TextStyle textPrimary13bold = TextStyle(fontFamily: _font, fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600);

  static const TextStyle textPrimary12semibold = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w600);

  static const TextStyle textPrimary11bold = TextStyle(fontFamily: _font, fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary10bold = TextStyle(fontFamily: _font, fontSize: 10, color: AppColors.textPrimary, fontWeight: FontWeight.w700);

  // ==========================================================================
  // TEXT SECONDARY STYLES
  // ==========================================================================
  static const TextStyle textSecondary16normal = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle textSecondary15normal = TextStyle(fontFamily: _font, fontSize: 15, color: AppColors.textSecondary, fontWeight: FontWeight.w400);

  static const TextStyle textSecondary14normal = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle textSecondary13normal = TextStyle(fontFamily: _font, fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w400);

  static const TextStyle textSecondary13medium = TextStyle(fontFamily: _font, fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500);

  static const TextStyle textSecondary12medium = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500);

  static const TextStyle textSecondary12semibold = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600);

  static const TextStyle textSecondary11semibold = TextStyle(fontFamily: _font, fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600);

  // ==========================================================================
  // TEXT HINT STYLES
  // ==========================================================================
  static const TextStyle textHint14normal = TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.textHint, fontWeight: FontWeight.w400);

  static const TextStyle textHint12normal = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.textHint, fontWeight: FontWeight.w400);

  static const TextStyle textHint11normal = TextStyle(fontFamily: _font, fontSize: 11, color: AppColors.textHint, fontWeight: FontWeight.w400);

  static const TextStyle textHint10medium = TextStyle(fontFamily: _font, fontSize: 10, color: AppColors.textHint, fontWeight: FontWeight.w500);

  // ==========================================================================
  // GOLD STYLES
  // ==========================================================================
  static const TextStyle gold26extraBold = TextStyle(fontFamily: _font, fontSize: 26, color: AppColors.gold, fontWeight: FontWeight.w800, letterSpacing: 1);

  static const TextStyle gold16bold = TextStyle(fontFamily: _font, fontSize: 16, color: AppColors.gold, fontWeight: FontWeight.bold);

  static const TextStyle goldLight13medium = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    color: AppColors.goldLight,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  static const TextStyle goldLight10bold = TextStyle(fontFamily: _font, fontSize: 10, color: AppColors.goldLight, fontWeight: FontWeight.w900);

  static const TextStyle goldLight9bold = TextStyle(fontFamily: _font, fontSize: 9, color: AppColors.goldLight, fontWeight: FontWeight.w800);

  static const TextStyle gold95bold = TextStyle(fontFamily: _font, fontSize: 9.5, color: AppColors.gold, fontWeight: FontWeight.w700);

  static const TextStyle textSecondary95bold = TextStyle(fontFamily: _font, fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.w700);

  static const TextStyle gold11bold = TextStyle(fontFamily: _font, fontSize: 11, color: AppColors.gold, fontWeight: FontWeight.w700);

  static const TextStyle goldMuted12bold = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.goldMuted, fontWeight: FontWeight.w700);

  static const TextStyle goldMuted95bold = TextStyle(fontFamily: _font, fontSize: 9.5, color: AppColors.goldMuted, fontWeight: FontWeight.w800);

  static const TextStyle goldMuted8semibold = TextStyle(fontFamily: _font, fontSize: 8.5, color: AppColors.goldMuted, fontWeight: FontWeight.w800);

  static const TextStyle goldDark12bold = TextStyle(fontFamily: _font, fontSize: 12, color: AppColors.goldDark, fontWeight: FontWeight.w700);

  static const TextStyle goldDark28extraBold = TextStyle(fontFamily: _font, fontSize: 28, color: AppColors.goldDark, fontWeight: FontWeight.w800);

  // ==========================================================================
  // PRIMARY STYLES
  // ==========================================================================
  static const TextStyle primary36extraBold = TextStyle(fontFamily: _font, fontSize: 36, color: AppColors.primary, fontWeight: FontWeight.w800);

  static const TextStyle primary16bold = TextStyle(fontFamily: _font, fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w700);

  static const TextStyle primary14bold = TextStyle(fontFamily: _font, fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w700);

  static const TextStyle primary10bold = TextStyle(fontFamily: _font, fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w700);

  static const TextStyle primaryDark15extraBold = TextStyle(fontFamily: _font, fontSize: 15, color: AppColors.primaryDark, fontWeight: FontWeight.w800);

  // ==========================================================================
  // SUCCESS STYLES
  // ==========================================================================
  static const TextStyle success42extraBold = TextStyle(fontFamily: _font, fontSize: 42, color: AppColors.success, fontWeight: FontWeight.w800);

  static const TextStyle success10bold = TextStyle(fontFamily: _font, fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w800);

  // ==========================================================================
  // OTHER COLOR STYLES
  // ==========================================================================
  static const TextStyle darkBlue26extraBold = TextStyle(fontFamily: _font, fontSize: 26, color: Color(0xFF0A1628), fontWeight: FontWeight.w800);

  static const TextStyle darkBlue22extraBold = TextStyle(fontFamily: _font, fontSize: 22, color: Color(0xFF0A1628), fontWeight: FontWeight.w800);

  static const TextStyle grey718096_14normal = TextStyle(fontFamily: _font, fontSize: 14, color: Color(0xFF718096), height: 1.5);

  static const TextStyle grey718096_13normal = TextStyle(fontFamily: _font, fontSize: 13, color: Color(0xFF718096));

  static const TextStyle greyB0B8C5_14normal = TextStyle(fontFamily: _font, fontSize: 14, color: Color(0xFFB0B8C5), fontWeight: FontWeight.w400);

  static const TextStyle greyB0B8C5_11normal = TextStyle(fontFamily: _font, fontSize: 11, color: Color(0xFFB0B8C5), height: 1.6);

  // ==========================================================================
  // BACKWARD COMPATIBILITY ALIASES
  // ==========================================================================
  static const TextStyle displayLarge = white36extraBold;
  static const TextStyle displayMedium = white28bold;
  static const TextStyle displaySmall = white22bold;
  static const TextStyle headlineLarge = white20bold;
  static const TextStyle headlineMedium = white18semibold;
  static const TextStyle headlineSmall = white16semibold;
  static const TextStyle pageTitle = textPrimary28extraBold;
  static const TextStyle pageSubtitle = textSecondary15normal;
  static const TextStyle appBarTitle = textPrimary22bold;
  static const TextStyle sectionTitle = textPrimary18bold;
  static const TextStyle sectionSubtitle = textSecondary14normal;
  static const TextStyle cardTitle = textPrimary16bold;
  static const TextStyle cardSubtitle = textSecondary13normal;
  static const TextStyle bodyLarge = textSecondary16normal;
  static const TextStyle bodyMedium = textSecondary14normal;
  static const TextStyle bodySmall = textHint12normal;
  static const TextStyle labelLarge = textPrimary14semibold;
  static const TextStyle labelMedium = textSecondary12medium;
  static const TextStyle labelSmall = textHint10medium;
  static const TextStyle brandTitle = gold26extraBold;
  static const TextStyle brandSubtitle = goldLight13medium;
  static const TextStyle buttonText = primary16bold;
  static const TextStyle buttonTextLight = white16bold;
  static const TextStyle buttonSmall = primary14bold;
  static const TextStyle inputText = white15medium;
  static const TextStyle inputHint = textHint14normal;
  static const TextStyle statNumber = primary36extraBold;
  static const TextStyle percentage = success42extraBold;
  static const TextStyle statTitle = textSecondary13medium;
  static const TextStyle chipSelected = goldDark12bold;
  static const TextStyle chipUnselected = textSecondary12semibold;
  static const TextStyle bottomBarSelected = gold11bold;
  static const TextStyle bottomBarUnselected = textSecondary11semibold;
  static const TextStyle mentorName = textPrimary17bold;
  static const TextStyle designation = textSecondary13medium;
  static const TextStyle price = goldDark28extraBold;
  static const TextStyle badge = textPrimary10bold;
  static const TextStyle caption = textHint11normal;

  // Additional helper styles
  static const TextStyle white18bold = TextStyle(fontFamily: _font, fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle white11semibold = TextStyle(fontFamily: _font, fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600);

  static const TextStyle white10semibold = TextStyle(fontFamily: _font, fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600);

  static const TextStyle textSecondary8normal = TextStyle(fontFamily: _font, fontSize: 8.5, color: AppColors.textSecondary, fontWeight: FontWeight.normal);

  static const TextStyle textPrimary8bold = TextStyle(fontFamily: _font, fontSize: 8.5, color: AppColors.textPrimary, fontWeight: FontWeight.bold);

  static const TextStyle success8bold = TextStyle(fontFamily: _font, fontSize: 8.5, color: AppColors.success, fontWeight: FontWeight.bold);

  static const TextStyle textSecondary8semibold = TextStyle(fontFamily: _font, fontSize: 8.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600);
}

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8))];

  static const List<BoxShadow> button = [BoxShadow(color: Color(0x33C89B3C), blurRadius: 18, offset: Offset(0, 8))];

  static const List<BoxShadow> goldGlow = [BoxShadow(color: Color(0x55C89B3C), blurRadius: 30, spreadRadius: 2)];
}
