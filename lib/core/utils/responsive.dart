import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Responsive utility to dynamically scale sizes across different screen sizes.
/// Reference baseline is a standard mobile screen (375dp x 812dp).
extension ResponsiveExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  /// Returns height scaled by percentage of screen height (0.0 to 1.0)
  double hp(double percent) => screenHeight * percent;

  /// Returns width scaled by percentage of screen width (0.0 to 1.0)
  double wp(double percent) => screenWidth * percent;

  /// Scale size horizontally based on device screen width
  double scaleW(double size) {
    final scaleFactor = screenWidth / 375.0;
    // Cap scale factor to avoid excessive scaling on tablets
    return size * math.min(scaleFactor, 1.4);
  }

  /// Scale size vertically based on device screen height
  double scaleH(double size) {
    final scaleFactor = screenHeight / 812.0;
    return size * math.min(scaleFactor, 1.4);
  }

  /// Adaptive spacing that scales with screen height
  double get spacingXs => scaleH(4);
  double get spacingSm => scaleH(8);
  double get spacingMd => scaleH(16);
  double get spacingLg => scaleH(24);
  double get spacingXl => scaleH(32);
  double get spacingXxl => scaleH(48);

  /// Safe responsive height for central components
  double get adaptiveAnimHeight => math.min(screenHeight * 0.35, 260.0);
}
