import 'dart:async';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/modules/home/widgets/scanner_inttulation.dart';

class ScanProgressScreen extends StatefulWidget {
  final String fileName;
  final String fileType; // 'image' or 'pdf'

  const ScanProgressScreen({
    super.key,
    required this.fileName,
    required this.fileType,
  });

  @override
  State<ScanProgressScreen> createState() => _ScanProgressScreenState();
}

class _ScanProgressScreenState extends State<ScanProgressScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  int _currentStep = 0;
  bool _isCompleted = false;
  Timer? _stepTimer;

  final List<String> _stages = [
    "Reading Answer Sheet...",
    "OCR Text Extraction...",
    "AI Evaluation & Analysis...",
    "Grading & Feedback Synthesis...",
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _startScanningSimulation();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _stepTimer?.cancel();
    super.dispose();
  }

  void _startScanningSimulation() {
    // 1.5 seconds per step
    _stepTimer = Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      if (!mounted) return;
      if (_currentStep < _stages.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        timer.cancel();
        setState(() {
          _isCompleted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "AI Evaluator",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // for balance
                ],
              ),
              const Spacer(),

              // Animated Scanning Core
              if (!_isCompleted) ...[
                const AnimatedScannerIllustration(),
                const SizedBox(height: 40),
                // Status Step indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _stages[_currentStep],
                        style: const TextStyle(
                          color: AppColors.goldLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Subtitle
                Text(
                  "Uploading: ${widget.fileName}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ] else ...[
                // Success / Completed UI Card
                _buildSuccessCard(),
              ],

              const Spacer(flex: 2),

              // Steps timeline view (only shown during scanning)
              if (!_isCompleted) _buildTimelineSteps(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineSteps() {
    return Column(
      children: List.generate(_stages.length, (index) {
        final isActive = index == _currentStep;
        final isDone = index < _currentStep;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              Icon(
                isDone ? Icons.check_circle : (isActive ? Icons.radio_button_checked : Icons.radio_button_off),
                color: isDone ? AppColors.success : (isActive ? AppColors.gold : Colors.white30),
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                _stages[index],
                style: TextStyle(
                  color: isActive ? Colors.white : (isDone ? Colors.white70 : Colors.white30),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSuccessCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.done_all_rounded,
              color: Colors.green,
              size: 40,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "Evaluation Complete",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.fileName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const Divider(height: 32, thickness: 1),

          // Score & Feedback
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text("Score", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  SizedBox(height: 4),
                  Text(
                    "94/150",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ],
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              Column(
                children: const [
                  Text("Time Taken", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  SizedBox(height: 4),
                  Text(
                    "7.2s",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: const Text("Close", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back and select scan tab (index 2)
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("View Details", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
