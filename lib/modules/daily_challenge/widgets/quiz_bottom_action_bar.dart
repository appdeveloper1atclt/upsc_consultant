import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../provider/pt_challenge_controller.dart';

class QuizBottomActionBar extends StatelessWidget {
  final PtChallengeController controller;
  final PageController pageController;
  final VoidCallback onPaletteTap;
  final VoidCallback onSubmitTap;

  const QuizBottomActionBar({
    super.key,
    required this.controller,
    required this.pageController,
    required this.onPaletteTap,
    required this.onSubmitTap,
  });

  @override
  Widget build(BuildContext context) {
    final idx = controller.currentQuestionIndex;
    final total = controller.questions.length;
    final currentQ = controller.currentQuestion;

    final bool hasPrev = idx > 0;
    final bool hasNext = idx < total - 1;
    final bool isMarked = currentQ?.isMarkedReview ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: OutlinedButton(
              onPressed: hasPrev
                  ? () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 44),
                side: BorderSide(color: hasPrev ? AppColors.border : Colors.transparent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chevron_left_rounded, size: 16, color: hasPrev ? AppColors.textPrimary : AppColors.textHint),
                  const SizedBox(width: 2),
                  Text(
                    'Previous',
                    style: TextStyle(color: hasPrev ? AppColors.textPrimary : AppColors.textHint, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Mark for review button
          TextButton(
            onPressed: controller.toggleMarkForReview,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isMarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  size: 20,
                  color: isMarked ? Colors.amber[800] : AppColors.textSecondary,
                ),
                const SizedBox(height: 2),
                Text(
                  'Mark Review',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: isMarked ? Colors.amber[800] : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),

          // Palette button
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: AppColors.textPrimary, size: 22),
            onPressed: onPaletteTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Question Palette',
          ),
          const SizedBox(width: 8),

          // Next/Submit button
          Expanded(
            child: ElevatedButton(
              onPressed: hasNext
                  ? () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }
                  : onSubmitTap,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 44),
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.primaryDark,
                disabledBackgroundColor: AppColors.border,
                disabledForegroundColor: AppColors.textHint,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hasNext ? 'Next' : 'Submit',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    hasNext ? Icons.chevron_right_rounded : Icons.check_rounded,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
