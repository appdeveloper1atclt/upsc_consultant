import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class RulesWidget extends StatelessWidget {
  const RulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAF0), // Very light gold/beige background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0E5D0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.gavel_rounded, color: AppColors.goldMuted, size: 18),
              SizedBox(width: 8),
              Text(
                'Daily Challenge Rules',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.goldMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ruleItem(Icons.assignment_outlined, '20 Questions'),
              _ruleItem(Icons.timer_outlined, '20 Minutes'),
              _ruleItem(Icons.star_rounded, '+4 for Correct'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ruleItem(Icons.remove_circle_outline_rounded, '-1 for Incorrect'),
              _ruleItem(Icons.help_outline_rounded, 'Unattempted 0'),
              const SizedBox(width: 80),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ruleItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.goldMuted),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
