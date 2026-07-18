import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../daily_challenge/provider/pt_challenge_controller.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_image.dart';
import '../../core/constant/app_text_styles.dart';
import '../../core/routes/approute.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  int _activeStep = 0;

  // Selected onboarding data
  final TextEditingController _nameController = TextEditingController();
  String _selectedExam = 'UPSC CSE';
  String _selectedAttempt = '2027';
  double _studyHours = 6.0; // Slider value between 1.0 and 8.0

  final List<String> _exams = ['UPSC CSE', 'State PSC', 'CAPF', 'CDS', 'Other'];
  final List<String> _attempts = ['2026', '2027', '2028'];

  final List<IconData> _examIcons = [
    Icons.gavel_rounded,
    Icons.account_balance_rounded,
    Icons.security_rounded,
    Icons.shield_rounded,
    Icons.more_horiz_rounded
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_activeStep == 0) {
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Please enter your name to continue'),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        return;
      }
    }

    if (_activeStep < 2) {
      setState(() => _activeStep++);
    } else {
      _completeJourney();
    }
  }

  void _previousStep() {
    if (_activeStep > 0) {
      setState(() => _activeStep--);
    }
  }

  void _completeJourney() {
    context.read<PtChallengeController>().updateJourney(
          name: _nameController.text.trim(),
          exam: _selectedExam,
          attempt: _selectedAttempt,
          hours: _studyHours,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Welcome ${_nameController.text.trim()}! Journey setup completed.'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPad + 24),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppShadows.card,
                    border: Border.all(color: AppColors.divider, width: 0.8),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildStepper(),
                      const SizedBox(height: 20),
                      const Divider(color: AppColors.divider),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: _buildCurrentStepView(),
                      ),
                      const SizedBox(height: 24),
                      _buildFooterButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPSC Journey',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Customize your preparation path to success',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }

  Widget _buildStepper() {
    return EasyStepper(
      activeStep: _activeStep,
      lineStyle: const LineStyle(
        lineLength: 45,
        lineType: LineType.normal,
        defaultLineColor: AppColors.divider,
        finishedLineColor: AppColors.success,
      ),
      activeStepTextColor: AppColors.primary,
      finishedStepTextColor: AppColors.success,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 18,
      showStepBorder: true,
      steps: const [
        EasyStep(
          icon: Icon(Icons.person_outline_rounded, size: 16),
          title: 'Details',
        ),
        EasyStep(
          icon: Icon(Icons.stars_rounded, size: 16),
          title: 'Attempt',
        ),
        EasyStep(
          icon: Icon(Icons.schedule_rounded, size: 16),
          title: 'Hours',
        ),
      ],
      onStepReached: (index) {
        if (index == 1 && _nameController.text.trim().isEmpty) {
          return;
        }
        setState(() => _activeStep = index);
      },
    );
  }

  Widget _buildCurrentStepView() {
    switch (_activeStep) {
      case 0:
        return _buildStep1Details();
      case 1:
        return _buildStep2Attempt();
      case 2:
        return _buildStep3Hours();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1Details() {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.edit_note_rounded, color: AppColors.gold, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: AutoSizeText(
                '🎯 Tell us about your preparation',
                style: AppTextStyles.textPrimary16bold,
                maxLines: 1,
                minFontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Enter Your Full Name:',
          style: AppTextStyles.textSecondary12medium,
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _nameController,
          style: AppTextStyles.textPrimary14semibold,
          cursorColor: AppColors.gold,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textSecondary, size: 20),
            hintText: 'e.g. Abhishek Jha',
            hintStyle: AppTextStyles.textHint14normal,
            filled: true,
            fillColor: AppColors.chipBackground.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 0.8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Select Target Examination:',
          style: AppTextStyles.textSecondary12medium,
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(_exams.length, (index) {
            final exam = _exams[index];
            final isSelected = _selectedExam == exam;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () => setState(() => _selectedExam = exam),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.chipSelected : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.gold : AppColors.border,
                      width: isSelected ? 1.5 : 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.gold.withValues(alpha: 0.15) : AppColors.chipBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _examIcons[index],
                          color: isSelected ? AppColors.goldDark : AppColors.textSecondary,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: AutoSizeText(
                          exam,
                          style: isSelected ? AppTextStyles.textPrimary14semibold : AppTextStyles.textSecondary13medium.copyWith(color: AppColors.textPrimary),
                          maxLines: 1,
                          minFontSize: 11,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.goldDark,
                          size: 18,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStep2Attempt() {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(AppImage.calenderImg, color: AppColors.gold, width: 20, height: 20),
            const SizedBox(width: 6),
            Expanded(
              child: AutoSizeText(
                '🗓️ Choose Target Attempt Year',
                style: AppTextStyles.textPrimary16bold,
                maxLines: 1,
                minFontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Selecting your targeted year helps mentors timeline your syllabus revision strategy.',
          style: AppTextStyles.textSecondary12medium,
        ),
        const SizedBox(height: 20),
        Column(
          children: _attempts.map((year) {
            final isSelected = _selectedAttempt == year;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () => setState(() => _selectedAttempt = year),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.chipSelected : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.gold : AppColors.border,
                      width: isSelected ? 1.5 : 0.8,
                    ),
                    boxShadow: isSelected ? [BoxShadow(color: AppColors.gold.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))] : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.gold.withValues(alpha: 0.15) : AppColors.chipBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.workspace_premium_outlined,
                          color: isSelected ? AppColors.goldDark : AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'UPSC CSE Year $year',
                              style: isSelected ? AppTextStyles.textPrimary14semibold : AppTextStyles.textSecondary13medium.copyWith(color: AppColors.textPrimary),
                              maxLines: 1,
                              minFontSize: 11,
                            ),
                            const SizedBox(height: 2),
                            AutoSizeText(
                              'Target year for final recommendation selection',
                              style: AppTextStyles.textSecondary8normal.copyWith(fontSize: 10),
                              maxLines: 2,
                              minFontSize: 8,
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.goldDark,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep3Hours() {
    String tipText = "Standard daily study hours for beginners.";
    if (_studyHours >= 7.0) {
      tipText = "Excellent commitment! Essential for intensive IAS revision.";
    } else if (_studyHours >= 4.0) {
      tipText = "Good daily routine! Consistent study ensures UPSC success.";
    }

    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.hourglass_bottom_rounded, color: AppColors.gold, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: AutoSizeText(
                '⚡ Daily Study Commitment',
                style: AppTextStyles.textPrimary16bold,
                maxLines: 1,
                minFontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'How many hours do you study daily?',
          style: AppTextStyles.textSecondary12medium,
        ),
        const SizedBox(height: 36),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.premiumBadge,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.premiumBorder, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _studyHours.toInt() == 8 ? '8+ Hours' : '${_studyHours.toInt()} Hours',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.goldDark,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tipText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.goldMuted8semibold.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Slider(
          value: _studyHours,
          min: 1.0,
          max: 8.0,
          divisions: 7,
          activeColor: AppColors.gold,
          inactiveColor: AppColors.chipBackground,
          onChanged: (val) => setState(() => _studyHours = val),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (index) {
              final val = index + 1;
              return Text(
                val == 8 ? '8+' : '$val',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: _studyHours.toInt() == val ? FontWeight.bold : FontWeight.normal,
                  color: _studyHours.toInt() == val ? AppColors.goldDark : AppColors.textSecondary,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterButtons() {
    return Row(
      children: [
        if (_activeStep > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _previousStep,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        if (_activeStep > 0) const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _nextStep,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _activeStep == 2 ? 'Let\'s Go' : 'Next Step',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
