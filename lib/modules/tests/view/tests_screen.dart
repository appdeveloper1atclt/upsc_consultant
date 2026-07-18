import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/routes/approute.dart';
import 'mcq/mcq_home.dart';
import 'pyq/pyq_home.dart';
import 'mains/mains_home.dart';
import 'mock/mock_home.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),
              const SizedBox(height: 18),

              // Journey to Success Banner Card
              _buildJourneyCard(),
              const SizedBox(height: 24),

              // "What do you want to do?" title
              const Text(
                'What do you want to do?',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),

              // Option Cards
              _buildOptionCard(
                image: 'assets/images/calender.png',
                title: 'Daily PT Challenge 🔥',
                subtitle: '20 Questions • 20 Minutes\nNew challenge everyday',
                iconColor: const Color(0xFFEF4444),
                onTap: () {
                  // Navigate to Daily PT Challenge Select
                  context.push(AppRoutes.dailyPtSelect);
                },
              ),
              const SizedBox(height: 12),

              _buildOptionCard(
                image: AppImage.targetImg,
                title: 'MCQ Practice 🎯',
                subtitle: 'Unlimited topic-wise practice',
                iconColor: const Color(0xFF10B981),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const McqHome()),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildOptionCard(
                image: AppImage.pyqImg,
                title: 'Previous Year Questions (PYQ) 📚',
                subtitle: 'Read-only with official answers',
                iconColor: const Color(0xFF3B82F6),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PyqHome()),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildOptionCard(
                image: AppImage.answerSheetImg,
                title: 'Mains Answer Writing ✍️',
                subtitle: 'Submit → AI Evaluation',
                iconColor: const Color(0xFF8B5CF6),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MainsHome()),
                  );
                },
              ),
              const SizedBox(height: 12),

              _buildOptionCard(
                image: AppImage.trophyImg,
                title: 'Full Mock Tests',
                subtitle: 'Prelims & Mains full length\nmock tests',
                iconColor: const Color(0xFFF59E0B),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MockHome()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tests',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Practice. Analyze. Improve.',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        // Notification bell icon matching CustomAppBar
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1E36), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1E36).withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AppImage.trophyImg,
            width: 70,
            height: 70,
            errorBuilder: (c, e, s) => const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.gold,
              size: 60,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Journey to\nSuccess Starts Here!',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Consistent practice today,\nextraordinary results tomorrow.',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String image,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Icon/Image container
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => Icon(
                      Icons.quiz_rounded,
                      color: iconColor,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Text columns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 10.5,
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                // Chevron right
                Icon(
                  Icons.chevron_right_rounded,
                  color: iconColor.withOpacity(0.7),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
