import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _item(AppImage.bottomNavHome, 'Home', 0),
          _item(AppImage.bottomNavMentoring, 'Mentors', 1),
          _scanItem(2),
          _item(AppImage.bottomNavTest, 'Tests', 3),
          _item(AppImage.bottomNavProfile, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _item(String imagePath, String title, int index) {
    final selected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 22,
            height: 22,
            color: selected ? AppColors.gold : AppColors.textSecondary,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: selected ? AppColors.gold : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Centre gold "scan" CTA, matching the original screenshot.
  Widget _scanItem(int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => onTap(index),
      child: Container(
        width: 46,
        height: 46,
        decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            AppImage.bottomNavScan,
            width: 22,
            height: 22,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
