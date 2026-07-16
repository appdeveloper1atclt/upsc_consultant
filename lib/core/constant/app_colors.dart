import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==========================================================
  // BRAND COLORS
  // ==========================================================

  /// Primary Brand
  static const Color primary = Color(0xFF102A43);

  /// Primary Dark
  static const Color primaryDark = Color(0xFF081B2F);

  /// Primary Light
  static const Color primaryLight = Color(0xFF1C456B);

  // ==========================================================
  // PREMIUM GOLD
  // ==========================================================

  static const Color gold = Color(0xFFC89B3C);

  static const Color goldDark = Color(0xFFA97820);

  static const Color goldLight = Color(0xFFE8C978);

  static const Color goldShimmer = Color(0xFFF9E9A7);

  static const Color goldMuted = Color(0xFF8C6A1A);

  // ==========================================================
  // BACKGROUND
  // ==========================================================

  /// Main Background
  static const Color scaffold = Color(0xFFFAF8F4);

  /// White Card
  static const Color card = Color(0xFFFFFFFF);

  /// Light Surface
  static const Color surface = Color(0xFFF7F3EC);

  /// Dark Screen (Splash/Login)
  static const Color backgroundDark = Color(0xFF081B2F);

  // ==========================================================
  // TEXT
  // ==========================================================

  static const Color textPrimary = Color(0xFF1B263B);

  static const Color textSecondary = Color(0xFF6B7280);

  static const Color textHint = Color(0xFFA0A6B1);

  static const Color white = Color(0xFFFFFFFF);

  // ==========================================================
  // BORDER
  // ==========================================================

  static const Color border = Color(0xFFE2DBCF);

  static const Color divider = Color(0xFFEDE7DA);

  // ==========================================================
  // STATUS
  // ==========================================================

  static const Color success = Color(0xFF2E7D32);

  static const Color warning = Color(0xFFC27C0E);

  static const Color error = Color(0xFFC62828);

  // ==========================================================
  // COMPONENTS
  // ==========================================================

  static const Color iconPrimary = primary;

  static const Color iconSecondary = textSecondary;

  static const Color chipBackground = Color(0xFFF6F3ED);

  static const Color chipSelected = Color(0xFFFFF7E6);

  static const Color premiumBadge = Color(0xFFFFF3D4);

  static const Color premiumBorder = Color(0xFFE5C875);

  static const Color mentorCard = Color(0xFFFFFCF5);

  static const Color selectedCard = Color(0xFFFFF8EB);

  static const Color overlay = Color(0x66000000);

  static const Color shadow = Color(0x14000000);

  // ==========================================================
  // GRADIENTS
  // ==========================================================

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF081B2F), Color(0xFF102A43), Color(0xFF1C456B)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA97820), Color(0xFFC89B3C), Color(0xFFE8C978), Color(0xFFF9E9A7)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFA97820), Color(0xFFC89B3C), Color(0xFFE8C978)],
  );

  static const RadialGradient goldGlow = RadialGradient(colors: [Color(0x55C89B3C), Color(0x22C89B3C), Colors.transparent]);
  static const RadialGradient ashokaGlow = RadialGradient(colors: [Color(0x66C89B3C), Color(0x33E8C978), Colors.transparent]);
}
