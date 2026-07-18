import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3EAD3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Title & Streak)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text('🔥 ', style: TextStyle(fontSize: 12)),
                    Text(
                      'TODAY\'S PT CHALLENGE',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: AppColors.goldDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFEF3C7), width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: Color(0xFFD97706), size: 10.5),
                      const SizedBox(width: 3),
                      Text(
                        '${controller.currentStreak} Days Streak',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD97706),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Card Content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's Topic Title
                      Text(
                        challenge.topic,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Questions count, Time, Difficulty
                      Row(
                        children: [
                          const Icon(Icons.description_outlined, size: 10.5, color: AppColors.textSecondary),
                          const SizedBox(width: 3),
                          Text(
                            '${challenge.totalQuestions} Qs  •  ',
                            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.timer_outlined, size: 10.5, color: AppColors.textSecondary),
                          const SizedBox(width: 3),
                          Text(
                            '${challenge.duration} Mins  •  ',
                            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              challenge.difficulty,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Stats: Attempted count & Top rank
                      Row(
                        children: [
                          const Icon(Icons.people_alt_outlined, size: 10.5, color: AppColors.textSecondary),
                          const SizedBox(width: 3),
                          Text(
                            '${controller.dailyAspirants.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Attempted  •  ',
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 9,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(Icons.emoji_events_outlined, size: 10.5, color: AppColors.goldDark),
                          const SizedBox(width: 3),
                          const Text(
                            'Top 76/80',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Right side graphic - Trophy
                Image.asset(
                  AppImage.trophyImg,
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.emoji_events_rounded, size: 38, color: AppColors.gold),
                )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: 0, end: -0.06, duration: 1500.ms, curve: Curves.easeInOutQuad),
              ],
            ),
          ),

          // Bottom Stats Row (Scorecard inline)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCF5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF3EAD3), width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _inlineStat('Score', '${challenge.lastScore ?? 15}/80'),
                      const SizedBox(width: 10),
                      _inlineStat('Accuracy', '${(challenge.lastAccuracy ?? 35).toStringAsFixed(0)}%'),
                      const SizedBox(width: 10),
                      _inlineStat('Time Taken', challenge.lastTimeTaken ?? '2m 20s'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGradient,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isAttempted) {
                          context.push(AppRoutes.dailyPtResult);
                        } else {
                          context.push(AppRoutes.dailyPtSelect);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(0, 0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isAttempted ? 'View Result' : 'Start Challenge',
                            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.bold, fontSize: 9.5, color: Colors.white),
                          ),
                          const SizedBox(width: 3),
                          const Icon(Icons.arrow_forward_rounded, size: 10.5, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inlineStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 11.5,
            fontWeight: FontWeight.w900,
            color: AppColors.goldDark,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 8,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
