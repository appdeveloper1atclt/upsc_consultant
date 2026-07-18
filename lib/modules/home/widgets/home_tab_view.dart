import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/routes/approute.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'answer_scanner.dart'; // To use UploadBottomSheet
import 'today_challenge_card.dart';

class HomeTabView extends StatelessWidget {
  final void Function(int index) onNavTap;

  const HomeTabView({super.key, required this.onNavTap});

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => UploadBottomSheet(onUploadSuccess: () => onNavTap(2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. AI Powered Scan Card
          _buildAiScannerCard(context)
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 2. Stats Cards Row
          _buildStatsCardsRow()
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
          _buildSecondOpinionCard(context)
              .animate()
              .fade(delay: 150.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 5. Recommended For You Section
          _buildRecommendedSection(context)
              .animate()
              .fade(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),

          // 6. Go Premium Banner Card
          _buildPremiumBanner(context)
              .animate()
              .fade(delay: 250.ms, duration: 400.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── 1. AI POWERED SCAN CARD ────────────────────────────────────────────────
  Widget _buildAiScannerCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Abstract background graphic on the right
            Positioned(
              right: -15,
              top: -15,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEEF2F6).withValues(alpha: 0.6),
                ),
              ),
            ),

            // Content padding
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 58,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AI Powered Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F3FF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFDDD6FE), width: 0.6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.bolt_rounded, color: Color(0xFF7C3AED), size: 12),
                              SizedBox(width: 3),
                              Text(
                                'AI POWERED',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF7C3AED),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              height: 1.25,
                            ),
                            children: [
                              TextSpan(text: "Scan Your Answer Sheet\n& Get "),
                              TextSpan(
                                text: "AI Analysis",
                                style: TextStyle(color: Color(0xFF7C3AED)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tag Badges Row
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _tagBadge('Smart Evaluation'),
                            _tagBadge('Detailed Feedback'),
                            _tagBadge('Score Prediction'),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Scan Button
                        GestureDetector(
                          onTap: () => _showUploadSheet(context),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFF6366F1)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.document_scanner_rounded, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Scan / Upload PDF',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Footer text
                        Row(
                          children: const [
                            Icon(Icons.verified_user_outlined, size: 11, color: AppColors.textSecondary),
                            SizedBox(width: 4),
                            Text(
                              'Supports PDF only • Secure & Private',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 9.5,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right visual decoration - simulated answer sheet paper & magnifier
                  Expanded(
                    flex: 42,
                    child: SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Leaf background shape
                          Positioned(
                            right: -10,
                            bottom: 10,
                            child: Icon(
                              Icons.spa_rounded,
                              size: 72,
                              color: const Color(0xFFA7F3D0).withValues(alpha: 0.4),
                            ),
                          ),

                          // The Answer Sheet Container
                          Positioned(
                            top: 15,
                            right: 0,
                            child: Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 12,
                                    offset: const Offset(4, 4),
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'ANSWER SHEET',
                                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 6.5, fontWeight: FontWeight.w900, color: AppColors.textSecondary),
                                    ),
                                  ),
                                  const Divider(height: 8, thickness: 0.5),
                                  _mockAnswerRow('1', true),
                                  _mockAnswerRow('2', false),
                                  _mockAnswerRow('3', true),
                                  _mockAnswerRow('4', false),
                                  _mockAnswerRow('5', true),
                                ],
                              ),
                            ),
                          ),

                          // The Magnifier glass decoration
                          Positioned(
                            top: 60,
                            left: 10,
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.9),
                                border: Border.all(color: const Color(0xFF94A3B8), width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(2, 4),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.search_rounded, color: Color(0xFF7C3AED), size: 24),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 102,
                            left: 48,
                            child: Transform.rotate(
                              angle: 0.78, // 45 degrees
                              child: Container(
                                width: 8,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF64748B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _mockAnswerRow(String num, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text('$num.', style: const TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(width: 4),
          _mockCircle(active),
          const SizedBox(width: 2),
          _mockCircle(!active),
          const SizedBox(width: 2),
          _mockCircle(false),
        ],
      ),
    );
  }

  Widget _mockCircle(bool filled) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? const Color(0xFF7C3AED) : Colors.transparent,
        border: Border.all(color: filled ? const Color(0xFF7C3AED) : const Color(0xFFCBD5E1), width: 0.5),
      ),
    );
  }

  // ── 2. STATS CARDS ROW ─────────────────────────────────────────────────────
  Widget _buildStatsCardsRow() {
    return Row(
      children: [
        Expanded(child: _statCard('🎯', '98%', 'Accuracy', const Color(0xFF10B981))),
        const SizedBox(width: 10),
        Expanded(child: _statCard('👥', '25K+', 'Students', const Color(0xFF3B82F6))),
        const SizedBox(width: 10),
        Expanded(child: _statCard('🛡️', '1L+', 'Answers', const Color(0xFF8B5CF6))),
        const SizedBox(width: 10),
        Expanded(child: _statCard('⭐', '4.9', 'Rating', const Color(0xFFF59E0B))),
      ],
    );
  }

  Widget _statCard(String emoji, String count, String label, Color indicatorColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
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
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              width: double.infinity,
              color: indicatorColor,
            ),
          ],
        ),
      ),
    );
  }

  // ── 4. SECOND OPINION CARD ─────────────────────────────────────────────────
  Widget _buildSecondOpinionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Left chat bubble icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFEDE9FE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF7C3AED), size: 20),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Second Opinion ✨',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Get personalized guidance from our expert mentors',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Ask Now outline button
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.consult),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF7C3AED), width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              minimumSize: const Size(0, 0),
            ),
            child: Row(
              children: const [
                Text(
                  'Ask Now',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7C3AED),
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.arrow_forward_rounded, color: Color(0xFF7C3AED), size: 10),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Overlapping mentors stack
          SizedBox(
            width: 48,
            height: 28,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: _circleAvatar('https://randomuser.me/api/portraits/women/44.jpg'),
                ),
                Positioned(
                  left: 10,
                  child: _circleAvatar('https://randomuser.me/api/portraits/men/32.jpg'),
                ),
                Positioned(
                  left: 20,
                  child: _circleAvatar('https://randomuser.me/api/portraits/men/46.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleAvatar(String url) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: ClipOval(
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  // ── 5. RECOMMENDED FOR YOU SECTION ─────────────────────────────────────────
  Widget _buildRecommendedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended For You',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 15.5,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => onNavTap(3),
              child: Row(
                children: const [
                  Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C3AED),
                    ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
            decoration: BoxDecoration(
              color: categoryBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 8.5,
                fontWeight: FontWeight.w900,
                color: categoryColor,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),

          // Subtitle
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
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
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: indicatorColor,
                        ),
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
                  decoration: BoxDecoration(
                    color: buttonColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_rounded, size: 12, color: Colors.white),
                  ),
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
      decoration: BoxDecoration(
        color: active ? const Color(0xFF7C3AED) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  // ── 6. PREMIUM BANNER CARD ─────────────────────────────────────────────────
  Widget _buildPremiumBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1B4B).withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          // Crown Illustration / Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events_rounded, color: Color(0xFFFBBF24), size: 28),
          ),
          const SizedBox(width: 14),

          // Main text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Go Premium. Unlock Unlimited Possibilities!',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Unlimited AI Evaluation, Mentor Review,\nMock Tests & more.',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 9.5,
                    color: Color(0xFFC7D2FE),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // White explore plans CTA button
          ElevatedButton(
            onPressed: () {
              context.push(AppRoutes.upgrade);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF312E81),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(0, 0),
            ),
            child: Row(
              children: const [
                Text(
                  'Explore Plans',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
