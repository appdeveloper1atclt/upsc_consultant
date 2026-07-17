import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/routes/approute.dart';
import '../provider/pt_challenge_controller.dart';
import '../widgets/result_leaderboard.dart';
import '../widgets/result_topic_performance.dart';
import '../widgets/result_ai_recommendation.dart';

class PtResultScreen extends StatelessWidget {
  const PtResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();
    final challenge = controller.currentChallenge;

    if (challenge == null) {
      return const Scaffold(body: Center(child: Text('No challenge active')));
    }

    final totalQs = controller.questions.length;
    final totalMarks = totalQs * 4;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.replace(AppRoutes.home),
        ),
        title: const Text(
          'Challenge Result',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          children: [
            // ── CONGRATULATIONS CARD ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF081B2F), Color(0xFF102A43)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Congratulations 🎉',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.goldLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have successfully completed the ${challenge.topic} Challenge!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Circular/Big Score Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Score block
                      Column(
                        children: [
                          Text(
                            '${controller.score}/$totalMarks',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'SCORE OBTAINED',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.goldLight,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      // Divider line
                      Container(width: 1, height: 40, color: Colors.white24),
                      // Rank block
                      Column(
                        children: [
                          Text(
                            '#${controller.rank}',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: AppColors.goldLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'TODAY\'S RANK',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      // Divider line
                      Container(width: 1, height: 40, color: Colors.white24),
                      // Accuracy block
                      Column(
                        children: [
                          Text(
                            '${controller.accuracy.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'ACCURACY',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── QUICK STATS GRID ──────────────────────────────────────────────
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.1,
              ),
              children: [
                _statCard('Correct Answers', '${controller.correctCount}', Colors.green, Icons.check_circle_rounded),
                _statCard('Wrong Answers', '${controller.wrongCount}', Colors.red, Icons.cancel_rounded),
                _statCard('Skipped / Skipped', '${controller.skippedCount}', Colors.grey, Icons.help_rounded),
                _statCard('Time Taken', controller.timeTakenString, AppColors.goldDark, Icons.timer_outlined),
              ],
            ),

            const SizedBox(height: 24),

            // ── LEADERBOARD SECTION ──────────────────────────────────────────
            ResultLeaderboard(controller: controller),

            const SizedBox(height: 24),

            // ── TOPIC WISE BREAKDOWN ──────────────────────────────────────────
            ResultTopicPerformance(controller: controller),

            const SizedBox(height: 24),

            // ── AI RECOMMENDATION BOX ─────────────────────────────────────────
            const ResultAiRecommendation(),

            const SizedBox(height: 28),

            // ── ACTION BUTTONS ────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        context.push(AppRoutes.dailyPtPreview);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: AppColors.gold, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Review Answers',
                        style: TextStyle(color: AppColors.goldDark, fontWeight: FontWeight.bold, fontSize: 14.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Reset and retry
                        controller.resetState(challenge);
                        context.replace(AppRoutes.dailyPtQuiz);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.primaryDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Retry Challenge',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => context.replace(AppRoutes.home),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
