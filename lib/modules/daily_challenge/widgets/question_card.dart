import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../models/pt_question.dart';
import '../provider/pt_challenge_controller.dart';

class QuestionCard extends StatelessWidget {
  final PtQuestion question;
  final PtChallengeController controller;

  const QuestionCard({
    super.key,
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.03),
              blurRadius: 18,
              offset: const Offset(0, 8),
            )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question difficulty tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                question.difficulty.toUpperCase(),
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Question Text
            Text(
              question.question,
              style: AppTextStyles.textPrimary16bold.copyWith(
                height: 1.35,
                fontWeight: FontWeight.w800,
                fontSize: 15.5,
              ),
            ),

            const SizedBox(height: 20),

            // Option Radio Boxes
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: question.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final isSelected = question.selectedOption == index;
                return GestureDetector(
                  onTap: () => controller.selectOption(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.gold.withValues(alpha: 0.05) : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? AppColors.gold : AppColors.border,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio dot
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.gold : AppColors.textHint,
                              width: isSelected ? 6 : 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Option Text
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13.5,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.textPrimary : AppColors.textPrimary.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Clear answer button
            if (question.selectedOption != null)
              Center(
                child: TextButton.icon(
                  onPressed: controller.clearAnswer,
                  icon: const Icon(Icons.refresh_rounded, size: 15, color: AppColors.textSecondary),
                  label: const Text(
                    'Clear Answer',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
