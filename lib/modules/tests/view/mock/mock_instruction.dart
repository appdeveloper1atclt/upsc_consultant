import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mock_quiz.dart';

class MockInstruction extends StatelessWidget {
  final String testTitle;

  const MockInstruction({super.key, required this.testTitle});

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
          'Test Instructions',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock details header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testTitle,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _DetailBadge('100 Qs', Icons.description_outlined),
                        _DetailBadge('120 Mins', Icons.timer_outlined),
                        _DetailBadge('200 Marks', Icons.emoji_events_outlined),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Rules Heading
              const Text(
                'Please read the rules carefully:',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 14),

              // Rules details
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildRuleRow('1', 'Each question carries 2 marks of value.'),
                      const SizedBox(height: 12),
                      _buildRuleRow('2', 'There is a negative marking of 0.66 marks for every wrong answer choice.'),
                      const SizedBox(height: 12),
                      _buildRuleRow('3', 'Your answers are automatically submitted if the countdown timer hits zero.'),
                      const SizedBox(height: 12),
                      _buildRuleRow('4', 'Do not close or minimize the application, doing so may invalidate your progress.'),
                    ],
                  ),
                ),
              ),

              // Begin test button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MockQuiz(testTitle: testTitle),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Begin Test', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleRow(String num, String ruleText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            num,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            ruleText,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _DetailBadge(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
