import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../widgets/test_card.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  static const List<TestSeries> testsList = [
    TestSeries(
      title: 'UPSC Prelims Full Mock 1',
      subtitle: 'GS Paper I • 100 MCQs • 2 Hours',
      type: 'PRELIMS (MCQ)',
      duration: '120 min',
      questions: '100 Qs',
      premium: false,
    ),
    TestSeries(
      title: 'Mains Mini Mock: Indian Polity',
      subtitle: 'GS Paper II Syllabus • 5 Questions',
      type: 'MAINS (DESCRIPTIVE)',
      duration: '60 min',
      questions: '5 Qs',
      premium: true,
    ),
    TestSeries(
      title: 'Economy & Budget Special Mock',
      subtitle: 'GS Paper III • 50 MCQs • 1 Hour',
      type: 'PRELIMS (MCQ)',
      duration: '60 min',
      questions: '50 Qs',
      premium: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All India Test Series',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Practice objective and subjective mocks curated by retired IAS/IPS officers.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: testsList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final t = testsList[index];
              return TestCard(
                test: t,
                onStartTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Starting test: ${t.title}...')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
