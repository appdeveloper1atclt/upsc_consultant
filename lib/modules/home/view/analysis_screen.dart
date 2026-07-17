import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

class AnalysisResult {
  final int score;
  final int maxScore;
  final String performanceLabel;
  final Color performanceColor;
  final List<AnalysisDetail> details;

  const AnalysisResult({required this.score, required this.maxScore, required this.performanceLabel, required this.performanceColor, required this.details});
}

class AnalysisDetail {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isCompleted;

  const AnalysisDetail({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isCompleted = true,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Main Screen
// ─────────────────────────────────────────────────────────────────────────────

class AnalysisScreen extends StatefulWidget {
  final String fileName;
  final String fileType;

  const AnalysisScreen({super.key, required this.fileName, required this.fileType});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> with TickerProviderStateMixin {
  // ── State ──────────────────────────────────────────────────────────────────
  int _currentStep = 0;
  double _progressValue = 0.0;
  bool _isCompleted = false;
  Timer? _stepTimer;
  Timer? _progressTimer;

  // ── Animations ─────────────────────────────────────────────────────────────
  late AnimationController _pulseController;
  late AnimationController _scoreController;
  late Animation<double> _scoreAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _particleController;

  // ── Steps ──────────────────────────────────────────────────────────────────
  static const _steps = [
    _StepData(icon: Icons.document_scanner_outlined, label: 'Scanning', subtitle: 'Reading your answer sheet...'),
    _StepData(icon: Icons.memory_rounded, label: 'Processing', subtitle: 'Extracting content...'),
    _StepData(icon: Icons.psychology_outlined, label: 'Analyzing', subtitle: 'Evaluating answers...'),
    _StepData(icon: Icons.article_outlined, label: 'Generating Report', subtitle: 'Preparing your analysis...'),
  ];

  late final AnalysisResult _result;

  @override
  void initState() {
    super.initState();

    final randomScore = math.Random().nextInt(56) + 40;
    final isPass = randomScore >= 50;

    _result = AnalysisResult(
      score: randomScore,
      maxScore: 100,
      performanceLabel: isPass ? 'Good Performance' : 'Needs Improvement',
      performanceColor: isPass ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
      details: [
        const AnalysisDetail(
          icon: Icons.fact_check_outlined,
          iconBg: Color(0xFFFFF3D4),
          iconColor: Color(0xFFC89B3C),
          title: 'Evaluation',
          subtitle: 'Detailed evaluation completed',
          isCompleted: true,
        ),
        const AnalysisDetail(
          icon: Icons.forum_outlined,
          iconBg: Color(0xFFE8F4FD),
          iconColor: Color(0xFF1976D2),
          title: 'Detailed Feedback',
          subtitle: 'Strengths & improvements',
          isCompleted: true,
        ),
        const AnalysisDetail(
          icon: Icons.analytics_outlined,
          iconBg: Color(0xFFE8F5E9),
          iconColor: Color(0xFF2E7D32),
          title: 'Score Prediction',
          subtitle: 'Based on UPSC pattern',
          isCompleted: true,
        ),
        const AnalysisDetail(
          icon: Icons.description_outlined,
          iconBg: Color(0xFFF3E5F5),
          iconColor: Color(0xFF7B1FA2),
          title: 'View Detailed Report',
          subtitle: 'PDF report with full analysis',
          isCompleted: false,
        ),
      ],
    );

    // Pulse animation for scanning orb
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);

    // Particle animation
    _particleController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

    // Score circle animation
    _scoreController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _scoreAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _scoreController, curve: Curves.easeOutCubic));

    // Fade in for results
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _startProgress();
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _progressTimer?.cancel();
    _pulseController.dispose();
    _scoreController.dispose();
    _fadeController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _startProgress() {
    const totalDuration = Duration(milliseconds: 7200); // 4 steps × 1.8s
    const stepDuration = Duration(milliseconds: 1800);

    // Progress bar smooth update
    _progressTimer = Timer.periodic(const Duration(milliseconds: 60), (t) {
      if (!mounted) return;
      final elapsed = t.tick * 60;
      final fraction = (elapsed / totalDuration.inMilliseconds).clamp(0.0, 1.0);
      setState(() => _progressValue = fraction);
      if (fraction >= 1.0) t.cancel();
    });

    // Step advance
    _stepTimer = Timer.periodic(stepDuration, (timer) {
      if (!mounted) return;
      if (_currentStep < _steps.length - 1) {
        setState(() => _currentStep++);
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          setState(() => _isCompleted = true);
          _scoreController.forward();
          _fadeController.forward();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isCompleted ? AppColors.scaffold : AppColors.backgroundDark,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
            child: _isCompleted
                ? _ResultsView(
                    key: const ValueKey('results'),
                    result: _result,
                    fileName: widget.fileName,
                    scoreAnimation: _scoreAnimation,
                    fadeAnimation: _fadeAnimation,
                    onBack: () => Navigator.of(context).pop(),
                    onUploadAnother: () => Navigator.of(context).pop(),
                  )
                : _ProgressView(
                    key: const ValueKey('progress'),
                    steps: _steps,
                    currentStep: _currentStep,
                    progressValue: _progressValue,
                    pulseController: _pulseController,
                    particleController: _particleController,
                    fileName: widget.fileName,
                    onBack: () => Navigator.of(context).pop(),
                  ),
          ),
          if (_isCompleted && _result.score >= 50) const _ConfettiOverlay(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress View
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressView extends StatelessWidget {
  final List<_StepData> steps;
  final int currentStep;
  final double progressValue;
  final AnimationController pulseController;
  final AnimationController particleController;
  final String fileName;
  final VoidCallback onBack;

  const _ProgressView({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.progressValue,
    required this.pulseController,
    required this.particleController,
    required this.fileName,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ── App Bar ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70, size: 20),
                  onPressed: onBack,
                ),
                const Expanded(
                  child: Text('Answer Scanner', textAlign: TextAlign.center, style: AppTextStyles.white18bold),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          const Spacer(),

          // ── Animated Orb ──────────────────────────────────────────────────
          _AnimatedScanOrb(pulseController: pulseController, particleController: particleController),

          const SizedBox(height: 32),

          // ── Status Badge ──────────────────────────────────────────────────
          AnimatedBuilder(
            animation: pulseController,
            builder: (_, __) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08 + pulseController.value * 0.04),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(AppColors.gold))),
                  const SizedBox(width: 10),
                  Text(steps[currentStep].label, style: AppTextStyles.goldLight13medium.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Text(steps[currentStep].subtitle, style: AppTextStyles.white12normal.copyWith(color: Colors.white54)),

          const Spacer(),

          // ── Steps Card ────────────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                ...List.generate(steps.length, (i) {
                  final isDone = i < currentStep;
                  final isActive = i == currentStep;
                  return _StepRow(step: steps[i], index: i, isDone: isDone, isActive: isActive, isLast: i == steps.length - 1);
                }),
                const SizedBox(height: 16),
                // Progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          steps[currentStep].subtitle,
                          style: AppTextStyles.white11semibold.copyWith(color: Colors.white60, fontWeight: FontWeight.normal),
                        ),
                        Text('${(progressValue * 100).toInt()}%', style: AppTextStyles.goldLight10bold.copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Tip ───────────────────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline_rounded, color: AppColors.goldLight, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tip: High quality scans give better analysis results.',
                    style: AppTextStyles.white11semibold.copyWith(color: Colors.white70, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Results View
// ─────────────────────────────────────────────────────────────────────────────

class _ResultsView extends StatelessWidget {
  final AnalysisResult result;
  final String fileName;
  final Animation<double> scoreAnimation;
  final Animation<double> fadeAnimation;
  final VoidCallback onBack;
  final VoidCallback onUploadAnother;

  const _ResultsView({
    super.key,
    required this.result,
    required this.fileName,
    required this.scoreAnimation,
    required this.fadeAnimation,
    required this.onBack,
    required this.onUploadAnother,
  });

  @override
  Widget build(BuildContext context) {
    final isPass = result.score >= 50;

    return FadeTransition(
      opacity: fadeAnimation,
      child: SafeArea(
        child: Column(
          children: [
            // ── App Bar ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
                    onPressed: onBack,
                  ),
                  const Spacer(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Header ───────────────────────────────────────────
                    Text(
                      isPass ? 'Analysis Complete! 🏆✨' : 'Keep Pushing! 🚀📖',
                      style: AppTextStyles.textPrimary26bold.copyWith(fontSize: 24, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPass
                          ? "Brilliant effort! Your answer structure shows a strong foundation. Let's refine it further with mentor feedback."
                          : "Every attempt is a solid step closer to cracking UPSC. Let's work on the weak areas to scale your score.",
                      style: AppTextStyles.textSecondary13normal,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // ── Score Gauge ──────────────────────────────────────
                    _ScoreGauge(
                      score: result.score,
                      maxScore: result.maxScore,
                      animation: scoreAnimation,
                      performanceLabel: result.performanceLabel,
                      performanceColor: result.performanceColor,
                    ),

                    const SizedBox(height: 20),

                    // ── Feedback Banner ──────────────────────────────────
                    _buildFeedbackBanner(context, result.score),

                    const SizedBox(height: 20),

                    // ── Detail Cards ─────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        children: List.generate(result.details.length, (i) {
                          final detail = result.details[i];
                          final isLast = i == result.details.length - 1;
                          return _DetailCard(detail: detail, isLast: isLast, onTap: detail.title == 'View Detailed Report' ? () {} : null);
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── UPSC 1-on-1 Mentor Card ──────────────────────────
                    _buildUpscMentorCard(context),

                    const SizedBox(height: 20),

                    // ── Primary CTA ──────────────────────────────────────
                    _GradientButton(label: 'View Full Analysis', icon: Icons.arrow_forward_rounded, onTap: () {}),

                    const SizedBox(height: 12),

                    // ── Secondary CTA ─────────────────────────────────────
                    OutlinedButton.icon(
                      onPressed: onUploadAnother,
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Upload Another Sheet', style: AppTextStyles.textPrimary14semibold),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackBanner(BuildContext context, int score) {
    final isPass = score >= 50;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPass ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPass ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isPass ? Icons.stars_rounded : Icons.info_outline_rounded, color: isPass ? const Color(0xFF2E7D32) : const Color(0xFFC62828), size: 20),
              const SizedBox(width: 8),
              Text(
                isPass ? "UPSC Mains Standard: Good Base" : "Mains Alignment: Focus Areas",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isPass ? const Color(0xFF1B5E20) : const Color(0xFFB71C1C),
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isPass
                ? "Your answer aligns well with structural requirements. Incorporating relevant articles and data points will help you score even higher. Keep this momentum going!"
                : "Focus on starting with a strong introduction and adding bulleted points for body content. A senior UPSC mentor can guide you on the exact keywords to use to crack the Mains pattern.",
            style: TextStyle(fontSize: 12, height: 1.4, color: isPass ? const Color(0xFF2E7D32) : const Color(0xFFC62828), fontFamily: 'PlusJakartaSans'),
          ),
        ],
      ),
    );
  }

  Widget _buildUpscMentorCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0xFF203A43).withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 5))],
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  "1-on-1 MENTORSHIP",
                  style: TextStyle(color: AppColors.goldLight, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1.0, fontFamily: 'PlusJakartaSans'),
                ),
              ),
              const Spacer(),
              const Row(
                children: [
                  Icon(Icons.star_rounded, color: AppColors.gold, size: 14),
                  SizedBox(width: 4),
                  Text(
                    "4.9",
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'PlusJakartaSans'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Talk to UPSC Mentor Now 📞",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'PlusJakartaSans'),
          ),
          const SizedBox(height: 6),
          const Text(
            "Get your answer copy reviewed live by Dr. Raj Sharma and other senior mentors who have guided 1000+ aspirants to crack UPSC.",
            style: TextStyle(fontSize: 11.5, height: 1.4, color: Colors.white70, fontFamily: 'PlusJakartaSans'),
          ),
          const SizedBox(height: 16),
          // Booking Button CTA
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Connecting you with UPSC Mentor..."), backgroundColor: AppColors.primary));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))],
              ),
              child: const Text(
                "Book Consultation",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark, fontFamily: 'PlusJakartaSans'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Score Gauge
// ─────────────────────────────────────────────────────────────────────────────

class _ScoreGauge extends StatelessWidget {
  final int score;
  final int maxScore;
  final Animation<double> animation;
  final String performanceLabel;
  final Color performanceColor;

  const _ScoreGauge({required this.score, required this.maxScore, required this.animation, required this.performanceLabel, required this.performanceColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (_, __) {
            final value = animation.value;
            final displayScore = (score * value).round();
            return Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.2 * value), blurRadius: 40, spreadRadius: 10)],
                  ),
                ),
                // Custom painter arc
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CustomPaint(painter: _ScoreArcPainter(progress: value * score / maxScore)),
                ),
                // Score text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$displayScore', style: AppTextStyles.textPrimary14semibold.copyWith(fontSize: 44, fontWeight: FontWeight.w900, height: 1)),
                    Text('/$maxScore', style: AppTextStyles.textSecondary13normal.copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Text('Overall Score', style: AppTextStyles.textSecondary14normal.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(color: performanceColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
          child: Text(
            performanceLabel,
            style: AppTextStyles.textPrimary11bold.copyWith(color: performanceColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Score Arc Painter
// ─────────────────────────────────────────────────────────────────────────────

class _ScoreArcPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  _ScoreArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;
    const strokeWidth = 12.0;
    const startAngle = -math.pi * 0.75;
    const sweepTotal = math.pi * 1.5;

    // Track
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFEDE7DA);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepTotal, false, trackPaint);

    // Progress arc with gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepTotal,
        colors: const [Color(0xFFA97820), Color(0xFFC89B3C), Color(0xFFE8C978)],
        stops: const [0.0, 0.5, 1.0],
        tileMode: TileMode.clamp,
      );
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = gradient.createShader(rect);

      canvas.drawArc(rect, startAngle, sweepTotal * progress, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(_ScoreArcPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Detail Card
// ─────────────────────────────────────────────────────────────────────────────

class _DetailCard extends StatelessWidget {
  final AnalysisDetail detail;
  final bool isLast;
  final VoidCallback? onTap;

  const _DetailCard({required this.detail, required this.isLast, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(top: const Radius.circular(0), bottom: isLast ? const Radius.circular(20) : Radius.zero),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: detail.iconBg, borderRadius: BorderRadius.circular(12)),
                  child: Icon(detail.icon, color: detail.iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detail.title, style: AppTextStyles.textPrimary14semibold.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(detail.subtitle, style: AppTextStyles.textSecondary11semibold.copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                // Status
                if (detail.isCompleted)
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, color: Color(0xFF2E7D32), size: 16),
                  )
                else
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 18),
                  ),
              ],
            ),
          ),
          if (!isLast) Divider(height: 1, thickness: 1, color: AppColors.divider, indent: 16, endIndent: 16),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Gradient Button
// ─────────────────────────────────────────────────────────────────────────────

class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: AppTextStyles.textPrimary13bold.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated Scan Orb
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedScanOrb extends StatelessWidget {
  final AnimationController pulseController;
  final AnimationController particleController;

  const _AnimatedScanOrb({required this.pulseController, required this.particleController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([pulseController, particleController]),
      builder: (_, __) {
        final pulse = pulseController.value;
        return SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulse ring
              Transform.scale(
                scale: 0.85 + pulse * 0.15,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.04 + pulse * 0.04),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.15 + pulse * 0.1), width: 1.5),
                  ),
                ),
              ),
              // Middle ring
              Transform.scale(
                scale: 0.88 + pulse * 0.06,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.06 + pulse * 0.04),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.25 + pulse * 0.1), width: 1.5),
                  ),
                ),
              ),
              // Core orb
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.gold.withValues(alpha: 0.7 + pulse * 0.3),
                      AppColors.goldDark.withValues(alpha: 0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.5 + pulse * 0.2),
                      blurRadius: 30 + pulse * 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.document_scanner_rounded, color: Colors.white, size: 40),
              ),
              // Floating particles
              ..._buildParticles(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(6, (i) {
      final angle = (i / 6) * 2 * math.pi + particleController.value * 2 * math.pi;
      const r = 80.0;
      final x = math.cos(angle) * r;
      final y = math.sin(angle) * r;
      return Positioned(
        left: 90 + x - 4,
        top: 90 + y - 4,
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.goldLight.withValues(alpha: 0.5 + (i % 2) * 0.3),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step Row
// ─────────────────────────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final _StepData step;
  final int index;
  final bool isDone;
  final bool isActive;
  final bool isLast;

  const _StepRow({required this.step, required this.index, required this.isDone, required this.isActive, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? AppColors.success
                      : isActive
                      ? AppColors.gold
                      : Colors.white.withValues(alpha: 0.1),
                  border: Border.all(
                    color: isDone
                        ? AppColors.success
                        : isActive
                        ? AppColors.gold
                        : Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                    : isActive
                    ? const Icon(Icons.circle, color: Colors.white, size: 8)
                    : Icon(step.icon, color: Colors.white30, size: 14),
              ),
              if (!isLast)
                Expanded(child: Container(width: 1.5, color: isDone ? AppColors.success.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1))),
            ],
          ),
          const SizedBox(width: 14),
          // Label
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          step.label,
                          style: AppTextStyles.white13normal.copyWith(
                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                            color: isActive
                                ? Colors.white
                                : isDone
                                ? Colors.white70
                                : Colors.white30,
                          ),
                        ),
                        Text(step.subtitle, style: AppTextStyles.white10normal.copyWith(color: isActive ? Colors.white54 : Colors.white24)),
                      ],
                    ),
                  ),
                  if (isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                      ),
                      child: Text('In Progress', style: AppTextStyles.goldLight9bold.copyWith(fontWeight: FontWeight.w700)),
                    ),
                  if (isDone) Text('Done', style: AppTextStyles.success10bold.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data class
// ─────────────────────────────────────────────────────────────────────────────

class _StepData {
  final IconData icon;
  final String label;
  final String subtitle;

  const _StepData({required this.icon, required this.label, required this.subtitle});
}

// ─────────────────────────────────────────────────────────────────────────────
// Confetti Effect Helper
// ─────────────────────────────────────────────────────────────────────────────

class _ConfettiOverlay extends StatefulWidget {
  const _ConfettiOverlay();

  @override
  State<_ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<_ConfettiOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    // Initialize particles
    for (int i = 0; i < 80; i++) {
      _particles.add(
        _ConfettiParticle(
          x: _random.nextDouble(),
          y: -_random.nextDouble() * 0.8, // start above the screen
          speed: 0.15 + _random.nextDouble() * 0.25,
          angle: _random.nextDouble() * 2 * math.pi,
          spinSpeed: 2.0 + _random.nextDouble() * 5.0,
          color: _getRandomColor(),
          size: 6.0 + _random.nextDouble() * 8.0,
          shape: _random.nextBool() ? _ConfettiShape.rectangle : _ConfettiShape.circle,
        ),
      );
    }

    _controller.addListener(() {
      setState(() {
        for (var p in _particles) {
          p.y += p.speed * 0.015;
          p.angle += p.spinSpeed * 0.01;
          // sway side to side
          p.x += math.sin(p.y * 10) * 0.002;
        }
      });
    });

    _controller.forward();
  }

  Color _getRandomColor() {
    final colors = [
      const Color(0xFFFFD700), // Gold
      const Color(0xFFFFC0CB), // Pink
      const Color(0xFF00E5FF), // Cyan
      const Color(0xFF76FF03), // Lime Green
      const Color(0xFFFF3D00), // Orange-Red
      const Color(0xFFE040FB), // Magenta
      const Color(0xFFFFEB3B), // Yellow
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // IgnorePointer so clicks still pass through to buttons below
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _ConfettiPainter(particles: _particles, progress: _controller.value),
      ),
    );
  }
}

enum _ConfettiShape { rectangle, circle }

class _ConfettiParticle {
  double x; // 0.0 to 1.0 (screen width fraction)
  double y; // fraction of screen height (can be negative at start)
  final double speed;
  double angle;
  final double spinSpeed;
  final Color color;
  final double size;
  final _ConfettiShape shape;

  _ConfettiParticle({
    required this.x,
    required this.y,
    required this.speed,
    required this.angle,
    required this.spinSpeed,
    required this.color,
    required this.size,
    required this.shape,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      if (p.y < 0 || p.y > 1.0) continue;

      final paint = Paint()
        ..color = p.color.withValues(alpha: (1.0 - p.y).clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.save();
      final posX = p.x * size.width;
      final posY = p.y * size.height;

      canvas.translate(posX, posY);
      canvas.rotate(p.angle);

      if (p.shape == _ConfettiShape.rectangle) {
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size * 1.5, height: p.size * 0.8), paint);
      } else {
        canvas.drawCircle(Offset.zero, p.size / 2, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
