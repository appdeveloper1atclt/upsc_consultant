import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/routes/approute.dart';
import '../models/daily_challenge.dart';
import '../provider/pt_challenge_controller.dart';

class PtInstructionsScreen extends StatefulWidget {
  final DailyChallenge challenge;

  const PtInstructionsScreen({super.key, required this.challenge});

  @override
  State<PtInstructionsScreen> createState() => _PtInstructionsScreenState();
}

class _PtInstructionsScreenState extends State<PtInstructionsScreen> {
  bool _agreed = false;
  late String _selectedTopic;
  late int _selectedQuestionsCount;
  late String _difficulty;

  @override
  void initState() {
    super.initState();
    _selectedTopic = widget.challenge.topic;
    _selectedQuestionsCount = widget.challenge.totalQuestions;
    _difficulty = widget.challenge.difficulty;
  }

  int get _calculatedDurationMinutes {
    return ((_selectedQuestionsCount * 60) / 100).round().clamp(1, 9999);
  }

  int get _calculatedMarks {
    return _selectedQuestionsCount * 4;
  }

  String _formatDuration(int minutes) {
    if (minutes >= 60) {
      final hrs = minutes ~/ 60;
      final mins = minutes % 60;
      if (mins == 0) {
        return '$hrs ${hrs == 1 ? 'Hr' : 'Hrs'}';
      }
      return '$hrs ${hrs == 1 ? 'Hr' : 'Hrs'} $mins ${mins == 1 ? 'Min' : 'Mins'}';
    }
    return '$minutes ${minutes == 1 ? 'Min' : 'Mins'}';
  }

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Challenge Instructions', style: AppTextStyles.textPrimary18bold.copyWith(fontSize: 19)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Info Panel
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border, width: 0.8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  'TODAY\'S PT CHALLENGE',
                                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.goldDark),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.orange.withValues(alpha: 0.2), width: 0.5),
                                ),
                                child: Text(
                                  challenge.difficulty,
                                  style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(_selectedTopic, style: AppTextStyles.textPrimary22bold.copyWith(fontSize: 22, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.help_outline_rounded, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text('$_selectedQuestionsCount MCQs', style: AppTextStyles.textSecondary12medium),
                              const SizedBox(width: 16),
                              const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(_formatDuration(_calculatedDurationMinutes), style: AppTextStyles.textSecondary12medium),
                              const SizedBox(width: 16),
                              const Icon(Icons.stars_rounded, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text('$_calculatedMarks Marks', style: AppTextStyles.textSecondary12medium),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Customize Challenge Panel
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF3EAD3), width: 1.2),
                        boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.tune_rounded, size: 18, color: AppColors.goldDark),
                              SizedBox(width: 8),
                              Text(
                                'Customize Challenge',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 1. Choose Topic
                          const Text(
                            'Choose Topic',
                            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 38,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children:
                                  [
                                    'Indian Polity',
                                    'Indian Economy',
                                    'Geography',
                                    'History',
                                    'Environment',
                                    'Science & Tech',
                                    'Current Affairs',
                                    'International Relations',
                                  ].map((topic) {
                                    final isSelected = _selectedTopic == topic;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ChoiceChip(
                                        label: Text(
                                          topic,
                                          style: TextStyle(
                                            fontFamily: 'PlusJakartaSans',
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : AppColors.textPrimary,
                                          ),
                                        ),
                                        selected: isSelected,
                                        selectedColor: AppColors.primary,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: isSelected ? AppColors.primary : const Color(0xFFF3EAD3), width: 1.2),
                                        ),
                                        onSelected: (selected) {
                                          if (selected) {
                                            setState(() {
                                              _selectedTopic = topic;
                                            });
                                          }
                                        },
                                        showCheckmark: false,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 2. Question count
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Number of Questions',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  '$_selectedQuestionsCount Qs',
                                  style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.goldDark),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Preset Chips
                          SizedBox(
                            height: 36,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [20, 50, 100, 500, 1000, 2000, 3000, 4000, 5000].map((count) {
                                final isSelected = _selectedQuestionsCount == count;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(
                                      '$count Qs',
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: AppColors.gold,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: isSelected ? AppColors.gold : const Color(0xFFF3EAD3), width: 1.2),
                                    ),
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          _selectedQuestionsCount = count;
                                        });
                                      }
                                    },
                                    showCheckmark: false,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Slider (only visible/enabled when selected count is <= 1000)
                          if (_selectedQuestionsCount <= 1000)
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                activeTrackColor: AppColors.gold,
                                inactiveTrackColor: const Color(0xFFF3EAD3),
                                thumbColor: AppColors.goldDark,
                                overlayColor: AppColors.gold.withValues(alpha: 0.2),
                                valueIndicatorColor: AppColors.primary,
                                valueIndicatorTextStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              child: Slider(
                                value: _selectedQuestionsCount.toDouble().clamp(10, 1000),
                                min: 10,
                                max: 1000,
                                divisions: 198, // intervals of 5
                                label: '$_selectedQuestionsCount Qs',
                                onChanged: (value) {
                                  setState(() {
                                    _selectedQuestionsCount = (value / 5).round() * 5;
                                  });
                                },
                              ),
                            ),
                          const SizedBox(height: 4),

                          // Informational note
                          Row(
                            children: const [
                              Icon(Icons.info_outline_rounded, size: 12, color: AppColors.textSecondary),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Daily limit: Up to 5,000 questions/day. Duration scales as 100 Qs = 1 Hour.',
                                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Read Carefully Section
                    const Text(
                      'Read Carefully',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 14),

                    // Instructions checklist
                    _instructionRow('$_selectedQuestionsCount High-Quality UPSC standard Questions'),
                    _instructionRow('${_formatDuration(_calculatedDurationMinutes)} countdown strict timer limit'),
                    _instructionRow('+4 Marks awarded for every correct answer'),
                    _instructionRow('-1 Mark deducted for every incorrect answer'),
                    _instructionRow('No negative marking for skipped/unattempted questions'),
                    _instructionRow('Auto submit will trigger automatically when the timer reaches 0'),
                    _instructionRow('Offline mode supported - Internet is not mandatory during test'),
                    _instructionRow('Do not switch applications or answer calls; doing so may forfeit progress'),
                  ],
                ),
              ),
            ),

            // Bottom Checkbox & Button Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreed,
                        activeColor: AppColors.gold,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) {
                          setState(() {
                            _agreed = val ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'I agree to the test instructions and academic integrity rules. I will attempt the challenge honestly.',
                            style: AppTextStyles.textSecondary12medium.copyWith(height: 1.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _agreed
                          ? () {
                              // Initialize state inside provider
                              final controller = context.read<PtChallengeController>();
                              controller.startChallenge(
                                challenge,
                                customTopic: _selectedTopic,
                                customQuestionsCount: _selectedQuestionsCount,
                                customDurationMinutes: _calculatedDurationMinutes,
                              );
                              context.replace(AppRoutes.dailyPtQuiz);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        disabledBackgroundColor: AppColors.border,
                        foregroundColor: AppColors.primaryDark,
                        disabledForegroundColor: AppColors.textHint,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Start Test', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _instructionRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: AppTextStyles.textSecondary13normal.copyWith(color: AppColors.textPrimary.withValues(alpha: 0.9), height: 1.35)),
          ),
        ],
      ),
    );
  }
}
