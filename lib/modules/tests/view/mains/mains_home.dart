import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mains_papers.dart';

class MainsHome extends StatefulWidget {
  const MainsHome({super.key});

  @override
  State<MainsHome> createState() => _MainsHomeState();
}

class _MainsHomeState extends State<MainsHome> {
  String selectedTab = 'GS Papers';

  final List<String> tabs = ['GS Papers', 'Essay', 'Ethics', 'Optional'];

  final List<Map<String, dynamic>> papersList = [
    {
      'title': 'GS Paper I',
      'subtitle': 'Indian Heritage & Culture, History & Geography of the World',
      'icon': Icons.menu_book_rounded,
      'color': Colors.indigo
    },
    {
      'title': 'GS Paper II',
      'subtitle': 'Polity, Governance, International Relations, Social Justice',
      'icon': Icons.gavel_rounded,
      'color': Colors.blue
    },
    {
      'title': 'GS Paper III',
      'subtitle': 'Economy, Technology, Environment, Security, Disaster Management',
      'icon': Icons.trending_up_rounded,
      'color': Colors.teal
    },
    {
      'title': 'GS Paper IV',
      'subtitle': 'Ethics, Integrity, Aptitude & Case Studies',
      'icon': Icons.psychology_rounded,
      'color': Colors.orange
    },
    {
      'title': 'Essay',
      'subtitle': 'Essay on Various Contemporary & Philosophical Topics',
      'icon': Icons.edit_note_rounded,
      'color': Colors.pink
    },
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
          'Mains Answer Writing',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Showing saved Mains questions...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Gradient Card
                  _buildTopGradientCard(),
                  const SizedBox(height: 20),

                  // Horizontal Scroll Tab Selector
                  _buildTabSelector(),
                  const SizedBox(height: 16),

                  // Papers List
                  Column(
                    children: papersList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (item['color'] as Color).withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
                            ),
                            title: Text(
                              item['title'] as String,
                              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                item['subtitle'] as String,
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, height: 1.35),
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 14),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MainsPapers(paperTitle: item['title'] as String),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Guidelines Card
                  _buildBottomGuidelinesCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopGradientCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B21B6), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B21B6).withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Write. Get Evaluated. Improve. Succeed.',
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16.5, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'AI Evaluation + Mentor Feedback',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = tab == selectedTab;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF5F3FF) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFDDD6FE) : const Color(0xFFEDF2F7),
                    width: 1.2,
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? const Color(0xFF7C3AED) : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomGuidelinesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFEF3C7), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Answer writing is the key to mains success.',
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start writing daily answer sessions and receive standard evaluations.',
            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, height: 1.35),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting random practice session...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.primaryDark,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Start Writing', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
