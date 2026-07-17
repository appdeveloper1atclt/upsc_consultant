import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';

class CourseItem {
  final String title;
  final double progress;
  final String imageUrl;
  final bool isDark;
  final List<Color> gradientColors;
  final Color progressColor;

  const CourseItem({
    required this.title,
    required this.progress,
    required this.imageUrl,
    this.isDark = false,
    required this.gradientColors,
    required this.progressColor,
  });
}

class ContinueLearningSection extends StatelessWidget {
  final VoidCallback onViewAllTap;

  const ContinueLearningSection({super.key, required this.onViewAllTap});

  static const List<CourseItem> courses = [
    CourseItem(
      title: 'UPSC Mains GS-II\nPolity',
      progress: 0.68,
      isDark: true,
      imageUrl: AppImage.stumbhImg,
      gradientColors: [Color(0xFF0F2537), Color(0xFF081521)],
      progressColor: AppColors.gold,
    ),
    CourseItem(
      title: 'Current Affairs\nApril 2024',
      progress: 0.75,
      imageUrl: AppImage.CurrentAffairsImg, // Newspaper local asset
      gradientColors: [Color(0xFFF0F4F8), Color(0xFFE2EAF0)],
      progressColor: Color(0xFFC89B3C),
    ),
    CourseItem(
      title: 'Essay Writing\nPractice Course',
      progress: 0.42,
      imageUrl: AppImage.MainsImg, // Quill Pen local asset
      gradientColors: [Color(0xFFFFF7E6), Color(0xFFFFF0D0)],
      progressColor: Color(0xFF102A43),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.menu_book_rounded, color: AppColors.primary, size: 16),
                SizedBox(width: 6),
                Text(
                  'Continue Learning',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F2537)),
                ),
              ],
            ),
            TextButton(
              onPressed: onViewAllTap,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Text(
                'View All',
                style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Horizontal List View of Courses
        SizedBox(
          height: 122,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final c = courses[index];
              return Container(
                width: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: c.gradientColors),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: c.isDark ? AppColors.gold.withValues(alpha: 0.2) : AppColors.border.withValues(alpha: 0.5), width: 0.8),
                  boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      // Background Image illustration on the right (Larger layout)
                      Positioned(
                        right: c.isDark ? 6 : -6,
                        bottom: c.isDark ? 0 : -6,
                        child: Opacity(
                          opacity: c.isDark ? 0.32 : 0.85,
                          child: c.imageUrl.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl: c.imageUrl,
                                  height: 82,
                                  width: 82,
                                  fit: BoxFit.contain,
                                  placeholder: (_, __) => const SizedBox.shrink(),
                                  errorWidget: (_, __, ___) => const Icon(Icons.class_rounded, size: 30, color: Colors.grey),
                                )
                              : Image.asset(c.imageUrl, height: 82, width: 82, fit: BoxFit.contain),
                        ),
                      ),

                      // Text and progress indicator on the left
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              c.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: c.isDark ? Colors.white : const Color(0xFF0F2537),
                                height: 1.15,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(c.progress * 100).toStringAsFixed(0)}% Completed',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: c.isDark ? Colors.white70 : AppColors.textSecondary),
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: c.progress,
                                    minHeight: 3.5,
                                    backgroundColor: c.isDark ? Colors.white10 : AppColors.divider,
                                    color: c.progressColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
