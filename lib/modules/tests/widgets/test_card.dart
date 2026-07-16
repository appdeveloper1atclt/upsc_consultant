import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';

class TestSeries {
  final String title;
  final String subtitle;
  final String type;
  final String duration;
  final String questions;
  final bool premium;

  const TestSeries({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.duration,
    required this.questions,
    required this.premium,
  });
}

class TestCard extends StatelessWidget {
  final TestSeries test;
  final VoidCallback onStartTap;

  const TestCard({
    super.key,
    required this.test,
    required this.onStartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  test.type,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              if (test.premium)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.premiumBadge,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.premiumBorder, width: 0.5),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star_rounded, size: 10, color: AppColors.goldDark),
                      SizedBox(width: 2),
                      Text(
                        'PREMIUM',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.goldDark,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            test.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            test.subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 13, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(
                    test.duration,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.help_outline_rounded, size: 13, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(
                    test.questions,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onStartTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.primaryDark,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
                child: const Text('Start Test'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
