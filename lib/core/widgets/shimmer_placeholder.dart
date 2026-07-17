import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constant/app_colors.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerPlaceholder({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  });

  const ShimmerPlaceholder.circle({
    super.key,
    required double size,
  }) : width = size,
       height = size,
       shapeBorder = const CircleBorder();

  ShimmerPlaceholder.rectangular({
    super.key,
    required this.width,
    required this.height,
    double borderRadius = 8,
  }) : shapeBorder = RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
       );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.chipBackground.withValues(alpha: 0.8),
      highlightColor: Colors.white.withValues(alpha: 0.6),
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
