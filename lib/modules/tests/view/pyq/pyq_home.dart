import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import 'pyq_question.dart';

class PyqHome extends StatefulWidget {
  const PyqHome({super.key});

  @override
  State<PyqHome> createState() => _PyqHomeState();
}

class _PyqHomeState extends State<PyqHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedYear = 'Year';
  String selectedPaper = 'Paper';
  String selectedSubject = 'Subject';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Previous Year Questions (PYQ)',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Showing saved PYQs...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(text: 'Prelims'),
                  Tab(text: 'Mains'),
                ],
              ),
            ),
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPrelimsTab(),
                _buildMainsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrelimsTab() {
    final List<Map<String, dynamic>> prelimsPyqs = [
      {'year': '2024', 'title': 'UPSC Prelims 2024', 'questions': '100 Questions'},
      {'year': '2023', 'title': 'UPSC Prelims 2023', 'questions': '100 Questions'},
      {'year': '2022', 'title': 'UPSC Prelims 2022', 'questions': '100 Questions'},
      {'year': '2021', 'title': 'UPSC Prelims 2021', 'questions': '100 Questions'},
      {'year': '2020', 'title': 'UPSC Prelims 2020', 'questions': '100 Questions'},
    ];

    return SingleChildScrollView(
      key: const PageStorageKey('pyq_prelims_scroll'),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row
          _buildFilterRow('prelims'),
          const SizedBox(height: 14),

          // Info Banner notice
          _buildInfoBanner(),
          const SizedBox(height: 18),

          // List of PYQs
          Column(
            children: prelimsPyqs.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.description_outlined, color: AppColors.primary, size: 20),
                    ),
                    title: Text(
                      p['title']!,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      p['questions']!,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PyqQuestion(title: p['title']!, subtitle: 'GS Paper I'),
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          // View Older Years button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Loading older PYQs (2015-2019)...')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'View Older Years',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // "How to use PYQ?" section
          _buildHowToUseSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMainsTab() {
    final List<Map<String, dynamic>> mainsPyqs = [
      {'year': '2023', 'title': 'UPSC Mains 2023', 'papers': '8 Papers Available'},
      {'year': '2022', 'title': 'UPSC Mains 2022', 'papers': '8 Papers Available'},
      {'year': '2021', 'title': 'UPSC Mains 2021', 'papers': '8 Papers Available'},
      {'year': '2020', 'title': 'UPSC Mains 2020', 'papers': '8 Papers Available'},
    ];

    return SingleChildScrollView(
      key: const PageStorageKey('pyq_mains_scroll'),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row
          _buildFilterRow('mains'),
          const SizedBox(height: 14),

          // Info Banner notice
          _buildInfoBanner(),
          const SizedBox(height: 18),

          // List of Mains PYQs
          Column(
            children: mainsPyqs.map((m) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFFFAF5FF), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.menu_book_rounded, color: Colors.purple, size: 20),
                    ),
                    title: Text(
                      m['title']!,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      m['papers']!,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary),
                    ),
                    trailing: const Icon(Icons.download_rounded, color: AppColors.primary, size: 18),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloading ${m['title']} papers package...')),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          _buildHowToUseSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterRow(String prefix) {
    return Row(
      key: ValueKey('${prefix}_filter_row'),
      children: [
        _buildDropdownButton('${prefix}_year', selectedYear, (val) => setState(() => selectedYear = val!)),
        const SizedBox(width: 8),
        _buildDropdownButton('${prefix}_paper', selectedPaper, (val) => setState(() => selectedPaper = val!)),
        const SizedBox(width: 8),
        _buildDropdownButton('${prefix}_subject', selectedSubject, (val) => setState(() => selectedSubject = val!)),
        const SizedBox(width: 8),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: const Icon(Icons.filter_list_rounded, color: AppColors.primary, size: 18),
        ),
      ],
    );
  }

  Widget _buildDropdownButton(String uniqueKey, String value, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Container(
        key: ValueKey('${uniqueKey}_container'),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: ValueKey('${uniqueKey}_dropdown'),
            value: value == 'Year' || value == 'Paper' || value == 'Subject' ? null : value,
            hint: Text(value, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 16),
            isExpanded: true,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            items: <String>['Option 1', 'Option 2'].map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
      ),
      child: const Text(
        'PYQs are for reference only. Students can read and learn from past questions with official answers.',
        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: Color(0xFF475569), height: 1.45),
      ),
    );
  }

  Widget _buildHowToUseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How to use PYQ?',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildBulletRow('Understand UPSC pattern'),
                    const SizedBox(height: 10),
                    _buildBulletRow('Analyze important topics'),
                    const SizedBox(height: 10),
                    _buildBulletRow('Improve your conceptual clarity'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Image.asset(
                AppImage.pyqImg,
                width: 74,
                height: 74,
                errorBuilder: (c, e, s) => const Icon(Icons.bookmark_added_rounded, color: AppColors.gold, size: 50),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, height: 1.3),
          ),
        ),
      ],
    );
  }
}
