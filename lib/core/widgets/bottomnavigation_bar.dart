import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
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
          _item(Icons.home_rounded, 'Home', 0),
          _item(Icons.supervised_user_circle_rounded, 'Mentors', 1),
          _scanItem(2),
          _item(Icons.assignment_outlined, 'Tests', 3),
          _item(Icons.person_outline_rounded, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, int index) {
    final selected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: selected ? AppColors.gold : AppColors.textSecondary),
          const SizedBox(height: 3),
          Text(
            title,
            style: selected ? AppTextStyles.gold95bold : AppTextStyles.textSecondary95bold,
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
        child: const Icon(Icons.document_scanner_outlined, color: AppColors.primaryDark, size: 20),
      ),
    );
  }
}
