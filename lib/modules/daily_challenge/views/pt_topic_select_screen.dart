import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/routes/approute.dart';
import '../provider/pt_challenge_controller.dart';
import '../widgets/rules_widget.dart';
import '../widgets/topic_card.dart';

class PtTopicSelectScreen extends StatelessWidget {
  const PtTopicSelectScreen({super.key});

  // Custom colors for different topics to match the screenshot
  static const Map<String, Map<String, dynamic>> topicStyles = {
    'Indian Polity': {'color': Color(0xFF2E7D32), 'icon': Icons.account_balance_rounded},
    'Indian Economy': {'color': Color(0xFFEF6C00), 'icon': Icons.currency_rupee_rounded},
    'Geography': {'color': Color(0xFF1565C0), 'icon': Icons.public_rounded},
    'History': {'color': Color(0xFF8D6E63), 'icon': Icons.museum_rounded},
    'Environment': {'color': Color(0xFF2E7D32), 'icon': Icons.eco_outlined},
    'Science & Tech': {'color': Color(0xFF6A1B9A), 'icon': Icons.biotech_rounded},
    'Current Affairs': {'color': Color(0xFF00838F), 'icon': Icons.article_rounded},
    'International Relations': {'color': Color(0xFF4527A0), 'icon': Icons.language_rounded},
  };

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();
    final challenges = controller.getChallenges();

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
          'Daily PT Challenge',
          style: AppTextStyles.textPrimary18bold.copyWith(fontSize: 19),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.textPrimary),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select a Topic Header Row with Bullseye Graphic
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 0.8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select a Topic',
                            style: AppTextStyles.textPrimary16bold.copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose a topic to start today\'s challenge and test your skills.',
                            style: AppTextStyles.textSecondary13normal.copyWith(height: 1.3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      AppImage.targetImg,
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.track_changes_rounded,
                        size: 60,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Topics List
              Text(
                'UPSC CSE Syllabus Topics',
                style: AppTextStyles.textPrimary14semibold.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: challenges.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final challenge = challenges[index];
                  final style = topicStyles[challenge.topic] ?? {
                    'color': AppColors.primary,
                    'icon': Icons.assignment_rounded,
                  };
                  return TopicCard(
                    challenge: challenge,
                    icon: style['icon'] as IconData,
                    themeColor: style['color'] as Color,
                    onTap: () {
                      context.push(AppRoutes.dailyPtInstructions, extra: challenge);
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // Rules section
              const RulesWidget(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Daily PT Challenge Info', style: AppTextStyles.textPrimary16bold),
        content: const Text(
          'Daily PT Challenges are specially formulated questions by retired UPSC experts. Each topic has daily test sets of 20 questions each, designed to sharpen your elimination skills under strict exam conditions.',
          style: AppTextStyles.textSecondary13normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
