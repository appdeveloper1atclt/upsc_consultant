import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';

class ScannerStatsRow extends StatelessWidget {
  const ScannerStatsRow({super.key});

  static const _stats = [
    (icon: AppImage.trophyImg, color: AppColors.goldMuted, value: '98%', label: 'Accuracy'),
    (icon: AppImage.targetImg, color: Color(0xFFE24B4A), value: '25K+', label: 'Students'),
    (icon: AppImage.sheildImg, color: Color(0xFF378ADD), value: '1L+', label: 'Answers'),
    (icon: AppImage.growthgraphImg, color: AppColors.goldMuted, value: '4.9', label: 'Rating'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _stats
          .map(
            (s) => Expanded(
              child: Column(
                children: [
                  Image.asset(s.icon, width: 40, height: 40, fit: BoxFit.cover),
                  const SizedBox(height: 4),
                  Text(
                    s.value,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 1),
                  Text(s.label, style: const TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
