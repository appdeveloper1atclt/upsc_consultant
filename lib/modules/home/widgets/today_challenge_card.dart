import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/routes/approute.dart';
import '../../daily_challenge/provider/pt_challenge_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TodayChallengeCard extends StatelessWidget {
  const TodayChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();
    final challenge = controller.getTodayChallenge();

    if (challenge == null) {
      return const SizedBox.shrink();
    }

    final isAttempted = challenge.attempted;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2537),
            Color(0xFF081521),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Title & Streak)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const Text(
                    '🔥 Today\'s PT Challenge',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: AppColors.goldLight,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3), width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 12),
                      const SizedBox(width: 2.5),
                      Text(
                        '${controller.currentStreak} Days Streak',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.white10),

          // Main Card Content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's Topic Title
                      Text(
                        challenge.topic,
                        style: AppTextStyles.textPrimary18bold.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          height: 1.15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Questions count & Time specs
                      Text(
                        '${challenge.totalQuestions} Questions • ${challenge.duration} Min • +4 / -1',
                        style: AppTextStyles.textSecondary12medium.copyWith(fontSize: 11, color: Colors.white.withValues(alpha: 0.65)),
                      ),

                      const SizedBox(height: 8),
                      // Combined single line specs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Icon(Icons.bar_chart_rounded, size: 11, color: Colors.white70),
                            const SizedBox(width: 3),
                            Text(
                              challenge.difficulty,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getDifficultyColor(challenge.difficulty),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.people_alt_outlined, size: 11, color: Colors.white70),
                            const SizedBox(width: 3),
                            Text(
                              '${controller.dailyAspirants} Aspirants',
                              style: const TextStyle(fontSize: 10, color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.emoji_events_outlined, size: 11, color: AppColors.goldLight),
                            const SizedBox(width: 3),
                            const Text(
                              'Top: 76/80',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Right side graphic - Trophy
                Column(
                  children: [
                    Image.asset(
                      AppImage.trophyImg,
                      width: 52,
                      height: 52,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.emoji_events_rounded, size: 45, color: AppColors.gold),
                    )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .slideY(begin: 0, end: -0.08, duration: 1500.ms, curve: Curves.easeInOutQuad),
                  ],
                ),
              ],
            ),
          ),

          // If attempt is completed: show scorecard inline
          if (isAttempted) ...[
            const Divider(height: 1, color: Colors.white10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _inlineStat('Score', '${challenge.lastScore ?? 0}/80', isGold: true),
                    _inlineStat('Accuracy', '${(challenge.lastAccuracy ?? 0).toStringAsFixed(0)}%', isGold: true),
                    _inlineStat('Time', challenge.lastTimeTaken ?? '0m', isGold: true),
                  ],
                ),
              ),
            ),
          ],

          const Divider(height: 1, color: Colors.white10),

          // Button Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: isAttempted
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.push(AppRoutes.dailyPtResult);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.primaryDark,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('View Result', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.push(AppRoutes.dailyPtPreview);
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              side: const BorderSide(color: AppColors.goldLight, width: 1.2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Review Answers', style: TextStyle(color: AppColors.goldLight, fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.push(AppRoutes.dailyPtSelect);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.primaryDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Start Challenge', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 15),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String diff) {
    switch (diff) {
      case 'Easy':
        return Colors.greenAccent;
      case 'Medium':
        return Colors.orangeAccent;
      case 'Hard':
        return Colors.redAccent;
      default:
        return AppColors.goldLight;
    }
  }

  Widget _inlineStat(String label, String value, {bool isGold = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: isGold ? AppColors.goldLight : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            color: isGold ? Colors.white60 : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
