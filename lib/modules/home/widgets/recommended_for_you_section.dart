import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

class RecommendedForYouSection extends StatelessWidget {
  final void Function(int index) onNavTap;

  const RecommendedForYouSection({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended For You',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
            GestureDetector(
              onTap: () => onNavTap(3),
              child: Row(
                children: const [
                  Text(
                    'View All',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldDark),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal List of Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildRecommendedCard(
                category: 'MCQ PRACTICE',
                categoryColor: const Color(0xFF047857),
                categoryBg: const Color(0xFFECFDF5),
                title: 'Indian Economy',
                subtitle: '3200+ Questions',
                indicatorText: '82% Accuracy',
                indicatorIcon: Icons.refresh_rounded,
                indicatorColor: const Color(0xFF10B981),
                onTap: () => onNavTap(3),
              ),
              const SizedBox(width: 12),
              _buildRecommendedCard(
                category: 'MAINS PRACTICE',
                categoryColor: AppColors.primary,
                categoryBg: const Color(0xFFF1F5F9),
                title: 'GS Paper I',
                subtitle: '12 Questions',
                indicatorText: '3 Pending Evaluation',
                indicatorIcon: Icons.edit_note_rounded,
                indicatorColor: AppColors.primary,
                onTap: () => onNavTap(3),
              ),
              const SizedBox(width: 12),
              _buildRecommendedCard(
                category: 'PYQ',
                categoryColor: AppColors.goldDark,
                categoryBg: const Color(0xFFFFFBEB),
                title: 'UPSC Prelims 2023',
                subtitle: '100 Questions',
                indicatorText: 'Previous Year Paper',
                indicatorIcon: Icons.history_edu_rounded,
                indicatorColor: AppColors.goldDark,
                onTap: () => onNavTap(3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedCard({
    required String category,
    required Color categoryColor,
    required Color categoryBg,
    required String title,
    required String subtitle,
    required String indicatorText,
    required IconData indicatorIcon,
    required Color indicatorColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF3EAD3), width: 1.2),
        boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
            decoration: BoxDecoration(color: categoryBg, borderRadius: BorderRadius.circular(6)),
            child: Text(
              category,
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900, color: categoryColor, letterSpacing: 0.2),
            ),
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            title,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),

          // Subtitle
          Text(
            subtitle,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),

          // Bottom details & action button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(indicatorIcon, size: 11, color: indicatorColor),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        indicatorText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9, fontWeight: FontWeight.bold, color: indicatorColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(gradient: AppColors.buttonGradient, shape: BoxShape.circle),
                  child: const Center(child: Icon(Icons.arrow_forward_rounded, size: 11, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
