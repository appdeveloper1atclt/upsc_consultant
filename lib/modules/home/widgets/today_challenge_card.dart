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
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Title & Streak)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      '🔥 ',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'TODAY\'S PT CHALLENGE',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEA580C),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFEE2E2), width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: Color(0xFFEF4444), size: 13),
                      const SizedBox(width: 4),
                      Text(
                        '${controller.currentStreak} Days Streak',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFEF4444),
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular Parliament Image
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1600664901892-7fd1404c680e?w=150',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.account_balance_rounded, color: AppColors.primary, size: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's Topic Title
                      Text(
                        challenge.topic,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Questions count & Time specs
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.person_outline_rounded, size: 12, color: AppColors.textSecondary),
                              SizedBox(width: 4),
                              Text(
                                '${challenge.totalQuestions} Questions',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.access_time_rounded, size: 12, color: AppColors.textSecondary),
                              SizedBox(width: 4),
                              Text(
                                '${challenge.duration} Min',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Text(
                            '+4 / -1',
                            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Difficulty, Aspirants and Top
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.bar_chart_rounded, size: 11, color: Color(0xFFD97706)),
                                const SizedBox(width: 3),
                                Text(
                                  challenge.difficulty,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD97706),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.people_alt_outlined, size: 11, color: AppColors.textSecondary),
                              const SizedBox(width: 3),
                              Text(
                                '${controller.dailyAspirants.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Attempted',
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.emoji_events_outlined, size: 11, color: AppColors.goldDark),
                              SizedBox(width: 3),
                              Text(
                                'Top 76/80',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldDark,
                                ),
                              ),
                            ],
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
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.emoji_events_rounded, size: 48, color: AppColors.gold),
                )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: 0, end: -0.06, duration: 1500.ms, curve: Curves.easeInOutQuad),
              ],
            ),
          ),

          // Bottom Stats Row (Scorecard inline)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
              ),
              child: Row(
                children: [
                  _inlineStat('Score', '${challenge.lastScore ?? 15}/80'),
                  const SizedBox(width: 16),
                  _inlineStat('Accuracy', '${(challenge.lastAccuracy ?? 35).toStringAsFixed(0)}%'),
                  const SizedBox(width: 16),
                  _inlineStat('Time Taken', challenge.lastTimeTaken ?? '2m 20s'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (isAttempted) {
                        context.push(AppRoutes.dailyPtResult);
                      } else {
                        context.push(AppRoutes.dailyPtSelect);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.primaryDark,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(0, 0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          isAttempted ? 'View Result' : 'Start Challenge',
                          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w800, fontSize: 12),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, size: 13, color: AppColors.primaryDark),
                      ],
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
            fontSize: 14.5,
            fontWeight: FontWeight.w900,
            color: AppColors.goldDark,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 9.5,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
