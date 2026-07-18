import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

class QuoteBanner extends StatelessWidget {
  const QuoteBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.2),
        boxShadow: [BoxShadow(color: AppColors.primaryDark.withValues(alpha: 0.1), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Stack(
        children: [
          // Watermark icon on the bottom right
          Positioned(
            right: -10,
            bottom: -15,
            child: Transform.rotate(angle: -0.15, child: Icon(Icons.auto_stories_outlined, size: 80, color: AppColors.gold.withValues(alpha: 0.06))),
          ),
          // Text Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '"Discipline Today, Freedom Tomorrow."',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: AppColors.goldLight,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Your Dream. Our Guidance. Your Success.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9, color: Colors.white.withValues(alpha: 0.75), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
