import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class ResultAiRecommendation extends StatelessWidget {
  const ResultAiRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F5), // Light greenish/blue premium bg
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2EDE4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.psychology_rounded, color: AppColors.success, size: 20),
              SizedBox(width: 8),
              Text(
                'AI Recommendations',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Based on your quiz performance, we recommend revising the following key topics in Indian Polity and Indian Economy:',
            style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, height: 1.35),
          ),
          const SizedBox(height: 12),

          _aiItem('Parliamentary System & Functions'),
          _aiItem('Fundamental Rights (FR) Article 14-32'),
          _aiItem('Directive Principles of State Policy (DPSP)'),
          _aiItem('Union Budget concepts & Fiscal Deficit'),

          const SizedBox(height: 16),

          // Materials action buttons
          Row(
            children: [
              Expanded(
                child: _aiButton(Icons.menu_book_rounded, 'Open Notes', () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _aiButton(Icons.history_edu_rounded, 'Open PYQs', () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _aiButton(Icons.play_circle_fill_rounded, 'Lectures', () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aiItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_rounded, color: AppColors.success, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _aiButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC8E6C9), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.success, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
