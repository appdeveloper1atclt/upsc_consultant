import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:go_router/go_router.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_text_styles.dart';
import '../../core/constant/app_image.dart';
import '../../core/routes/approute.dart';
import '../../core/utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // ── Animation Controllers ──────────────────────────────────────────────
  late AnimationController _leftPenCtrl;
  late AnimationController _rightPenCtrl;
  late AnimationController _crossGlowCtrl;
  late AnimationController _ashokaRotateCtrl;
  late AnimationController _ashokaGlowCtrl;
  late AnimationController _logoRevealCtrl;
  late AnimationController _bgPulseCtrl;
  late AnimationController _shimmerCtrl;
  late AnimationController _particleCtrl;
  late AnimationController _fadeOutCtrl;

  // ── Animations ────────────────────────────────────────────────────────
  late Animation<double> _crossGlow;
  late Animation<double> _ashokaScale;
  late Animation<double> _ashokaOpacity;
  late Animation<double> _ashokaRotation;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _titleOpacity;
  late Animation<double> _titleSlide;
  late Animation<double> _bgPulse;
  late Animation<double> _shimmer;
  late Animation<double> _finalFade;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _showParticles = false;
  bool _showCrossGlow = false;

  // particle list
  final List<_Particle> _particles = [];
  static const int _particleCount = 24;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
    _initParticles();
    _initControllers();
    _initAnimations();
    _startSequence();
  }

  void _initParticles() {
    final rng = math.Random(42);
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        _Particle(
          angle: rng.nextDouble() * math.pi * 2,
          radius: 40 + rng.nextDouble() * 90,
          size: 1.5 + rng.nextDouble() * 3,
          opacity: 0.3 + rng.nextDouble() * 0.7,
          speed: 0.5 + rng.nextDouble() * 0.5,
        ),
      );
    }
  }

  void _initControllers() {
    _leftPenCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _rightPenCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _crossGlowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _ashokaRotateCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _ashokaGlowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _logoRevealCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _bgPulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
    _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat();
    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _fadeOutCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  void _initAnimations() {
    _crossGlow = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _crossGlowCtrl, curve: Curves.easeOut));
    _ashokaScale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ashokaGlowCtrl, curve: Curves.elasticOut));
    _ashokaOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ashokaGlowCtrl, curve: const Interval(0, 0.5)));
    _ashokaRotation = Tween<double>(begin: 0.0, end: 4.0).animate(CurvedAnimation(parent: _ashokaRotateCtrl, curve: Curves.easeOutCubic));
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: _logoRevealCtrl, curve: Curves.easeOutBack));
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoRevealCtrl, curve: const Interval(0, 0.6)));
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoRevealCtrl, curve: const Interval(0.4, 1.0)));
    _titleSlide = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(
        parent: _logoRevealCtrl,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _bgPulse = Tween<double>(begin: 0.8, end: 1.0).animate(_bgPulseCtrl);
    _shimmer = Tween<double>(begin: 0.0, end: 1.0).animate(_shimmerCtrl);
    _finalFade = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeOutCtrl);
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 150));

    // 0.0s – Left whoosh sounds, left animation starts (visually hidden)
    _leftPenCtrl.forward();
    _playWhoosh();

    await Future.delayed(const Duration(milliseconds: 200));

    // 0.2s – Right whoosh sounds, right animation starts (visually hidden)
    _rightPenCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    // 1.0s – Imaginary cross hits → metallic ting + gold glow
    setState(() => _showCrossGlow = true);
    _crossGlowCtrl.forward();
    _playTing();

    await Future.delayed(const Duration(milliseconds: 100));

    // 1.1s – Ashoka Chakra starts spinning + glowing (magical shimmer)
    _ashokaRotateCtrl.forward();
    _ashokaGlowCtrl.forward();
    setState(() => _showParticles = true);

    await Future.delayed(const Duration(milliseconds: 500));

    // 1.6s – Logo reveal (orch hit)
    _logoRevealCtrl.forward();
    _playLogoReveal();

    await Future.delayed(const Duration(milliseconds: 900));

    // 2.5s – Hold, then fade out
    await Future.delayed(const Duration(milliseconds: 600));
    _fadeOutCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 520));

    if (mounted) {
      context.go(AppRoutes.onboarding);
    }
  }

  Future<void> _playWhoosh() async {
    try {
      await _audioPlayer.play(AssetSource('audio/sword_clang.mp3'), volume: 0.25);
    } catch (_) {}
  }

  Future<void> _playTing() async {
    try {
      await _audioPlayer.play(AssetSource('audio/sword_clang.mp3'), volume: 0.35);
    } catch (_) {}
  }

  Future<void> _playLogoReveal() async {
    try {
      await _audioPlayer.play(AssetSource('audio/sword_clang.mp3'), volume: 0.2);
    } catch (_) {}
  }

  @override
  void dispose() {
    _leftPenCtrl.dispose();
    _rightPenCtrl.dispose();
    _crossGlowCtrl.dispose();
    _ashokaRotateCtrl.dispose();
    _ashokaGlowCtrl.dispose();
    _logoRevealCtrl.dispose();
    _bgPulseCtrl.dispose();
    _shimmerCtrl.dispose();
    _particleCtrl.dispose();
    _fadeOutCtrl.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const bgColors = [Color(0xFF112240), Color(0xFF0A1628), Color(0xFF060E1C)];

    return Scaffold(
      backgroundColor: const Color(0xFF060E1C),
      body: AnimatedBuilder(
        animation: _fadeOutCtrl,
        builder: (context, child) {
          return Opacity(opacity: _finalFade.value, child: child);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Deep background gradient ──────────────────────────────
            AnimatedBuilder(
              animation: _bgPulse,
              builder: (_, __) => Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(center: const Alignment(0, -0.2), radius: 1.2 * _bgPulse.value, colors: bgColors),
                ),
              ),
            ),

            // ── Subtle grid lines ─────────────────────────────────────
            CustomPaint(painter: _GridPainter()),

            // ── Floating particles ────────────────────────────────────
            if (_showParticles)
              AnimatedBuilder(
                animation: _particleCtrl,
                builder: (_, __) => CustomPaint(
                  painter: _ParticlePainter(particles: _particles, progress: _particleCtrl.value, center: Offset(context.screenWidth / 2, context.hp(0.42))),
                  size: size,
                ),
              ),

            // ── Ashoka Chakra glow ────────────────────────────────────
            AnimatedBuilder(
              animation: Listenable.merge([_ashokaGlowCtrl, _ashokaRotateCtrl, _shimmerCtrl]),
              builder: (_, __) {
                return Positioned(
                  left: context.screenWidth / 2 - 120,
                  top: context.hp(0.28),
                  child: Opacity(
                    opacity: _ashokaOpacity.value,
                    child: SizedBox(
                      width: 240,
                      height: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow ring
                          Transform.scale(
                            scale: _ashokaScale.value * 1.05,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppColors.gold.withOpacity(0.55 * _ashokaScale.value),
                                    AppColors.goldLight.withOpacity(0.3 * _ashokaScale.value),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Rotating Ashoka Chakra
                          Transform.scale(
                            scale: _ashokaScale.value,
                            child: Transform.rotate(
                              angle: _ashokaRotation.value * math.pi * 2,
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: CustomPaint(painter: _AshokaChakraPainter(shimmer: _shimmer.value)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // ── Cross glow burst ──────────────────────────────────────
            if (_showCrossGlow)
              AnimatedBuilder(
                animation: _crossGlow,
                builder: (_, __) => Positioned(
                  left: context.screenWidth / 2 - 60,
                  top: context.hp(0.335),
                  child: Opacity(
                    opacity: _crossGlow.value * 0.8,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.ashokaGlow),
                    ),
                  ),
                ),
              ),

            // ── Logo + Brand ──────────────────────────────────────────
            AnimatedBuilder(
              animation: _logoRevealCtrl,
              builder: (_, __) {
                return Positioned(
                  left: 0,
                  right: 0,
                  top: context.hp(0.57),
                  child: Opacity(
                    opacity: _logoOpacity.value,
                    child: Transform.scale(
                      scale: _logoScale.value,
                      child: Column(
                        children: [
                          // Logo image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.5), blurRadius: 24, spreadRadius: 4)],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                AppImage.appLogo,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: const Icon(Icons.school_rounded, color: AppColors.gold, size: 40),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // UPSC CONSULTANT
                          ShaderMask(
                            shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
                            child: const Text('UPSC CONSULTANT', style: AppTextStyles.brandTitle),
                          ),

                          const SizedBox(height: 6),

                          // Tagline
                          Opacity(
                            opacity: _titleOpacity.value,
                            child: Transform.translate(
                              offset: Offset(0, _titleSlide.value),
                              child: const Text('YOUR PARTNER IN UPSC SUCCESS', style: AppTextStyles.brandSubtitle, textAlign: TextAlign.center),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Opacity(
                            opacity: _titleOpacity.value,
                            child: Transform.translate(
                              offset: Offset(0, _titleSlide.value),
                              child: Container(width: 48, height: 2, decoration: const BoxDecoration(gradient: AppColors.goldGradient)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // ── Bottom loading bar ────────────────────────────────────
            Positioned(
              bottom: 60,
              left: context.screenWidth * 0.3,
              right: context.screenWidth * 0.3,
              child: AnimatedBuilder(
                animation: _logoRevealCtrl,
                builder: (_, __) => Opacity(
                  opacity: _logoOpacity.value,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: _logoRevealCtrl.value,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
                          minHeight: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Expert Guidance • Smart Practice',
                        style: AppTextStyles.caption.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), letterSpacing: 0.8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Ashoka Chakra Painter (24-spoke wheel)
// ══════════════════════════════════════════════════════════════════════════════
class _AshokaChakraPainter extends CustomPainter {
  final double shimmer;
  _AshokaChakraPainter({required this.shimmer});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.width / 2 - 4;
    final innerR = outerR * 0.12;

    final goldBase = AppColors.gold;
    final goldShimmerColor = Color.lerp(goldBase, AppColors.goldShimmer, shimmer) ?? goldBase;

    // Outer ring
    final ringPaint = Paint()
      ..color = goldShimmerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    canvas.drawCircle(Offset(cx, cy), outerR, ringPaint);

    // Inner ring
    final innerRingPaint = Paint()
      ..color = goldShimmerColor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(Offset(cx, cy), outerR * 0.88, innerRingPaint);

    // 24 spokes
    final spokePaint = Paint()
      ..color = goldShimmerColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 24; i++) {
      final angle = (i * math.pi * 2) / 24;
      final startX = cx + innerR * math.cos(angle);
      final startY = cy + innerR * math.sin(angle);
      final endX = cx + outerR * 0.86 * math.cos(angle);
      final endY = cy + outerR * 0.86 * math.sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), spokePaint);
    }

    // Centre hub circle
    final hubPaint = Paint()
      ..color = goldShimmerColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), innerR * 2.2, hubPaint);

    // Hub highlight
    final hubHL = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx - innerR * 0.5, cy - innerR * 0.5), innerR * 0.8, hubHL);
  }

  @override
  bool shouldRepaint(_AshokaChakraPainter old) => old.shimmer != shimmer;
}

// ══════════════════════════════════════════════════════════════════════════════
// Particle Data & Painter
// ══════════════════════════════════════════════════════════════════════════════
class _Particle {
  final double angle;
  final double radius;
  final double size;
  final double opacity;
  final double speed;

  _Particle({required this.angle, required this.radius, required this.size, required this.opacity, required this.speed});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Offset center;

  _ParticlePainter({required this.particles, required this.progress, required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final angle = p.angle + progress * math.pi * 2 * p.speed;
      final x = center.dx + p.radius * math.cos(angle);
      final y = center.dy + p.radius * math.sin(angle);
      final pulse = (math.sin(progress * math.pi * 4 * p.speed) + 1) / 2;

      canvas.drawCircle(Offset(x, y), p.size * (0.6 + pulse * 0.4), Paint()..color = AppColors.goldLight.withOpacity(p.opacity * (0.4 + pulse * 0.6)));
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

// ══════════════════════════════════════════════════════════════════════════════
// Subtle background grid
// ══════════════════════════════════════════════════════════════════════════════
class _GridPainter extends CustomPainter {
  _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.primary.withOpacity(0.06)
      ..strokeWidth = 0.5;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}
