import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../provider/pt_challenge_controller.dart';

class ResultTopicPerformance extends StatelessWidget {
  final PtChallengeController controller;

  const ResultTopicPerformance({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const double polityPct = 0.80;
    const double economyPct = 0.45;
    const double historyPct = 1.00;
    const double geographyPct = 0.60;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.analytics_rounded, color: AppColors.primary, size: 18),
              SizedBox(width: 8),
              Text(
                'Topic Wise Performance',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _topicRow('Indian Polity', polityPct, Colors.teal),
          const SizedBox(height: 12),
          _topicRow('Indian Economy', economyPct, Colors.orange),
          const SizedBox(height: 12),
          _topicRow('History', historyPct, Colors.brown),
          const SizedBox(height: 12),
          _topicRow('Geography', geographyPct, Colors.blue),

          const SizedBox(height: 18),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weak Areas Detected',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: const [
                        _WeakTag(label: 'Indian Economy'),
                        _WeakTag(label: 'Geography'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _topicRow(String name, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            Text(
              '${(pct * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: AppColors.divider,
            color: color,
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

class _WeakTag extends StatelessWidget {
  final String label;

  const _WeakTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.red.withValues(alpha: 0.15), width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),
      ),
    );
  }
}
