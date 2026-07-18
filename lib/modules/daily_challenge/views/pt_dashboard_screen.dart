import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_text_styles.dart';
import 'pt_topic_select_screen.dart';

class PtDashboardScreen extends StatefulWidget {
  const PtDashboardScreen({super.key});

  @override
  State<PtDashboardScreen> createState() => _PtDashboardScreenState();
}

class _PtDashboardScreenState extends State<PtDashboardScreen> {
  int selectedDay = 21; // Wed, 21 May

  final List<Map<String, dynamic>> calendarDays = [
    {'day': 'MON', 'date': 19},
    {'day': 'TUE', 'date': 20},
    {'day': 'WED', 'date': 21},
    {'day': 'THU', 'date': 22},
    {'day': 'FRI', 'date': 23},
    {'day': 'SAT', 'date': 24},
    {'day': 'SUN', 'date': 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daily PT Challenge',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.textPrimary),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Widget
            _buildCalendar(),
            const SizedBox(height: 20),

            // Today's Challenge Card
            _buildTodayChallengeCard(context),
            const SizedBox(height: 20),

            // Streak, Accuracy, Rank Stats Row
            _buildStatsRow(),
            const SizedBox(height: 24),

            // Recent Performance Table
            const Text(
              'Recent Performance',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            _buildPerformanceTable(),
            const SizedBox(height: 24),

            // Streak Footer Card
            _buildFooterCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'May 2025',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: calendarDays.map((dayData) {
              final isSelected = dayData['date'] == selectedDay;
              return GestureDetector(
                onTap: () => setState(() => selectedDay = dayData['date'] as int),
                child: Column(
                  children: [
                    Text(
                      dayData['day'] as String,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.goldDark : AppColors.textHint,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEF4444) : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${dayData['date']}',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayChallengeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Today's Challenge 🔥",
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildChallengeItem("20", "Questions"),
              Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
              _buildChallengeItem("20", "Minutes"),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Based on UPSC Prelims Pattern',
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Open topic selector
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PtTopicSelectScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Challenge',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right_rounded, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeItem(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatItem('12', 'Day Streak', const Color(0xFFFFF7ED), const Color(0xFFEA580C))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem('85.6%', 'Avg. Accuracy', const Color(0xFFF0FDF4), const Color(0xFF16A34A))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem('256', 'Your Rank', const Color(0xFFF5F3FF), const Color(0xFF7C3AED))),
      ],
    );
  }

  Widget _buildStatItem(String val, String label, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textCol.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        children: [
          Text(
            val,
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16.5, fontWeight: FontWeight.w800, color: textCol),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, fontWeight: FontWeight.bold, color: textCol.withValues(alpha: 0.8)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTable() {
    final rows = [
      {'date': '20 May 2025', 'score': '16/20', 'rank': '312'},
      {'date': '19 May 2025', 'score': '14/20', 'rank': '427'},
      {'date': '18 May 2025', 'score': '17/20', 'rank': '189'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          final r = rows[index];
          final isLast = index == rows.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r['date']!,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    Row(
                      children: [
                        const Text('Score  ', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary)),
                        Text(
                          r['score']!,
                          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Rank  ', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary)),
                        Text(
                          r['rank']!,
                          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(color: Color(0xFFEDF2F7), height: 1),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildFooterCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keep the streak going! 🔥',
                  style: AppTextStyles.textPrimary14semibold.copyWith(fontSize: 13.5, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Consistency is the key to success.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            AppImage.targetImg,
            width: 54,
            height: 54,
            errorBuilder: (c, e, s) => const Icon(Icons.stars_rounded, color: AppColors.gold, size: 40),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Daily PT Challenge Info', style: AppTextStyles.textPrimary16bold),
        content: const Text(
          'Practice 20 top-tier MCQ questions everyday. Keep your consistency streak active and compete on the leaderboard.',
          style: AppTextStyles.textSecondary13normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
