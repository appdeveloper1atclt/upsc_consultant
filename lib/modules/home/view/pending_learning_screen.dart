import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../widgets/continue_learning_section.dart';
import '../widgets/custom_segmented_tab_bar.dart';

class PendingLearningScreen extends StatefulWidget {
  const PendingLearningScreen({super.key});

  @override
  State<PendingLearningScreen> createState() => _PendingLearningScreenState();
}

class _PendingLearningScreenState extends State<PendingLearningScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Expanded set of courses for a complete view
  final List<CourseItem> allCourses = [
    const CourseItem(
      title: 'UPSC Mains GS-II\nPolity',
      progress: 0.68,
      isDark: true,
      imageUrl: AppImage.stumbhImg,
      gradientColors: [Color(0xFF0F2537), Color(0xFF081521)],
      progressColor: AppColors.gold,
    ),
    const CourseItem(
      title: 'Current Affairs\nApril 2024',
      progress: 0.75,
      imageUrl: AppImage.CurrentAffairsImg,
      gradientColors: [Color(0xFFF0F4F8), Color(0xFFE2EAF0)],
      progressColor: Color(0xFFC89B3C),
    ),
    const CourseItem(
      title: 'Essay Writing\nPractice Course',
      progress: 0.42,
      imageUrl: AppImage.MainsImg,
      gradientColors: [Color(0xFFFFF7E6), Color(0xFFFFF0D0)],
      progressColor: Color(0xFF102A43),
    ),
    const CourseItem(
      title: 'UPSC Prelims GS-I\nAncient & Medieval History',
      progress: 0.15,
      imageUrl: AppImage.prelimsImg,
      gradientColors: [Color(0xFFFDF6EC), Color(0xFFF9EBDB)],
      progressColor: AppColors.goldDark,
    ),
    const CourseItem(
      title: 'CSAT Quantitative\nAptitude Masterclass',
      progress: 0.90,
      imageUrl: AppImage.pyqImg,
      gradientColors: [Color(0xFFEBF4FF), Color(0xFFD6E4FF)],
      progressColor: Color(0xFF1D4ED8),
    ),
    const CourseItem(
      title: 'UPSC GS-III\nIndian Economy Basics',
      progress: 0.0,
      imageUrl: AppImage.growthgraphImg,
      gradientColors: [Color(0xFFF3FBF7), Color(0xFFE6F4EA)],
      progressColor: Color(0xFF107C41),
    ),
    const CourseItem(
      title: 'Ethics, Integrity & Aptitude\nCase Studies GS-IV',
      progress: 1.0,
      isDark: true,
      imageUrl: AppImage.sheildImg,
      gradientColors: [Color(0xFF2C3E50), Color(0xFF1A252F)],
      progressColor: AppColors.gold,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter logic
    List<CourseItem> filteredCourses = allCourses.where((c) {
      final matchesSearch = c.title.toLowerCase().contains(_searchQuery);
      if (!matchesSearch) return false;

      if (_tabController.index == 0) {
        // Pending: In Progress or Not Started (< 100%)
        return c.progress < 1.0;
      } else if (_tabController.index == 1) {
        // Completed (== 100%)
        return c.progress >= 1.0;
      } else {
        // All
        return true;
      }
    }).toList();

    // Stats calculations
    final pendingCount = allCourses.where((c) => c.progress < 1.0).length;
    final completedCount = allCourses.where((c) => c.progress >= 1.0).length;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('My Learning', style: AppTextStyles.appBarTitle),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Premium Styled Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: AppTextStyles.labelLarge,
                    decoration: InputDecoration(
                      hintText: 'Search courses, subjects...',
                      hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 13.5),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, color: AppColors.textSecondary, size: 18),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Stats Dashboard Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(title: 'Pending', count: '$pendingCount', color: AppColors.gold, icon: Icons.hourglass_empty_rounded),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(title: 'Completed', count: '$completedCount', color: AppColors.success, icon: Icons.check_circle_outline_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tab Bar
                CustomSegmentedTabBar(
                  controller: _tabController,
                  tabs: const ['Pending', 'Completed', 'All'],
                ),
              ],
            ),
          ),

          // Course List View
          Expanded(
            child: filteredCourses.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: filteredCourses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final c = filteredCourses[index];
                      return _buildCourseCard(c);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String count, required Color color, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_tabController.index == 1 ? Icons.workspace_premium_rounded : Icons.menu_book_rounded, size: 54, color: AppColors.border),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty
                ? 'No matching courses found'
                : (_tabController.index == 0
                      ? 'No pending learning activities!'
                      : _tabController.index == 1
                      ? 'No completed courses yet'
                      : 'No courses available'),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try searching with different terms'
                : (_tabController.index == 0 ? 'Great job! You are up to date.' : 'Start your courses to see them here.'),
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(CourseItem c) {
    final bool isCompleted = c.progress >= 1.0;
    final bool isNotStarted = c.progress == 0.0;

    return Container(
      height: 128,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: c.gradientColors),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.isDark ? AppColors.gold.withValues(alpha: 0.25) : AppColors.border.withValues(alpha: 0.6), width: 0.9),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Background Image/Illustration (Larger as requested)
            Positioned(
              right: c.isDark ? 8 : -8,
              bottom: c.isDark ? 0 : -8,
              child: Opacity(
                opacity: c.isDark ? 0.38 : 0.88,
                child: c.imageUrl.startsWith('http')
                    ? Image.network(c.imageUrl, height: 98, width: 98, fit: BoxFit.contain)
                    : Image.asset(c.imageUrl, height: 98, width: 98, fit: BoxFit.contain),
              ),
            ),

            // Content Left Side
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and status tag
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (isCompleted)
                              Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  'COMPLETED',
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.success, letterSpacing: 0.5),
                                ),
                              ),
                            if (isNotStarted)
                              Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.goldDark, letterSpacing: 0.5),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          c.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: c.isDark ? Colors.white : const Color(0xFF0F2537), height: 1.2),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Progress Section & Action Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Progress Bar & Percentage
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCompleted
                                  ? 'Course Completed'
                                  : isNotStarted
                                  ? 'Not started yet'
                                  : '${(c.progress * 100).toStringAsFixed(0)}% Completed',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: c.isDark ? Colors.white70 : AppColors.textSecondary),
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: c.progress,
                                minHeight: 4,
                                backgroundColor: c.isDark ? Colors.white10 : AppColors.divider,
                                color: c.progressColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Interactive "Resume" / "Start" Button
                      Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isCompleted ? (c.isDark ? Colors.white24 : AppColors.surface) : AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isCompleted ? 'Review' : (isNotStarted ? 'Start' : 'Resume'),
                                style: TextStyle(
                                  color: isCompleted ? (c.isDark ? Colors.white : AppColors.textPrimary) : Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: isCompleted ? (c.isDark ? Colors.white : AppColors.textPrimary) : Colors.white,
                                size: 12,
                              ),
                            ],
                          ),
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
  }
}
