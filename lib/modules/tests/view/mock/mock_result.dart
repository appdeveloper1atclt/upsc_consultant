import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class MockResult extends StatelessWidget {
  final String testTitle;
  final int correctCount;
  final int totalQuestions;

  const MockResult({
    super.key,
    required this.testTitle,
    required this.correctCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double accuracy = totalQuestions > 0 ? (correctCount / totalQuestions) * 100 : 0;
    final int wrongCount = totalQuestions - correctCount;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Mock Exam Results',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),

              // Circular progress score ring
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withOpacity(0.15), width: 12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$correctCount',
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 34, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      const Divider(color: AppColors.divider, height: 1, indent: 40, endIndent: 40),
                      Text(
                        '$totalQuestions',
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title and motivation message
              const Text(
                'Mock Session Completed! 🏁',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'You completed the $testTitle exam.',
                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Breakdown summary container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatDetail('Accuracy', '${accuracy.toInt()}%', Colors.blue),
                    Container(width: 1, height: 40, color: const Color(0xFFEDF2F7)),
                    _buildStatDetail('Correct', '$correctCount Qs', Colors.green),
                    Container(width: 1, height: 40, color: const Color(0xFFEDF2F7)),
                    _buildStatDetail('Incorrect', '$wrongCount Qs', Colors.red),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Done CTA button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Return to Mock Home
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back to Mocks Home', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatDetail(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16.5, fontWeight: FontWeight.w800, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
