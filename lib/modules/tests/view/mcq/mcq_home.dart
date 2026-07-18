import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import 'mcq_topic.dart';

class McqHome extends StatefulWidget {
  const McqHome({super.key});

  @override
  State<McqHome> createState() => _McqHomeState();
}

class _McqHomeState extends State<McqHome> {
  String selectedCategory = 'All Topics';
  String searchQuery = '';

  final List<String> categories = ['All Topics', 'GS Paper I', 'GS Paper II', 'GS Paper III', 'GS Paper IV'];

  final List<Map<String, dynamic>> allTopics = [
    {'title': 'Indian Polity', 'questions': '3200+ Questions', 'category': 'GS Paper II', 'icon': Icons.account_balance_rounded, 'color': Colors.indigo},
    {'title': 'Indian Economy', 'questions': '2800+ Questions', 'category': 'GS Paper III', 'icon': Icons.currency_rupee_rounded, 'color': Colors.orange},
    {'title': 'History of India', 'questions': '3500+ Questions', 'category': 'GS Paper I', 'icon': Icons.museum_rounded, 'color': Colors.brown},
    {'title': 'Geography', 'questions': '2900+ Questions', 'category': 'GS Paper I', 'icon': Icons.public_rounded, 'color': Colors.blue},
    {'title': 'Environment & Ecology', 'questions': '2100+ Questions', 'category': 'GS Paper III', 'icon': Icons.eco_outlined, 'color': Colors.green},
    {'title': 'Science & Technology', 'questions': '2400+ Questions', 'category': 'GS Paper III', 'icon': Icons.biotech_rounded, 'color': Colors.purple},
    {'title': 'Current Affairs', 'questions': '5000+ Questions', 'category': 'GS Paper I', 'icon': Icons.article_rounded, 'color': Colors.cyan},
    {'title': 'Art & Culture', 'questions': '1800+ Questions', 'category': 'GS Paper I', 'icon': Icons.palette_outlined, 'color': Colors.pink},
  ];

  List<Map<String, dynamic>> get filteredTopics {
    return allTopics.where((topic) {
      final matchesCategory = selectedCategory == 'All Topics' || topic['category'] == selectedCategory;
      final matchesSearch = topic['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

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
          'MCQ Practice',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.textPrimary),
            onPressed: () => _showInfo(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => searchQuery = val),
                    decoration: InputDecoration(
                      hintText: 'Search topics...',
                      hintStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textHint),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint, size: 20),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFEDF2F7), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFEDF2F7), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, color: AppColors.textPrimary),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: const Icon(Icons.tune_rounded, color: AppColors.primary, size: 20),
                ),
              ],
            ),
          ),

          // Horizontal Category Selector Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFEDF2F7), width: 1.2),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Topics List
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              itemCount: filteredTopics.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final topic = filteredTopics[index];
                return _buildTopicItem(topic);
              },
            ),
          ),

          // Infinity preparation banner at bottom
          _buildFooterBanner(),
        ],
      ),
    );
  }

  Widget _buildTopicItem(Map<String, dynamic> topic) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: (topic['color'] as Color).withOpacity(0.08), shape: BoxShape.circle),
            child: Icon(topic['icon'] as IconData, color: topic['color'] as Color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic['title'] as String,
                  style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  topic['questions'] as String,
                  style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => McqTopic(topicName: topic['title'] as String)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0FDF4),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFDCFCE7), width: 1),
              ),
            ),
            child: const Text(
              'Practice',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBanner() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF0FDF4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Unlimited Practice, Anytime!',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
                ),
                SizedBox(height: 4),
                Text(
                  'Practice any topic, any time and improve your preparation.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: Color(0xFF15803D)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.all_inclusive_rounded, color: Color(0xFF16A34A), size: 40),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('MCQ Practice Info', style: AppTextStyles.textPrimary16bold),
        content: const Text(
          'MCQ Practice offers unlimited question practice broken down by subtopics. Answer questions, check explanations, and track progress.',
          style: AppTextStyles.textSecondary13normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
