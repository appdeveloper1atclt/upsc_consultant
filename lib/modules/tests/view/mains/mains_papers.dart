import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mains_question.dart';

class MainsPapers extends StatefulWidget {
  final String paperTitle;

  const MainsPapers({super.key, required this.paperTitle});

  @override
  State<MainsPapers> createState() => _MainsPapersState();
}

class _MainsPapersState extends State<MainsPapers> {
  String selectedSubTab = 'GS Papers';

  final List<String> subTabs = ['GS Papers', 'Essay', 'Optional Papers'];

  final List<Map<String, dynamic>> papers = [
    {'year': '2023', 'title': 'UPSC Mains 2023', 'count': '8 Papers'},
    {'year': '2022', 'title': 'UPSC Mains 2022', 'count': '8 Papers'},
    {'year': '2021', 'title': 'UPSC Mains 2021', 'count': '8 Papers'},
    {'year': '2020', 'title': 'UPSC Mains 2020', 'count': '8 Papers'},
    {'year': '2019', 'title': 'UPSC Mains 2019', 'count': '8 Papers'},
    {'year': '2018', 'title': 'UPSC Mains 2018', 'count': '8 Papers'},
    {'year': '2017', 'title': 'UPSC Mains 2017', 'count': '8 Papers'},
    {'year': '2016', 'title': 'UPSC Mains 2016', 'count': '8 Papers'},
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
          'Mains Papers',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.textPrimary),
            onPressed: () => _showMainsInfo(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub-Tab Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: subTabs.map((tab) {
                final isSelected = tab == selectedSubTab;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedSubTab = tab),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : const Color(0xFFEDF2F7),
                            width: 1.2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // List of Mains papers
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Column(
                    children: papers.map((p) {
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
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                p['year']!,
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            title: Text(
                              p['title']!,
                              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            subtitle: Text(
                              p['count']!,
                              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary),
                            ),
                            trailing: const Icon(Icons.download_rounded, color: AppColors.textSecondary, size: 18),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MainsQuestion(
                                    paperTitle: '${p['title']!} - ${widget.paperTitle}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // "How to use?" instruction box
                  _buildHowToUseBox(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToUseBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How to use?',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHowBullet('Download question papers'),
              const SizedBox(height: 10),
              _buildHowBullet('Practice under exam conditions'),
              const SizedBox(height: 10),
              _buildHowBullet('Improve your answer writing'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHowBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Icon(Icons.circle, size: 5, color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, color: AppColors.textSecondary, height: 1.3),
          ),
        ),
      ],
    );
  }

  void _showMainsInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Mains Papers Info', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        content: const Text(
          'Access official UPSC Mains question papers sorted by subject and year. Practice drafting answers and upload them for review.',
          style: TextStyle(color: AppColors.textSecondary),
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
