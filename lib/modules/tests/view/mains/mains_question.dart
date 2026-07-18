import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import 'mains_evaluation_screens.dart';

class MainsQuestion extends StatefulWidget {
  final String paperTitle;

  const MainsQuestion({super.key, required this.paperTitle});

  @override
  State<MainsQuestion> createState() => _MainsQuestionState();
}

class _MainsQuestionState extends State<MainsQuestion> {
  final TextEditingController _answerController = TextEditingController();

  final Map<String, dynamic> sampleMainsQuestion = {
    'number': 1,
    'total': 20,
    'marks': '15 Marks',
    'words': '250 Words',
    'question':
        'Discuss the role of local self-government institutions (Panchayati Raj Institutions) in strengthening grassroots democracy in India. What are the key challenges faced by these institutions in performing their developmental roles?',
  };

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _showEvaluationMethodDialog(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!context.mounted) return;
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: const BoxDecoration(color: Color(0xFFE2E8F0), borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Evaluation Method',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 20),

                // AI Evaluation block
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '⚡ AI Evaluation',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Instant • 30 Seconds',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'FREE · 3 Evaluations Left',
                              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF7C3AED)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx, 'ai');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C3AED),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(0, 0),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Mentor Evaluation block
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCF5),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFFDE68A), width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '👨‍🏫 Mentor Evaluation',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Detailed Human Review · 24-48 Hours',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '₹199 or Included in Platinum',
                              style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldMuted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx, 'mentor');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(0, 0),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (!context.mounted || value == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        if (value == 'ai') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MainsAiEvaluationScreen(paperTitle: widget.paperTitle)));
        } else if (value == 'mentor') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MainsMentorEvaluationScreen(paperTitle: widget.paperTitle)));
        }
      });
    });
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
        title: Text(
          widget.paperTitle,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress and Mark details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${sampleMainsQuestion['number']} of ${sampleMainsQuestion['total']}',
                      style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        '${sampleMainsQuestion['marks']} · ${sampleMainsQuestion['words']}',
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Question prompt block
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  child: Text(
                    sampleMainsQuestion['question'] as String,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Writing field / upload options
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Type your answer below or upload a handwritten sheet:',
                        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11.5, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _answerController,
                        keyboardType: TextInputType.multiline,
                        minLines: 8,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Start writing your answer here...',
                          hintStyle: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12.5, color: AppColors.textHint),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textPrimary, height: 1.45),
                      ),
                      const Divider(color: Color(0xFFEDF2F7), height: 1),
                      const SizedBox(height: 10),
                      // Upload photo/pdf CTA
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attaching image/PDF...')));
                            },
                            icon: const Icon(Icons.attach_file_rounded, size: 16, color: AppColors.primary),
                            label: const Text(
                              'Attach Written Sheet',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                            ),
                          ),
                          const Text(
                            'Max 10MB (PDF/JPG)',
                            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textHint),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Submit row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _showEvaluationMethodDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Submit for Evaluation',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
