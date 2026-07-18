import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mock_instruction.dart';

class MockHome extends StatelessWidget {
  const MockHome({super.key});

  final List<Map<String, dynamic>> mockTests = const [
    {
      'title': 'UPSC Prelims Full Mock 1',
      'subtitle': 'GS Paper I • 100 MCQs • 2 Hours',
      'type': 'PRELIMS (MCQ)',
      'duration': '120 min',
      'questions': '100 Qs',
      'premium': false,
    },
    {
      'title': 'Mains Mini Mock: Indian Polity',
      'subtitle': 'GS Paper II Syllabus • 5 Questions',
      'type': 'MAINS (DESCRIPTIVE)',
      'duration': '60 min',
      'questions': '5 Qs',
      'premium': true,
    },
    {
      'title': 'Economy & Budget Special Mock',
      'subtitle': 'GS Paper III • 50 MCQs • 1 Hour',
      'type': 'PRELIMS (MCQ)',
      'duration': '60 min',
      'questions': '50 Qs',
      'premium': true,
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
          'Full Mock Tests',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UPSC Standard Full Length Mocks',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                SizedBox(height: 4),
                Text(
                  'Test your preparation under real exam constraints with IAS syllabus standards.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: mockTests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final test = mockTests[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge and Premium Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: test['type'] == 'PRELIMS (MCQ)' ? const Color(0xFFF0FDF4) : const Color(0xFFFAF5FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              test['type'] as String,
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: test['type'] == 'PRELIMS (MCQ)' ? const Color(0xFF16A34A) : const Color(0xFF7C3AED),
                              ),
                            ),
                          ),
                          if (test['premium'] as bool)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFFEF3C7), width: 1),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.star_rounded, color: AppColors.gold, size: 10),
                                  SizedBox(width: 4),
                                  Text(
                                    'PREMIUM',
                                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8.5, fontWeight: FontWeight.bold, color: AppColors.goldDark),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        test['title'] as String,
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        test['subtitle'] as String,
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),

                      // Duration & Questions & Button Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, color: AppColors.textHint, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                test['duration'] as String,
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 14),
                              const Icon(Icons.help_outline_rounded, color: AppColors.textHint, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                test['questions'] as String,
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MockInstruction(testTitle: test['title'] as String),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              'Start Test',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
