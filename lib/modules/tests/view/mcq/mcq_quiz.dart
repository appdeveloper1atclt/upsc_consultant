import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mcq_result.dart';

class McqQuiz extends StatefulWidget {
  final String topicName;
  final String subtopicName;

  const McqQuiz({super.key, required this.topicName, required this.subtopicName});

  @override
  State<McqQuiz> createState() => _McqQuizState();
}

class _McqQuizState extends State<McqQuiz> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool isAnswerRevealed = false;
  int correctAnswersCount = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which of the following parts of the Constitution of India deals with the Fundamental Rights?',
      'options': [
        'Part II',
        'Part III',
        'Part IV',
        'Part V',
      ],
      'correctIndex': 1,
      'explanation': 'Part III (Articles 12 to 35) of the Constitution of India deals with Fundamental Rights, which are inspired by the Constitution of the USA (Bill of Rights).',
    },
    {
      'question': 'Right to Privacy is protected as an intrinsic part of Right to Life and Personal Liberty. Which of the following in the Constitution of India correctly and appropriately imply the above statement?',
      'options': [
        'Article 14 and the provisions under the 42nd Amendment',
        'Article 17 and the Directive Principles of State Policy in Part IV',
        'Article 21 and the freedoms guaranteed in Part III',
        'Article 24 and the provisions under the 44th Amendment',
      ],
      'correctIndex': 2,
      'explanation': 'In the K.S. Puttaswamy v. Union of India case (2017), the Supreme Court ruled that the Right to Privacy is an intrinsic part of Article 21 (Right to Life and Personal Liberty) and freedoms guaranteed in Part III.',
    },
    {
      'question': 'Under which Article of the Constitution of India can the President declare a National Emergency?',
      'options': [
        'Article 352',
        'Article 356',
        'Article 360',
        'Article 368',
      ],
      'correctIndex': 0,
      'explanation': 'Article 352 deals with National Emergency, Article 356 with President\'s Rule in States, Article 360 with Financial Emergency, and Article 368 with Constitutional Amendment.',
    },
    {
      'question': 'The concept of "Directive Principles of State Policy" in the Indian Constitution is borrowed from the constitution of:',
      'options': [
        'USA',
        'USSR',
        'Ireland',
        'Australia',
      ],
      'correctIndex': 2,
      'explanation': 'The Directive Principles of State Policy (Part IV) in the Constitution of India are borrowed from the Irish Constitution (which had copied it from the Spanish Constitution).',
    },
    {
      'question': 'Who is considered the custodian of the Indian Constitution?',
      'options': [
        'The President of India',
        'The Parliament of India',
        'The Prime Minister of India',
        'The Supreme Court of India',
      ],
      'correctIndex': 3,
      'explanation': 'The Supreme Court of India is considered the guardian/custodian of the Constitution as it has the final power to interpret the Constitution and strike down unconstitutional laws.',
    },
  ];

  void _handleOptionTap(int index) {
    if (isAnswerRevealed) return;
    setState(() {
      selectedOptionIndex = index;
    });
  }

  void _revealAnswer() {
    if (selectedOptionIndex == null) return;
    setState(() {
      isAnswerRevealed = true;
      if (selectedOptionIndex == questions[currentQuestionIndex]['correctIndex']) {
        correctAnswersCount++;
      }
    });
  }

  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswerRevealed = false;
      });
    } else {
      // Navigate to results
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => McqResult(
            topicName: widget.topicName,
            subtopicName: widget.subtopicName,
            correctCount: correctAnswersCount,
            totalCount: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => _confirmExit(context),
        ),
        title: Text(
          widget.subtopicName,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${questions.length}',
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                  ),
                  Text(
                    '${((currentQuestionIndex + 1) / questions.length * 100).toInt()}% Done',
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 5,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 24),

              // Question block
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentQ['question'] as String,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Options
                      ...List.generate(currentQ['options'].length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildOptionWidget(index, currentQ['options'][index] as String, currentQ['correctIndex'] as int),
                        );
                      }),

                      const SizedBox(height: 12),

                      // Explanation box
                      if (isAnswerRevealed) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2F6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Explanation',
                                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.primary),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currentQ['explanation'] as String,
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, color: AppColors.textSecondary, height: 1.4),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom control buttons
              Row(
                children: [
                  if (!isAnswerRevealed)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: selectedOptionIndex == null ? null : _revealAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Check Answer', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    )
                  else
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          isLastQuestion ? 'View Results' : 'Next Question',
                          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionWidget(int index, String optionText, int correctIndex) {
    final isSelected = selectedOptionIndex == index;
    Color borderCol = const Color(0xFFEDF2F7);
    Color bgCol = Colors.white;
    Color textCol = AppColors.textPrimary;
    Widget trailing = const SizedBox();

    if (isAnswerRevealed) {
      if (index == correctIndex) {
        // Correct Option
        borderCol = const Color(0xFF86EFAC);
        bgCol = const Color(0xFFF0FDF4);
        textCol = const Color(0xFF15803D);
        trailing = const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 18);
      } else if (isSelected) {
        // User selected incorrect option
        borderCol = const Color(0xFFFCA5A5);
        bgCol = const Color(0xFFFEF2F2);
        textCol = const Color(0xFFB91C1C);
        trailing = const Icon(Icons.cancel_rounded, color: Color(0xFFDC2626), size: 18);
      } else {
        borderCol = const Color(0xFFEDF2F7);
        bgCol = Colors.white;
      }
    } else {
      if (isSelected) {
        borderCol = AppColors.primary;
        bgCol = AppColors.primary.withOpacity(0.05);
        textCol = AppColors.primary;
      }
    }

    final charCode = String.fromCharCode(65 + index); // A, B, C, D

    return GestureDetector(
      onTap: () => _handleOptionTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgCol,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderCol, width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected && !isAnswerRevealed ? AppColors.primary : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                charCode,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected && !isAnswerRevealed ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: textCol,
                ),
              ),
            ),
            const SizedBox(width: 8),
            trailing,
          ],
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Exit Practice?',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        content: const Text(
          'Your progress in this practice session will be lost. Are you sure you want to exit?',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Pop dialog
              Navigator.pop(context); // Exit quiz
            },
            child: const Text('Exit', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
