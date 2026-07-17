import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../models/daily_challenge.dart';

class TopicCard extends StatelessWidget {
  final DailyChallenge challenge;
  final IconData icon;
  final Color themeColor;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.challenge,
    required this.icon,
    required this.themeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const int questionsAvailable = 120;
    final int completionPercent = challenge.attempted ? 100 : (challenge.id == 'today_polity' ? 35 : 0);
    final String bestScore = challenge.attempted ? '${challenge.lastScore}/80' : (challenge.id == 'today_polity' ? '56/80' : 'N/A');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: themeColor, size: 26),
              ),
              const SizedBox(width: 14),

              // Title and Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.topic,
                      style: AppTextStyles.textPrimary16bold.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$questionsAvailable Questions Available',
                      style: AppTextStyles.textSecondary12medium.copyWith(fontSize: 11),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'Difficulty: ',
                          style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 10),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(challenge.difficulty).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            challenge.difficulty,
                            style: AppTextStyles.textPrimary10bold.copyWith(
                              color: _getDifficultyColor(challenge.difficulty),
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Start button
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: challenge.attempted ? AppColors.chipBackground : AppColors.gold,
                  foregroundColor: challenge.attempted ? AppColors.textSecondary : AppColors.primaryDark,
                  elevation: 0,
                  minimumSize: const Size(64, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  challenge.attempted ? 'Review' : 'Start',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),

          // Completion Status and Progress Bar
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completion: $completionPercent%',
                style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 10),
              ),
              Text(
                'Best Score: $bestScore',
                style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 10),
              ),
              Text(
                challenge.attempted ? 'Attempted Today' : 'Not Attempted',
                style: AppTextStyles.textSecondary11semibold.copyWith(
                  fontSize: 10,
                  color: challenge.attempted ? AppColors.success : AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: completionPercent / 100,
              backgroundColor: AppColors.divider,
              color: completionPercent == 100 ? AppColors.success : themeColor,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String diff) {
    switch (diff) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }
}
