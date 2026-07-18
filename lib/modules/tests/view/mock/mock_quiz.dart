import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mock_result.dart';

class MockQuiz extends StatefulWidget {
  final String testTitle;

  const MockQuiz({super.key, required this.testTitle});

  @override
  State<MockQuiz> createState() => _MockQuizState();
}

class _MockQuizState extends State<MockQuiz> {
  int currentQuestionIndex = 0;
  final Map<int, int> selectedOptions = {}; // Stores questionIndex -> optionIndex

  int _remainingSeconds = 7200; // 120 minutes in seconds
  Timer? _timer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which of the following parts of the Constitution of India deals with the Fundamental Rights?',
      'options': ['Part II', 'Part III', 'Part IV', 'Part V'],
      'correctIndex': 1,
    },
    {
      'question': 'The concept of "Directive Principles of State Policy" in the Indian Constitution is borrowed from the constitution of:',
      'options': ['USA', 'USSR', 'Ireland', 'Australia'],
      'correctIndex': 2,
    },
    {
      'question': 'Under which Article of the Constitution of India can the President declare a National Emergency?',
      'options': ['Article 352', 'Article 356', 'Article 360', 'Article 368'],
      'correctIndex': 0,
    },
    {
      'question': 'Who is considered the custodian of the Indian Constitution?',
      'options': ['The President of India', 'The Parliament of India', 'The Prime Minister of India', 'The Supreme Court of India'],
      'correctIndex': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _autoSubmit();
      }
    });
  }

  String _formatTimer() {
    final int hours = _remainingSeconds ~/ 3600;
    final int minutes = (_remainingSeconds % 3600) ~/ 60;
    final int seconds = _remainingSeconds % 60;
    final String hStr = hours.toString().padLeft(2, '0');
    final String mStr = minutes.toString().padLeft(2, '0');
    final String sStr = seconds.toString().padLeft(2, '0');
    return '$hStr:$mStr:$sStr';
  }

  void _autoSubmit() {
    _submitQuiz();
  }

  void _submitQuiz() {
    _timer?.cancel();
    int correctCount = 0;
    selectedOptions.forEach((qIndex, optIndex) {
      if (questions[qIndex]['correctIndex'] == optIndex) {
        correctCount++;
      }
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MockResult(
          testTitle: widget.testTitle,
          correctCount: correctCount,
          totalQuestions: questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;
    final selectedOption = selectedOptions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
              onPressed: () => _confirmExit(context),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFCA5A5), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.alarm_rounded, color: Colors.red, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    _formatTimer(),
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${questions.length}',
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                  ),
                  Text(
                    '${selectedOptions.length} of ${questions.length} Attempted',
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, color: AppColors.textSecondary),
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

              // Question body and options
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
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Options list
                      ...List.generate(currentQ['options'].length, (index) {
                        final isOptSelected = selectedOption == index;
                        final charCode = String.fromCharCode(65 + index);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOptions[currentQuestionIndex] = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: isOptSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isOptSelected ? AppColors.primary : const Color(0xFFEDF2F7),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: isOptSelected ? AppColors.primary : const Color(0xFFF1F5F9),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      charCode,
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isOptSelected ? Colors.white : AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      currentQ['options'][index] as String,
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: isOptSelected ? AppColors.primary : AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Navigation row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: currentQuestionIndex == 0
                          ? null
                          : () {
                              setState(() {
                                currentQuestionIndex--;
                              });
                            },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Previous', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  if (isLastQuestion)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitQuiz,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Submit Test', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold)),
                      ),
                    )
                  else
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Next', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold)),
                            SizedBox(width: 6),
                            Icon(Icons.chevron_right_rounded, size: 16),
                          ],
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

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('End Exam Session?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'If you exit now, your mock progress will be lost. Would you like to submit the test or exit immediately?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Pop dialog
              Navigator.pop(context); // Exit mock
            },
            child: const Text('Exit Immediately', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Pop dialog
              _submitQuiz(); // Submit test
            },
            child: const Text('Submit Test', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
