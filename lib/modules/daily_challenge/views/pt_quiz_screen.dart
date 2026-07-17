import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/routes/approute.dart';
import '../provider/pt_challenge_controller.dart';
import '../models/pt_question.dart';
import '../widgets/timer_text_widget.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_bottom_action_bar.dart';

class PtQuizScreen extends StatefulWidget {
  const PtQuizScreen({super.key});

  @override
  State<PtQuizScreen> createState() => _PtQuizScreenState();
}

class _PtQuizScreenState extends State<PtQuizScreen> {
  late PageController _pageController;
  bool _snackBarTriggered = false;

  @override
  void initState() {
    super.initState();
    final controller = context.read<PtChallengeController>();
    _pageController = PageController(initialPage: controller.currentQuestionIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Handle dialog submission confirmation
  void _confirmSubmit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Submit Challenge?', style: AppTextStyles.textPrimary16bold),
        content: const Text(
          'Are you sure you want to submit your answers? Once submitted, your scores and rank will be calculated.',
          style: AppTextStyles.textSecondary13normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<PtChallengeController>().submitChallenge();
              context.replace(AppRoutes.dailyPtResult);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.primaryDark,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Yes, Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();
    final currentQ = controller.currentQuestion;
    final questions = controller.questions;

    if (currentQ == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Monitor remaining time for alerts
    final time = controller.remainingTime;
    if (time <= 30 && !_snackBarTriggered) {
      _snackBarTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Only 30 seconds left! Hurry up!'),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 3),
          ),
        );
        HapticFeedback.vibrate();
      });
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Pause timer and show warning
        controller.pauseChallenge();
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Exit Challenge?', style: AppTextStyles.textPrimary16bold),
            content: const Text(
              'If you exit now, your current progress will be saved, and you can resume from the Home screen.',
              style: AppTextStyles.textSecondary13normal,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  controller.resumeChallenge();
                },
                child: const Text('Resume Quiz', style: TextStyle(color: AppColors.gold)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.replace(AppRoutes.home);
                },
                child: const Text('Exit Quiz', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
            onPressed: () {
              controller.pauseChallenge();
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: const Text('Exit Challenge?', style: AppTextStyles.textPrimary16bold),
                  content: const Text(
                    'If you exit now, your current progress will be saved, and you can resume from the Home screen.',
                    style: AppTextStyles.textSecondary13normal,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        controller.resumeChallenge();
                      },
                      child: const Text('Resume Quiz', style: TextStyle(color: AppColors.gold)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.replace(AppRoutes.home);
                      },
                      child: const Text('Exit Quiz', style: TextStyle(color: AppColors.error)),
                    ),
                  ],
                ),
              );
            },
          ),
          title: Text(
            controller.currentChallenge?.topic ?? 'Quiz',
            style: AppTextStyles.textPrimary18bold.copyWith(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                currentQ.bookmark ? Icons.star_rounded : Icons.star_border_rounded,
                color: currentQ.bookmark ? AppColors.gold : AppColors.textPrimary,
                size: 26,
              ),
              onPressed: () => controller.toggleBookmark(controller.currentQuestionIndex),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Timer & Progress Header Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Linear Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (controller.currentQuestionIndex + 1) / questions.length,
                        backgroundColor: AppColors.divider,
                        color: AppColors.gold,
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Timer Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Countdown Timer Widget
                        TimerTextWidget(time: time),

                        // Position Count
                        Text(
                          '${controller.currentQuestionIndex + 1} / ${questions.length}',
                          style: AppTextStyles.textPrimary14semibold.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Question Area (PageView)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    controller.selectQuestion(index);
                  },
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final q = questions[index];
                    return QuestionCard(question: q, controller: controller);
                  },
                ),
              ),

              // Bottom control actions
              QuizBottomActionBar(
                controller: controller,
                pageController: _pageController,
                onPaletteTap: () => _showPaletteBottomSheet(context, controller),
                onSubmitTap: () => _confirmSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Question Palette Bottom Sheet
  void _showPaletteBottomSheet(BuildContext context, PtChallengeController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Question Palette',
              style: AppTextStyles.textPrimary16bold.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),

            // Palette Grid
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.questions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (ctx, index) {
                  final q = controller.questions[index];
                  final isCurrent = index == controller.currentQuestionIndex;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getPaletteColor(q, isCurrent),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCurrent ? AppColors.gold : AppColors.border,
                          width: isCurrent ? 2.5 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _getPaletteTextColor(q, isCurrent),
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

            const SizedBox(height: 24),

            // Legend indicators
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: [
                _legendItem(Colors.green, 'Answered'),
                _legendItem(Colors.amber, 'Review'),
                _legendItem(Colors.grey[800]!, 'Visited'),
                _legendItem(Colors.white, 'Not Visited'),
                _legendItem(Colors.blue, 'Current'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[400]!, width: 0.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Color _getPaletteColor(PtQuestion q, bool isCurrent) {
    if (isCurrent) return Colors.blue[100]!;
    if (q.selectedOption != null) return Colors.green;
    if (q.isMarkedReview) return Colors.amber;
    if (q.isVisited) return Colors.grey[800]!;
    return Colors.white;
  }

  Color _getPaletteTextColor(PtQuestion q, bool isCurrent) {
    if (isCurrent) return Colors.blue[900]!;
    if (q.selectedOption != null || q.isVisited) return Colors.white;
    if (q.isMarkedReview) return Colors.black87;
    return AppColors.textPrimary;
  }
}
