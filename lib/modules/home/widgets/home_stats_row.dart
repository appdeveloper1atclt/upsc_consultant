import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            '🎯',
            '98%',
            'Accuracy',
            const Color(0xFFFFC107), // Amber
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            '👥',
            '25K+',
            'Students',
            const Color(0xFF3B82F6), // Blue
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            '🛡️',
            '1L+',
            'Answers',
            const Color(0xFF10B981), // Emerald Green
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            '⭐',
            '4.9',
            'Rating',
            const Color(0xFFF59E0B), // Orange Gold
          ),
        ),
      ],
    );
  }

  Widget _statCard(String emoji, String count, String label, Color indicatorColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3EAD3), width: 1.2),
        boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Container(height: 3, width: double.infinity, color: indicatorColor),
          ],
        ),
      ),
    );
  }
}
