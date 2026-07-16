import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_text_styles.dart';
import '../../core/routes/approute.dart';
import '../../core/utils/responsive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late AnimationController _ashokaCtrl;
  late AnimationController _logoCtrl;
  late AnimationController _contentCtrl;
  late AnimationController _shimmerCtrl;
  late AnimationController _particleCtrl;
  late AnimationController _buttonCtrl;
  late AnimationController _ashokaRotateCtrl;

  late Animation<double> _ashokaScale;
  late Animation<double> _ashokaOpacity;
  late Animation<double> _ashokaRotation;
  late Animation<double> _contentSlide;
  late Animation<double> _contentOpacity;
  late Animation<double> _shimmer;
  late Animation<double> _buttonScale;

  final List<_Particle> _particles = [];
  int _activeStatIndex = 0;
  Timer? _statTimer;

  // Premium success stats showing benefits and happy students
  final List<Map<String, String>> _successStats = [
    {'icon': '🎓', 'stat': '15,000+ Students', 'label': 'Actively learning & preparing daily'},
    {'icon': '❤️', 'stat': '98% Happy Aspirants', 'label': 'Experienced high score improvements'},
    {'icon': '✍️', 'stat': '100k+ Mains Evaluated', 'label': 'Answers checked by top-rank mentors'},
    {'icon': '🏆', 'stat': '500+ UPSC Selections', 'label': 'Achieved their dream IAS/IPS services'},
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundDark,
      ),
    );
    _initParticles();
    _initControllers();
    _initAnimations();
    _startAnimation();

    // Auto-cycle the success stats every 3 seconds
    _statTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _activeStatIndex = (_activeStatIndex + 1) % _successStats.length;
        });
      }
    });
  }

  void _initParticles() {
    final rng = math.Random(99);
    for (int i = 0; i < 20; i++) {
      _particles.add(
        _Particle(
          angle: rng.nextDouble() * math.pi * 2,
          radius: 35 + rng.nextDouble() * 80,
          size: 1.2 + rng.nextDouble() * 2.5,
          opacity: 0.25 + rng.nextDouble() * 0.6,
          speed: 0.4 + rng.nextDouble() * 0.6,
        ),
      );
    }
  }

  void _initControllers() {
    _ashokaCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _contentCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _buttonCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _ashokaRotateCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  }

  void _initAnimations() {
    _ashokaScale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ashokaCtrl, curve: Curves.elasticOut));
    _ashokaOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ashokaCtrl, curve: const Interval(0, 0.4)));
    _ashokaRotation = Tween<double>(begin: 0.0, end: 4.0).animate(CurvedAnimation(parent: _ashokaRotateCtrl, curve: Curves.easeOutCubic));
    _contentSlide = Tween<double>(begin: 30, end: 0).animate(CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOutCubic));
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOut));
    _shimmer = Tween<double>(begin: 0.0, end: 1.0).animate(_shimmerCtrl);
    _buttonScale = Tween<double>(begin: 1.0, end: 1.04).animate(CurvedAnimation(parent: _buttonCtrl, curve: Curves.easeInOut));
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _ashokaCtrl.forward();
    _ashokaRotateCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 450));
    _logoCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 350));
    _contentCtrl.forward();
  }

  @override
  void dispose() {
    _statTimer?.cancel();
    _ashokaCtrl.dispose();
    _logoCtrl.dispose();
    _contentCtrl.dispose();
    _shimmerCtrl.dispose();
    _particleCtrl.dispose();
    _buttonCtrl.dispose();
    _ashokaRotateCtrl.dispose();
    super.dispose();
  }

  void _goToLogin() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPad = context.statusBarHeight;
    const bgColors = [Color(0xFF112240), Color(0xFF0A1628), Color(0xFF060E1C)];

    return Scaffold(
      backgroundColor: const Color(0xFF060E1C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(center: Alignment(0, -0.2), radius: 1.2, colors: bgColors),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background grid
            CustomPaint(painter: _GridPainter()),

            // Floating particles
            AnimatedBuilder(
              animation: _particleCtrl,
              builder: (_, __) => CustomPaint(
                painter: _ParticlePainter(particles: _particles, progress: _particleCtrl.value, center: Offset(context.screenWidth / 2, context.hp(0.38))),
                size: size,
              ),
            ),

            // Main content column
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: topPad > 0 ? context.spacingSm : context.spacingMd),

                  // ── Brand title at top ──────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.spacingLg),
                    child: ShaderMask(
                      shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
                      child: Text(
                        'UPSC CONSULTANT',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: context.scaleW(22),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(height: context.spacingXs),

                  // Gold divider
                  Container(width: 48, height: 2, decoration: const BoxDecoration(gradient: AppColors.goldGradient)),

                  // ── Animation area (Ashoka Chakra only, no pencil/pens) ──────────────────
                  Expanded(
                    flex: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Ashoka Chakra with rotating glow
                        AnimatedBuilder(
                          animation: Listenable.merge([_ashokaCtrl, _shimmerCtrl]),
                          builder: (_, __) => Opacity(opacity: _ashokaOpacity.value, child: _buildAshokaChakra(size)),
                        ),

                        // Lottie Celebration / Success Animation Overlay
                        Opacity(
                          opacity: 0.85,
                          child: Lottie.network(
                            'https://fonts.gstatic.com/s/a/celebration.json', // Stable Google Lottie
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // If offline, load a clean local fallback (no error thrown)
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Premium Success Stats Display (Cycling benefits) ────────
                  _buildAnimatedStatsCard(),

                  const SizedBox(height: 16),

                  // ── Headline & Subtitle ─────────────────────────────
                  AnimatedBuilder(
                    animation: _contentCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _contentOpacity.value,
                      child: Transform.translate(
                        offset: Offset(0, _contentSlide.value),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.spacingLg, vertical: context.spacingXs),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
                                child: Text(
                                  'Your Partner in\nUPSC Success',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: context.scaleW(24),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: context.spacingXs),
                              Text(
                                'Join thousands of happy, selected civil servants.',
                                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withOpacity(0.8)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // ── GET STARTED button ─────────────────────────────
                  AnimatedBuilder(
                    animation: Listenable.merge([_contentCtrl, _buttonCtrl]),
                    builder: (_, __) => Opacity(
                      opacity: _contentOpacity.value,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(context.spacingLg, 0, context.spacingLg, context.spacingLg),
                        child: Transform.scale(
                          scale: _buttonScale.value,
                          child: _GetStartedButton(onTap: _goToLogin),
                        ),
                      ),
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

  Widget _buildAshokaChakra(Size size) {
    return AnimatedBuilder(
      animation: Listenable.merge([_ashokaCtrl, _ashokaRotateCtrl, _shimmerCtrl]),
      builder: (_, __) => Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Transform.scale(
            scale: _ashokaScale.value,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.35 * _ashokaScale.value),
                    AppColors.goldLight.withOpacity(0.15 * _ashokaScale.value),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Spinning chakra
          Transform.scale(
            scale: _ashokaScale.value,
            child: Transform.rotate(
              angle: _ashokaRotation.value * math.pi * 2,
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(painter: _AshokaChakraPainter(shimmer: _shimmer.value)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Beautiful interactive card displaying active stats of students
  Widget _buildAnimatedStatsCard() {
    final activeStat = _successStats[_activeStatIndex];

    return AnimatedBuilder(
      animation: _contentCtrl,
      builder: (context, child) {
        return Opacity(
          opacity: _contentOpacity.value,
          child: Transform.translate(
            offset: Offset(0, _contentSlide.value),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold.withOpacity(0.2), width: 1),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Row(
                  key: ValueKey<int>(_activeStatIndex),
                  children: [
                    Text(activeStat['icon']!, style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            activeStat['stat']!,
                            style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.goldLight),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            activeStat['label']!,
                            style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Get Started Button
// ══════════════════════════════════════════════════════════════════════════════
class _GetStartedButton extends StatefulWidget {
  final VoidCallback onTap;
  const _GetStartedButton({required this.onTap});

  @override
  State<_GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<_GetStartedButton> with SingleTickerProviderStateMixin {
  late AnimationController _rippleCtrl;
  late Animation<double> _ripple;

  @override
  void initState() {
    super.initState();
    _rippleCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _ripple = Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: _rippleCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _ripple,
        builder: (_, child) => Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight]),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.45 * _ripple.value),
                blurRadius: 20 * _ripple.value,
                spreadRadius: 2 * _ripple.value,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Shimmer overlay
            AnimatedBuilder(
              animation: _rippleCtrl,
              builder: (_, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.5 + _rippleCtrl.value * 3.0, -0.5),
                        end: Alignment(-0.5 + _rippleCtrl.value * 3.0, 0.5),
                        colors: [Colors.transparent, Colors.white.withOpacity(0.18), Colors.transparent],
                      ),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Get Started', style: AppTextStyles.buttonText),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: AppColors.primaryDark.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Shared Painters & Helpers
// ══════════════════════════════════════════════════════════════════════════════
class _AshokaChakraPainter extends CustomPainter {
  final double shimmer;
  _AshokaChakraPainter({required this.shimmer});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.width / 2 - 3;
    final innerR = outerR * 0.12;
    final goldC = Color.lerp(AppColors.gold, AppColors.goldShimmer, shimmer) ?? AppColors.gold;

    canvas.drawCircle(
      Offset(cx, cy),
      outerR,
      Paint()
        ..color = goldC
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5,
    );

    canvas.drawCircle(
      Offset(cx, cy),
      outerR * 0.87,
      Paint()
        ..color = goldC.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    final spoke = Paint()
      ..color = goldC
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 24; i++) {
      final a = (i * math.pi * 2) / 24;
      canvas.drawLine(
        Offset(cx + innerR * math.cos(a), cy + innerR * math.sin(a)),
        Offset(cx + outerR * 0.85 * math.cos(a), cy + outerR * 0.85 * math.sin(a)),
        spoke,
      );
    }

    canvas.drawCircle(Offset(cx, cy), innerR * 2.0, Paint()..color = goldC);
  }

  @override
  bool shouldRepaint(_AshokaChakraPainter old) => old.shimmer != shimmer;
}

class _Particle {
  final double angle, radius, size, opacity, speed;
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
      final a = p.angle + progress * math.pi * 2 * p.speed;
      final pulse = (math.sin(progress * math.pi * 4 * p.speed) + 1) / 2;
      canvas.drawCircle(
        Offset(center.dx + p.radius * math.cos(a), center.dy + p.radius * math.sin(a)),
        p.size * (0.6 + pulse * 0.4),
        Paint()..color = AppColors.goldLight.withOpacity(p.opacity * (0.4 + pulse * 0.6)),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

class _GridPainter extends CustomPainter {
  _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.primaryLight.withOpacity(0.05)
      ..strokeWidth = 0.5;
    const sp = 44.0;
    for (double x = 0; x < size.width; x += sp) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += sp) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}
