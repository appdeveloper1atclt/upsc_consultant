import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/routes/approute.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upsc_consultant/modules/current_affairs/view/current_affairs_screen.dart';

import 'ai_scanner_card.dart';
import 'home_stats_row.dart';
import 'today_challenge_card.dart';
import 'second_opinion_card.dart';
import 'recommended_for_you_section.dart';
import 'quick_action_grid.dart';
import 'study_analytics_section.dart';
import 'top_mentors_section.dart';
import 'premium_banner.dart';
import 'quote_banner.dart';

class HomeTabView extends StatelessWidget {
  final void Function(int index) onNavTap;

  const HomeTabView({super.key, required this.onNavTap});

  // Replace photoUrl with your own CDN links once real mentor photos are ready.
  static const List<MentorData> mentors = [
    MentorData(
      name: ' Anuj sharma Sir',
      expertise: 'GS Strategy',
      rating: 4.9,
      studentsLabel: '12K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      price: 299,
    ),
    MentorData(
      name: "Aradhya Ma'am",
      expertise: 'Essay Expert',
      rating: 4.9,
      studentsLabel: '8K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      price: 299,
    ),
    MentorData(
      name: 'Dr. Manan Arora',
      expertise: 'Current Affairs',
      rating: 4.8,
      studentsLabel: '15K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/men/56.jpg',
      price: 299,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. AI Powered Scan Card
          AiScannerCard(onNavTap: onNavTap)
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 2. Stats Cards Row
          const HomeStatsRow()
              .animate()
              .fade(delay: 50.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 3. Today's PT Challenge Card
          const TodayChallengeCard()
              .animate()
              .fade(delay: 100.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 4. Second Opinion Card
          const SecondOpinionCard()
              .animate()
              .fade(delay: 150.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 5. Recommended For You Section
          RecommendedForYouSection(onNavTap: onNavTap)
              .animate()
              .fade(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // Quick Access Grid
          QuickActionsGrid(
            onViewAllTap: () {},
            onCurrentAffairsTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      centerTitle: false,
                    ),
                    body: const CurrentAffairsScreen(),
                  ),
                ),
              );
            },
            onPyqTap: () => onNavTap(3),
            onMcqTap: () => onNavTap(3),
            onMentorConnectTap: () => onNavTap(1),
            onPrelimsTap: () => onNavTap(3),
            onMainsTap: () => onNavTap(3),
          ).animate()
              .fade(delay: 220.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // Study Analytics Section
          StudyAnalyticsSection(onViewAllTap: () => context.push(AppRoutes.studyAnalytics))
              .animate()
              .fade(delay: 240.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // Top Mentors Section
          TopMentorsSection(
            mentors: mentors,
            onMentorTap: (m) => context.push(AppRoutes.mentorDetail, extra: m),
            onViewAllTap: () => onNavTap(1),
          ).animate()
              .fade(delay: 260.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 6. Go Premium Banner Card
          const PremiumBanner()
              .animate()
              .fade(delay: 280.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // Quote Banner
          const QuoteBanner()
              .animate()
              .fade(delay: 300.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
