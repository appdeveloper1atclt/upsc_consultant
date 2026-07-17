import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/routes/approute.dart';
import '../models/daily_challenge.dart';
import '../provider/pt_challenge_controller.dart';

class PtInstructionsScreen extends StatefulWidget {
  final DailyChallenge challenge;

  const PtInstructionsScreen({super.key, required this.challenge});

  @override
  State<PtInstructionsScreen> createState() => _PtInstructionsScreenState();
}

class _PtInstructionsScreenState extends State<PtInstructionsScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Challenge Instructions',
          style: AppTextStyles.textPrimary18bold.copyWith(fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Info Panel
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border, width: 0.8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'TODAY\'S PT CHALLENGE',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.goldDark,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.orange.withValues(alpha: 0.2), width: 0.5),
                                ),
                                child: Text(
                                  challenge.difficulty,
                                  style: const TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            challenge.topic,
                            style: AppTextStyles.textPrimary22bold.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.help_outline_rounded, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                '${challenge.totalQuestions} MCQs',
                                style: AppTextStyles.textSecondary12medium,
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                '${challenge.duration} Minutes',
                                style: AppTextStyles.textSecondary12medium,
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.stars_rounded, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                '${challenge.totalMarks} Marks',
                                style: AppTextStyles.textSecondary12medium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Read Carefully Section
                    const Text(
                      'Read Carefully',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Instructions checklist
                    _instructionRow('20 High-Quality UPSC standard Questions'),
                    _instructionRow('20 Minutes countdown strict timer limit'),
                    _instructionRow('+4 Marks awarded for every correct answer'),
                    _instructionRow('-1 Mark deducted for every incorrect answer'),
                    _instructionRow('No negative marking for skipped/unattempted questions'),
                    _instructionRow('Auto submit will trigger automatically when the timer reaches 0'),
                    _instructionRow('Offline mode supported - Internet is not mandatory during test'),
                    _instructionRow('Do not switch applications or answer calls; doing so may forfeit progress'),
                  ],
                ),
              ),
            ),

            // Bottom Checkbox & Button Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreed,
                        activeColor: AppColors.gold,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) {
                          setState(() {
                            _agreed = val ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'I agree to the test instructions and academic integrity rules. I will attempt the challenge honestly.',
                            style: AppTextStyles.textSecondary12medium.copyWith(height: 1.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _agreed
                          ? () {
                              // Initialize state inside provider
                              final controller = context.read<PtChallengeController>();
                              controller.startChallenge(challenge);
                              context.replace(AppRoutes.dailyPtQuiz);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        disabledBackgroundColor: AppColors.border,
                        foregroundColor: AppColors.primaryDark,
                        disabledForegroundColor: AppColors.textHint,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'Start Test',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _instructionRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.textSecondary13normal.copyWith(
                color: AppColors.textPrimary.withValues(alpha: 0.9),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
