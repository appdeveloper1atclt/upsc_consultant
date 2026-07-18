import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mains_submit.dart';

class MainsAiEvaluationScreen extends StatefulWidget {
  final String paperTitle;
  const MainsAiEvaluationScreen({super.key, required this.paperTitle});

  @override
  State<MainsAiEvaluationScreen> createState() => _MainsAiEvaluationScreenState();
}

class _MainsAiEvaluationScreenState extends State<MainsAiEvaluationScreen> {
  int _freeEvaluationsLeft = 5;
  bool _isLoading = false;
  bool _evaluated = false;

  void _runAiEvaluation() {
    setState(() {
      _isLoading = true;
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _evaluated = true;
        _freeEvaluationsLeft = _freeEvaluationsLeft - 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Evaluation',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _isLoading
              ? _buildLoadingState()
              : _evaluated
                  ? _buildResultState()
                  : _freeEvaluationsLeft > 0
                      ? _buildInitialState()
                      : _buildLimitReachedState(),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 20),
            Text(
              'AI is evaluating your answer...',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            SizedBox(height: 8),
            Text(
              'Analyzing structure, content & formatting',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Icon Header Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
          ),
          child: const Column(
            children: [
              Icon(Icons.bolt_rounded, size: 50, color: Color(0xFF7C3AED)),
              SizedBox(height: 12),
              Text(
                '⚡ AI Evaluation',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              SizedBox(height: 6),
              Text(
                'Instant detailed analysis powered by AI',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Features list
        const Text(
          'What you get:',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        _buildFeatureItem('Instant Evaluation'),
        _buildFeatureItem('Score'),
        _buildFeatureItem('Structure Analysis'),
        _buildFeatureItem('Content Analysis'),
        _buildFeatureItem('Missing Points'),
        _buildFeatureItem('Improvement Tips'),
        const SizedBox(height: 24),

        // Count indicator
        Center(
          child: Text(
            '$_freeEvaluationsLeft Free Evaluations Remaining',
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED)),
          ),
        ),
        const SizedBox(height: 16),

        // Action button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _runAiEvaluation,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Evaluate with AI', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF7C3AED), size: 18),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitReachedState() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        const Icon(Icons.lock_clock_rounded, size: 64, color: AppColors.gold),
        const SizedBox(height: 20),
        const Text(
          'AI Evaluation Limit Reached',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        const Text(
          'Upgrade to Platinum to get unlimited evaluations for all Mains answers.',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.gold.withOpacity(0.2)),
          ),
          child: const Column(
            children: [
              Text(
                'PLATINUM PLAN BENEFITS',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.goldDark, letterSpacing: 1),
              ),
              SizedBox(height: 12),
              Text(
                '✔ Unlimited AI Evaluations\n✔ Priority 1-on-1 Mentor Reviews\n✔ Real UPSC Toppers Copy Analysis\n✔ Hardcopy Answer Writing Sheets',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textPrimary, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumUpgradePaywall()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Upgrade Now', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildResultState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Score banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFDCFCE7), width: 1),
          ),
          child: const Column(
            children: [
              Text(
                'AI Score',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
              ),
              SizedBox(height: 4),
              Text(
                '8.5 / 15 Marks',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF15803D)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Section breakdown
        const Text('Structure Analysis', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        const Text(
          'Excellent introduction defining the core constitutional articles. However, the body structure could be improved with separate headings for challenges.',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 16),

        const Text('Content Analysis', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        const Text(
          'Mentioned the 73rd Constitutional Amendment Act, devolution of powers, and administrative concerns. Facts are 90% accurate.',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 16),

        const Text('Missing Points', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        const Text(
          '• Highlight the recommendations of the Second Administrative Reforms Commission (ARC).\n• Include issues like "Proxy representation" (Sarpanch Pati).',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.5),
        ),
        const SizedBox(height: 16),

        const Text('Improvement Tips', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        const Text(
          '• Focus on formatting: use bullet points instead of long paragraphs.\n• Conclude with a forward-looking vision like Sabka Saath Sabka Vikas.',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.5),
        ),
        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Back to Questions', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class MainsMentorEvaluationScreen extends StatelessWidget {
  final String paperTitle;
  const MainsMentorEvaluationScreen({super.key, required this.paperTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mentor Evaluation',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mentor Icon Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFDE68A), width: 1),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.face_rounded, size: 50, color: AppColors.gold),
                    SizedBox(height: 12),
                    Text(
                      '👨‍🏫 Mentor Evaluation',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Detailed human review from veteran UPSC administrators',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Benefits list
              const Text(
                'What you get:',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildBenefitItem('Real UPSC Mentor'),
              _buildBenefitItem('Personal Feedback'),
              _buildBenefitItem('Handwritten Suggestions'),
              _buildBenefitItem('Improvement Strategy'),
              _buildBenefitItem('Doubt Session Included'),
              const SizedBox(height: 20),

              // Duration banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule_rounded, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Text(
                      'Estimated Time: 24-48 Hours',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Premium paywall page as requested (Estimated Time -> Submit to Mentor -> Tap -> Premium page)
                    Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PremiumUpgradePaywall(),
                      ),
                    ).then((success) {
                      if (success == true && context.mounted) {
                        // After premium interaction, submit answer successfully
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainsSubmit(paperTitle: paperTitle)),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Submit to Mentor', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          const Icon(Icons.verified_outlined, color: AppColors.gold, size: 18),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class PremiumUpgradePaywall extends StatelessWidget {
  final VoidCallback? onSubmitSuccess;
  const PremiumUpgradePaywall({super.key, this.onSubmitSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Platinum Premium Upgrade',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.workspace_premium_rounded, size: 70, color: AppColors.gold),
              const SizedBox(height: 20),
              const Text(
                'Unlock UPSC Platinum 👑',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              const Text(
                'Get unlimited AI evaluations, priority expert reviews, doubt-clearing sessions, and access to all standard mains test series.',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, color: AppColors.textSecondary, height: 1.45),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Pricing option card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.gold, width: 1.5),
                  boxShadow: [
                    BoxShadow(color: AppColors.gold.withOpacity(0.08), blurRadius: 12),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      'PLATINUM PACK',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldMuted, letterSpacing: 1.2),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '₹4,999 / Year',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Save 60% compared to individual reviews',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Buy CTA
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Simulate successful purchase and trigger callback
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Successful! Welcome to Platinum Premium!')),
                    );
                    Navigator.pop(context, true);
                    if (onSubmitSuccess != null) {
                      onSubmitSuccess!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Unlock Premium Access', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Maybe Later',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
