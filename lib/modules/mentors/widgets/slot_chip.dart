import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

class SlotChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SlotChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : AppColors.chipBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.gold : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? AppTextStyles.chipSelected.copyWith(color: AppColors.white)
              : AppTextStyles.chipUnselected,
        ),
      ),
    );
  }
}
