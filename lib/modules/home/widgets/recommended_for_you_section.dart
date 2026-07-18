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
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
            GestureDetector(
              onTap: () => onNavTap(3),
              child: Row(
                children: const [
                  Text(
                    'View All',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.arrow_forward_rounded, color: Color(0xFF7C3AED), size: 12),
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
                categoryBg: const Color(0xFFD1FAE5),
                title: 'Indian Economy',
                subtitle: '3200+ Questions',
                indicatorText: '82% Accuracy',
                indicatorIcon: Icons.refresh_rounded,
                indicatorColor: const Color(0xFF10B981),
                buttonColor: const Color(0xFF10B981),
                onTap: () => onNavTap(3),
              ),
              const SizedBox(width: 12),
              _buildRecommendedCard(
                category: 'MAINS PRACTICE',
                categoryColor: const Color(0xFF6D28D9),
                categoryBg: const Color(0xFFEDE9FE),
                title: 'GS Paper I',
                subtitle: '12 Questions',
                indicatorText: '3 Pending Evaluation',
                indicatorIcon: Icons.edit_note_rounded,
                indicatorColor: const Color(0xFF8B5CF6),
                buttonColor: const Color(0xFF8B5CF6),
                onTap: () => onNavTap(3),
              ),
              const SizedBox(width: 12),
              _buildRecommendedCard(
                category: 'PYQ',
                categoryColor: const Color(0xFFC2410C),
                categoryBg: const Color(0xFFFFEDD5),
                title: 'UPSC Prelims 2023',
                subtitle: '100 Questions',
                indicatorText: 'Previous Year Paper',
                indicatorIcon: Icons.history_edu_rounded,
                indicatorColor: const Color(0xFFF97316),
                buttonColor: const Color(0xFFF97316),
                onTap: () => onNavTap(3),
              ),
            ],
          ),
        ),

        // Page Indicator Carousel Dots (Mock representation)
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _carouselDot(true),
            const SizedBox(width: 4),
            _carouselDot(false),
            const SizedBox(width: 4),
            _carouselDot(false),
            const SizedBox(width: 4),
            _carouselDot(false),
          ],
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
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
            decoration: BoxDecoration(color: categoryBg, borderRadius: BorderRadius.circular(6)),
            child: Text(
              category,
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8.5, fontWeight: FontWeight.w900, color: categoryColor, letterSpacing: 0.2),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            title,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),

          // Subtitle
          Text(
            subtitle,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18),

          // Bottom details & action button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(indicatorIcon, size: 12, color: indicatorColor),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        indicatorText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, fontWeight: FontWeight.bold, color: indicatorColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(color: buttonColor, shape: BoxShape.circle),
                  child: const Center(child: Icon(Icons.arrow_forward_rounded, size: 12, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _carouselDot(bool active) {
    return Container(
      width: active ? 10 : 6,
      height: 6,
      decoration: BoxDecoration(color: active ? const Color(0xFF7C3AED) : const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(3)),
    );
  }
}
