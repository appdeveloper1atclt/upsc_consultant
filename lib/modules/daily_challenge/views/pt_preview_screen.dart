import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../provider/pt_challenge_controller.dart';
import '../models/pt_question.dart';

class PtPreviewScreen extends StatefulWidget {
  const PtPreviewScreen({super.key});

  @override
  State<PtPreviewScreen> createState() => _PtPreviewScreenState();
}

class _PtPreviewScreenState extends State<PtPreviewScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();
    final questions = controller.questions;

    if (questions.isEmpty) {
      return const Scaffold(body: Center(child: Text('No questions available to review')));
    }

    final currentQ = questions[_selectedIndex];

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Review Answers',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── HORIZONTAL QUESTION SELECTION GRID ────────────────────────────
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: questions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, index) {
                  final q = questions[index];
                  final isCurrent = index == _selectedIndex;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _getReviewColor(q),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCurrent ? AppColors.gold : AppColors.border,
                          width: isCurrent ? 2.5 : 1,
                        ),
                        boxShadow: isCurrent
                            ? [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 1)]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _getReviewTextColor(q),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ── MAIN QUESTION PREVIEW CARD ────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                      // Header: Q Number & Bookmark Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.chipBackground,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'QUESTION ${_selectedIndex + 1}',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              currentQ.bookmark ? Icons.star_rounded : Icons.star_border_rounded,
                              color: currentQ.bookmark ? AppColors.gold : AppColors.textSecondary,
                              size: 24,
                            ),
                            onPressed: () => controller.toggleBookmark(_selectedIndex),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Question Text
                      Text(
                        currentQ.question,
                        style: AppTextStyles.textPrimary16bold.copyWith(
                          height: 1.35,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Options highlighting correct / incorrect
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentQ.options.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (ctx, index) {
                          final isUserChoice = currentQ.selectedOption == index;
                          final isCorrect = currentQ.correctAnswer == index;

                          Color borderCol = AppColors.border;
                          Color bgCol = Colors.transparent;
                          Widget? suffixIcon;
                          String? badgeText;

                          if (isCorrect) {
                            borderCol = AppColors.success;
                            bgCol = AppColors.success.withValues(alpha: 0.05);
                            suffixIcon = const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18);
                            badgeText = isUserChoice ? 'Your Answer (Correct)' : 'Correct Answer';
                          } else if (isUserChoice) {
                            borderCol = AppColors.error;
                            bgCol = AppColors.error.withValues(alpha: 0.05);
                            suffixIcon = const Icon(Icons.cancel_rounded, color: AppColors.error, size: 18);
                            badgeText = 'Your Answer (Incorrect)';
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: bgCol,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: borderCol, width: isCorrect || isUserChoice ? 1.5 : 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (badgeText != null) ...[
                                  Text(
                                    badgeText.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: isCorrect ? AppColors.success : AppColors.error,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentQ.options[index],
                                        style: TextStyle(
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 13,
                                          fontWeight: isCorrect || isUserChoice ? FontWeight.bold : FontWeight.w500,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (suffixIcon != null) ...[
                                      const SizedBox(width: 8),
                                      suffixIcon,
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Explanation section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Explanation',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentQ.explanation,
                              style: AppTextStyles.textSecondary13normal.copyWith(
                                color: AppColors.textPrimary.withValues(alpha: 0.85),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _selectedIndex > 0
                          ? () {
                              setState(() {
                                _selectedIndex--;
                              });
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      ),
                      child: const Text(
                        'Previous',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedIndex < questions.length - 1
                          ? () {
                              setState(() {
                                _selectedIndex++;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.primaryDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      ),
                      child: const Text(
                        'Next',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getReviewColor(PtQuestion q) {
    if (q.selectedOption == null) return Colors.grey[300]!;
    if (q.selectedOption == q.correctAnswer) return Colors.green.withValues(alpha: 0.9);
    return Colors.red.withValues(alpha: 0.9);
  }

  Color _getReviewTextColor(PtQuestion q) {
    if (q.selectedOption == null) return AppColors.textSecondary;
    return Colors.white;
  }
}
