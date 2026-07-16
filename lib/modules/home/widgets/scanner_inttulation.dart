import 'dart:math';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

/// Premium animated scanner illustration for the upload banner.
/// Shows a scanning line, pulsing glow, sparkles, and a "Scanning..." badge.
class AnimatedScannerIllustration extends StatefulWidget {
  const AnimatedScannerIllustration({super.key});

  @override
  State<AnimatedScannerIllustration> createState() =>
      _AnimatedScannerIllustrationState();
}

class _AnimatedScannerIllustrationState
    extends State<AnimatedScannerIllustration> with TickerProviderStateMixin {
  // 4 separate controllers for independent animation timings
  late final AnimationController _scanController;
  late final AnimationController _pulseController;
  late final AnimationController _sparkleController;
  late final AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    // Scanner line — sweeps top to bottom and back
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Outer gold glow — slow breathe effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Sparkle ring — rotates continuously
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    // "Scanning." → ".." → "..." cycling dots
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    _pulseController.dispose();
    _sparkleController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double size = 180;
    const double docWidth = 100;
    const double docHeight = 120;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── 1. Outer pulsing gold glow ──────────────────────────────────
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = 1.0 + _pulseController.value * 0.08;
              final opacity = 0.12 - _pulseController.value * 0.06;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.gold.withValues(alpha: opacity + 0.04),
                        AppColors.gold.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // ── 2. Sparkle ring rotating around the document ────────────────
          AnimatedBuilder(
            animation: _sparkleController,
            builder: (context, child) {
              return _SparkleRing(progress: _sparkleController.value);
            },
          ),

          // ── 3. Paper / document body ────────────────────────────────────
          Container(
            width: docWidth,
            height: docHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _paperLine(width: 68),
                  const SizedBox(height: 7),
                  _paperLine(width: 52),
                  const SizedBox(height: 7),
                  _paperLine(width: 60),
                  const SizedBox(height: 7),
                  _paperLine(width: 40),
                  const SizedBox(height: 7),
                  _paperLine(width: 55),
                  const SizedBox(height: 7),
                  _paperLine(width: 48),
                ],
              ),
            ),
          ),

          // ── 4. Cyan scanner line sweeping top→bottom ────────────────────
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, child) {
              final top = 30 + _scanController.value * (docHeight - 10);
              return Positioned(
                top: top,
                child: Container(
                  width: docWidth,
                  height: 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0xFF00D4FF),
                        Color(0xFF00D4FF),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.3, 0.7, 1.0],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x9900D4FF),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // ── 5. Gold magnifying glass (bottom-right, pulsing) ────────────
          Positioned(
            bottom: 24,
            right: 24,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final opacity = 0.7 + _pulseController.value * 0.3;
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.gold, AppColors.goldLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                );
              },
            ),
          ),

          // ── 6. "Scanning..." animated badge (bottom center) ─────────────
          Positioned(
            bottom: 0,
            child: AnimatedBuilder(
              animation: _dotController,
              builder: (context, child) {
                final dotCount = (_dotController.value * 3).floor() + 1;
                final dots = '.' * dotCount;
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.4),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cyan dot indicator
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00D4FF),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Scanning$dots',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: AppColors.primary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Horizontal line to simulate text on the paper
  Widget _paperLine({required double width}) {
    return Container(
      width: width,
      height: 5,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// ── Sparkle Ring ──────────────────────────────────────────────────────────────
/// 5 gold stars orbiting in a circle around the document
class _SparkleRing extends StatelessWidget {
  final double progress;
  const _SparkleRing({required this.progress});

  @override
  Widget build(BuildContext context) {
    const int count = 5;
    const double radius = 75;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(count, (i) {
          final angle = (2 * pi * i / count) + (2 * pi * progress);
          final dx = radius * cos(angle);
          final dy = radius * sin(angle);
          final opacity =
              (sin(2 * pi * progress + i) * 0.5 + 0.5).clamp(0.2, 1.0);
          return Positioned(
            left: 100 + dx - 5,
            top: 100 + dy - 5,
            child: Opacity(
              opacity: opacity,
              child: Icon(
                Icons.star_rounded,
                size: i.isEven ? 8 : 6,
                color: i.isEven ? AppColors.gold : AppColors.goldLight,
              ),
            ),
          );
        }),
      ),
    );
  }
}
