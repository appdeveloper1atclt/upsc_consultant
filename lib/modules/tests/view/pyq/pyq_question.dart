import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';

class PyqQuestion extends StatefulWidget {
  final String title;
  final String subtitle;

  const PyqQuestion({super.key, required this.title, required this.subtitle});

  @override
  State<PyqQuestion> createState() => _PyqQuestionState();
}

class _PyqQuestionState extends State<PyqQuestion> {
  int? selectedOptionIndex; // Tapping highlights option
  bool showAnswer = false;

  final Map<String, dynamic> sampleQuestion = {
    'number': 12,
    'total': 100,
    'subject': 'Polity',
    'question': 'Consider the following statements:\n\n1. The Green Revolution in India was mainly associated with the cultivation of wheat.\n2. High Yielding Variety (HYV) seeds require significantly more water compared to traditional seeds.\n\nWhich of the statements given above is/are correct?',
    'options': [
      '1 only',
      '2 only',
      'Both 1 and 2',
      'Neither 1 nor 2',
    ],
    'correctIndex': 2, // Both 1 and 2
    'explanation': 'Statement 1 is correct: The Green Revolution was majorly characterized by the introduction of High Yielding Varieties of seeds, especially wheat and rice, but wheat saw the most spectacular increase in yield. Statement 2 is correct: HYV seeds require plenty of water, chemical fertilizers, pesticides, and regular irrigation to perform optimally.',
  };

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
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 2),
            Text(
              widget.subtitle,
              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Question bookmarked!')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Q. Progress Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Q. ${sampleQuestion['number']} / ${sampleQuestion['total']}',
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading UPSC 2023 question paper PDF...')),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.download_rounded, size: 14),
                    label: const Text(
                      'Download PDF',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Subject Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  sampleQuestion['subject'] as String,
                  style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
              ),
              const SizedBox(height: 14),

              // Question body and options
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question text
                      Text(
                        sampleQuestion['question'] as String,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Options (A, B, C, D)
                      ...List.generate(sampleQuestion['options'].length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildOptionWidget(index, sampleQuestion['options'][index] as String, sampleQuestion['correctIndex'] as int),
                        );
                      }),

                      const SizedBox(height: 12),

                      // Show official answer toggle
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => setState(() => showAnswer = !showAnswer),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                showAnswer ? 'Hide Official Answer' : 'Show Official Answer',
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                showAnswer ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                color: AppColors.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Explanation box
                      if (showAnswer) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    'Official Explanation',
                                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.green),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                sampleQuestion['explanation'] as String,
                                style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary, height: 1.45),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // About PYQ banner
                      _buildAboutPyqSection(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Navigation footer buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Going to previous question...')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Going to next question...')),
                        );
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

  Widget _buildOptionWidget(int index, String optionText, int correctIndex) {
    final isSelected = selectedOptionIndex == index;
    final isCorrectOption = index == correctIndex;

    Color borderCol = const Color(0xFFEDF2F7);
    Color bgCol = Colors.white;
    Color textCol = AppColors.textPrimary;

    // In PYQ screen, if selected or if showAnswer is on, it highlights green
    if (showAnswer) {
      if (isCorrectOption) {
        borderCol = const Color(0xFF86EFAC);
        bgCol = const Color(0xFFF0FDF4);
        textCol = const Color(0xFF15803D);
      } else if (isSelected) {
        borderCol = const Color(0xFFFCA5A5);
        bgCol = const Color(0xFFFEF2F2);
        textCol = const Color(0xFFB91C1C);
      }
    } else {
      if (isSelected) {
        // Mock highlights C in green as in the screenshot
        if (index == 2) {
          borderCol = const Color(0xFF86EFAC);
          bgCol = const Color(0xFFF0FDF4);
          textCol = const Color(0xFF15803D);
        } else {
          borderCol = AppColors.primary;
          bgCol = AppColors.primary.withOpacity(0.05);
          textCol = AppColors.primary;
        }
      }
    }

    final charCode = String.fromCharCode(65 + index);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
        });
      },
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
                color: isSelected ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                charCode,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
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
          ],
        ),
      ),
    );
  }

  Widget _buildAboutPyqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About PYQ',
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 10),
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
                    _buildAboutBullet('PYQ are for reference only'),
                    const SizedBox(height: 8),
                    _buildAboutBullet('Students can read and learn'),
                    const SizedBox(height: 8),
                    _buildAboutBullet('No practice or attempt allowed'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Image.asset(
                AppImage.pyqImg,
                width: 60,
                height: 60,
                errorBuilder: (c, e, s) => const Icon(Icons.bookmark_added_rounded, color: AppColors.gold, size: 40),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10.5, color: AppColors.textSecondary, height: 1.3),
          ),
        ),
      ],
    );
  }
}
