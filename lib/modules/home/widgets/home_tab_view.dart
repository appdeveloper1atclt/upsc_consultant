import 'package:flutter/material.dart';
import 'package:upsc_consultant/modules/current_affairs/view/current_affairs_screen.dart';
import 'answer_scanner.dart';
import 'continue_learning_section.dart';
import 'quick_action_grid.dart';
import 'quote_banner.dart';
import 'scanner_status.dart';
import 'study_analytics_section.dart';
import 'today_challenge_card.dart';
import 'top_mentors_section.dart';

import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/routes/approute.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnswerScannerBanner(onScanTap: () => onNavTap(2)),
          const SizedBox(height: 12),
          const ScannerStatsRow(),
          const SizedBox(height: 12),
          const TodayChallengeCard(),
          const SizedBox(height: 12),

          // Consultation Mentorship Banner Card
          _buildConsultationBanner(context),
          const SizedBox(height: 12),

          // Continue Learning Section
          ContinueLearningSection(onViewAllTap: () => context.push(AppRoutes.pendingLearning)),
          const SizedBox(height: 8),

          // Quick Access Grid (Moved below Continue Learning)
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
          ),
          const SizedBox(height: 12),

          // Study Analytics Section
          StudyAnalyticsSection(onViewAllTap: () => context.push(AppRoutes.studyAnalytics)),
          const SizedBox(height: 12),

          TopMentorsSection(
            mentors: mentors,
            onMentorTap: (m) => context.push(AppRoutes.mentorDetail, extra: m),
            onViewAllTap: () => onNavTap(1),
          ),
          const SizedBox(height: 16),
          const QuoteBanner(),
        ],
      ),
    );
  }

  Widget _buildConsultationBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFFDF8), Color(0xFFFFF3D3)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.premiumBorder.withValues(alpha: 0.6),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Mentor illustration on the right
            Positioned(
              right: -10,
              bottom: -5,
              child: Opacity(
                opacity: 0.95,
                child: Image.asset(
                  AppImage.mentorImg,
                  height: 110,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Left side text and button content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Need Guidance for your UPSC Journey?',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w900,
                            color: AppColors.goldDark,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Talk to Our Expert Mentors',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Bullet point lists
                        _buildBulletItem('Personalized Strategy'),
                        const SizedBox(height: 4),
                        _buildBulletItem('Syllabus Guidance'),
                        const SizedBox(height: 4),
                        _buildBulletItem('Doubt Support'),
                        const SizedBox(height: 4),
                        _buildBulletItem('Progress Review'),
                        const SizedBox(height: 14),

                        // Contact Button and Badge row
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => context.push(AppRoutes.consult),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'Contact to Consult',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 11,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Trusted Badge
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.verified_user_rounded, color: Color(0xFF2E7D32), size: 12),
                                SizedBox(width: 3),
                                Text(
                                  'Trusted by 25K+',
                                  style: TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 10), // Keeps space for the background image
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 11),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
