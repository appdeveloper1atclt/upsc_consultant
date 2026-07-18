import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mcq_quiz.dart';

class McqTopic extends StatelessWidget {
  final String topicName;
  const McqTopic({super.key, required this.topicName});

  @override
  Widget build(BuildContext context) {
    // Generate some mock subtopics based on the topic name
    final List<Map<String, dynamic>> subtopics = _getSubtopicsFor(topicName);

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          topicName,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a Subtopic',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary.withOpacity(0.9)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Practice specific sections to clear your doubts and strengthen concepts.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: subtopics.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final sub = subtopics[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    title: Text(
                      sub['title'] as String,
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${sub['questions']} Qs · Difficulty: ${sub['difficulty']}',
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => McqQuiz(
                            topicName: topicName,
                            subtopicName: sub['title'] as String,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSubtopicsFor(String topic) {
    if (topic == 'Indian Polity') {
      return [
        {'title': 'Preamble of the Constitution', 'questions': 150, 'difficulty': 'Easy'},
        {'title': 'Fundamental Rights', 'questions': 450, 'difficulty': 'Hard'},
        {'title': 'Directive Principles of State Policy', 'questions': 220, 'difficulty': 'Medium'},
        {'title': 'Union Executive (President, PM, Council)', 'questions': 310, 'difficulty': 'Medium'},
        {'title': 'Parliament of India', 'questions': 540, 'difficulty': 'Hard'},
        {'title': 'Judiciary (Supreme Court & High Court)', 'questions': 280, 'difficulty': 'Medium'},
      ];
    } else if (topic == 'Indian Economy') {
      return [
        {'title': 'National Income & GDP Accounting', 'questions': 180, 'difficulty': 'Medium'},
        {'title': 'Inflation & Business Cycle', 'questions': 240, 'difficulty': 'Easy'},
        {'title': 'Monetary Policy & RBI Role', 'questions': 350, 'difficulty': 'Hard'},
        {'title': 'Fiscal Policy & Government Budgeting', 'questions': 400, 'difficulty': 'Hard'},
        {'title': 'Banking Sector Reforms', 'questions': 190, 'difficulty': 'Medium'},
      ];
    } else {
      return [
        {'title': 'General Core Concepts', 'questions': 200, 'difficulty': 'Medium'},
        {'title': 'Advanced Analytical Problems', 'questions': 150, 'difficulty': 'Hard'},
        {'title': 'Previous Year Trend Questions', 'questions': 300, 'difficulty': 'Medium'},
        {'title': 'Important Mock Questions', 'questions': 250, 'difficulty': 'Easy'},
      ];
    }
  }
}
