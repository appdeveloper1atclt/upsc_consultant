// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:upsc_consultant/core/constant/app_colors.dart';
// import 'package:upsc_consultant/core/constant/app_image.dart';
// import 'package:upsc_consultant/core/constant/app_text_styles.dart';
// import 'package:upsc_consultant/core/routes/approute.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
//   // Main 12-second loop controller
//   late AnimationController _loopController;

//   // Floating idle loop (3.5s)
//   late AnimationController _floatController;
//   late Animation<double> _floatAnimation;

//   // CTA button scale controller
//   late AnimationController _buttonScaleController;
//   late Animation<double> _buttonScaleAnimation;

//   // Background particles list
//   final List<_GoldenSpark> _sparks = [];

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//         systemNavigationBarColor: AppColors.backgroundDark,
//       ),
//     );

//     _loopController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 12),
//     )..repeat();

//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3500),
//     )..repeat(reverse: true);
//     _floatAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );

//     _buttonScaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 120),
//     );
//     _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
//       CurvedAnimation(parent: _buttonScaleController, curve: Curves.easeInOut),
//     );

//     // Initialize 25 premium golden sparks for background feel
//     final random = math.Random(42);
//     for (int i = 0; i < 25; i++) {
//       _sparks.add(
//         _GoldenSpark(
//           x: random.nextDouble() * 320,
//           y: random.nextDouble() * 380,
//           size: 1.5 + random.nextDouble() * 2.5,
//           speed: 0.5 + random.nextDouble() * 1.0,
//           opacity: 0.15 + random.nextDouble() * 0.45,
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _loopController.dispose();
//     _floatController.dispose();
//     _buttonScaleController.dispose();
//     super.dispose();
//   }

//   void _onGetStartedPressed() async {
//     await _buttonScaleController.forward();
//     await _buttonScaleController.reverse();
//     if (!mounted) return;
//     context.go(AppRoutes.login);
//   }

//   double _getOpacityForSegment({required double start, required double end, required double val}) {
//     if (val < start || val > end) return 0.0;
//     const fade = 0.04;
//     if (val < start + fade) {
//       return (val - start) / fade;
//     } else if (val > end - fade) {
//       return (end - val) / fade;
//     }
//     return 1.0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bgColors = [Color(0xFF0C1D33), Color(0xFF071221), Color(0xFF040A12)];

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment(0, -0.1),
//             radius: 1.4,
//             colors: bgColors,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Header title
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ShaderMask(
//                       shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
//                       child: const Text(
//                         'UPSC CONSULTANT',
//                         style: AppTextStyles.white16bold,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: AppColors.gold.withValues(alpha: 0.15),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.verified_user_rounded, color: AppColors.goldLight, size: 12),
//                           SizedBox(width: 4),
//                           Text(
//                             "Officer Mentors",
//                             style: AppTextStyles.goldLight9bold,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Dynamic Motivational Message Banner
//               _buildDynamicQuoteBanner(),

//               // Unified Animation Canvas Area
//               Expanded(
//                 child: AnimatedBuilder(
//                   animation: Listenable.merge([_loopController, _floatAnimation]),
//                   builder: (context, _) {
//                     final val = _loopController.value;

//                     // Update sparks coordinates based on speed loop
//                     for (var spark in _sparks) {
//                       spark.y -= spark.speed * 0.4;
//                       if (spark.y < 0) {
//                         spark.y = 380.0;
//                       }
//                     }

//                     return Center(
//                       child: SizedBox(
//                         width: 320,
//                         height: 380,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             // Glowing Sparks in background
//                             CustomPaint(
//                               painter: _SparksPainter(sparks: _sparks),
//                               size: const Size(320, 380),
//                             ),

//                             // Step 1 & 2: Image 1 (Raw copy scan)
//                             _buildStep1And2(val),

//                             // Step 3: Image 2 (Evaluated sheet checks)
//                             _buildStep3(val),

//                             // Step 4: Image 4 (Mentor details)
//                             _buildStep4(val),

//                             // Step 5: Image 3 (Progress Analytics)
//                             _buildStep5(val),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               // Bottom Info Section & Button
//               _buildBottomSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // Dynamic quote banner updating dynamically per step
//   // ───────────────────────────────────────────────────────────────────────────
//   Widget _buildDynamicQuoteBanner() {
//     return AnimatedBuilder(
//       animation: _loopController,
//       builder: (context, _) {
//         final val = _loopController.value;
//         String text = "";
//         IconData icon = Icons.psychology_rounded;

//         if (val < 0.50) {
//           text = "Analyze Mains answer copy structure in seconds";
//           icon = Icons.camera_alt_rounded;
//         } else if (val >= 0.50 && val < 0.66) {
//           text = "Get real evaluation aligned with official UPSC pattern";
//           icon = Icons.fact_check_rounded;
//         } else if (val >= 0.66 && val < 0.83) {
//           text = "Align preparation strategies with top UPSC officers";
//           icon = Icons.workspace_premium_rounded;
//         } else {
//           text = "Build consistent score gains to secure your IAS rank";
//           icon = Icons.trending_up_rounded;
//         }

//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white.withValues(alpha: 0.04),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: AppColors.gold.withValues(alpha: 0.15)),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: AppColors.goldLight, size: 16),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   text,
//                   style: AppTextStyles.white11semibold.copyWith(color: Colors.white70),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // Step 1 & 2: Raw Sheet scanning with blue scanner line and magnifier
//   // ───────────────────────────────────────────────────────────────────────────
//   Widget _buildStep1And2(double val) {
//     final opacity = _getOpacityForSegment(start: 0.0, end: 0.50, val: val);
//     if (opacity <= 0.0) return const SizedBox.shrink();

//     double scannerLineVal = 0.0;
//     if (val >= 0.12 && val <= 0.38) {
//       scannerLineVal = (val - 0.12) / 0.26;
//     } else if (val > 0.38) {
//       scannerLineVal = 1.0;
//     }

//     double scannerLineOpacity = 0.0;
//     if (val >= 0.10 && val <= 0.42) {
//       scannerLineOpacity = _getOpacityForSegment(start: 0.10, end: 0.42, val: val);
//     }

//     Offset magnifierOffset = const Offset(80, 80);
//     if (val >= 0.08 && val <= 0.38) {
//       final t = (val - 0.08) / 0.30;
//       magnifierOffset = Offset(
//         80 - 110 * t,
//         80 - 110 * t,
//       );
//     }

//     return Opacity(
//       opacity: opacity,
//       child: Transform.translate(
//         offset: Offset(0, _floatAnimation.value),
//         child: Stack(
//           alignment: Alignment.center,
//           clipBehavior: Clip.none,
//           children: [
//             // Image 1: Raw copy
//             Image.asset(
//               AppImage.onboardAnimationImg1,
//               width: 170,
//               fit: BoxFit.contain,
//             ),

//             // Scanner blue line
//             Positioned(
//               top: 15 + scannerLineVal * 190,
//               child: Opacity(
//                 opacity: scannerLineOpacity,
//                 child: Container(
//                   width: 160,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF00C0FF),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF00C0FF).withValues(alpha: 0.6),
//                         blurRadius: 10,
//                         spreadRadius: 3,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Magnifying Glass
//             Positioned(
//               child: Transform.translate(
//                 offset: magnifierOffset,
//                 child: Opacity(
//                   opacity: val >= 0.06 && val <= 0.44 ? 1.0 : 0.0,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: const BoxDecoration(
//                       color: AppColors.gold,
//                       shape: BoxShape.circle,
//                       boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
//                     ),
//                     child: const Icon(
//                       Icons.search_rounded,
//                       color: AppColors.primary,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // Step 3: Evaluated sheet with green checkmarks and evaluation card
//   // ───────────────────────────────────────────────────────────────────────────
//   Widget _buildStep3(double val) {
//     final opacity = _getOpacityForSegment(start: 0.50, end: 0.66, val: val);
//     if (opacity <= 0.0) return const SizedBox.shrink();

//     double checkScale = 0.0;
//     if (val >= 0.52) {
//       checkScale = ((val - 0.52) / 0.08).clamp(0.0, 1.0);
//     }

//     Offset evalCardOffset = const Offset(-120.0, 50.0);
//     if (val >= 0.51) {
//       final t = ((val - 0.51) / 0.08).clamp(0.0, 1.0);
//       evalCardOffset = Offset(
//         -120.0 + 30 * t,
//         50.0 + 60 * t,
//       );
//     }

//     return Opacity(
//       opacity: opacity,
//       child: Transform.translate(
//         offset: Offset(0, _floatAnimation.value),
//         child: Stack(
//           alignment: Alignment.center,
//           clipBehavior: Clip.none,
//           children: [
//             // Image 2: Evaluated Copy
//             Image.asset(
//               AppImage.onboardAnimationImg2,
//               width: 170,
//               fit: BoxFit.contain,
//             ),

//             // Green Checkmarks
//             Positioned(
//               top: 50,
//               right: 42,
//               child: Transform.scale(
//                 scale: checkScale,
//                 child: Container(
//                   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                   child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 24),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 140,
//               left: 42,
//               child: Transform.scale(
//                 scale: checkScale > 0.5 ? checkScale : 0.0,
//                 child: Container(
//                   decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                   child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 24),
//                 ),
//               ),
//             ),

//             // Evaluation Card Info Overlay
//             Positioned(
//               child: Transform.translate(
//                 offset: evalCardOffset,
//                 child: Container(
//                   width: 175,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryLight,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: AppColors.border, width: 1.5),
//                     boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Score Card", style: AppTextStyles.white10semibold),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                             decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
//                             child: const Text("82%", style: AppTextStyles.goldLight10bold),
//                           ),
//                         ],
//                       ),
//                       const Divider(height: 10, color: Colors.white10),
//                       _checkRow("✓ Structure"),
//                       const SizedBox(height: 3),
//                       _checkRow("✓ Content Clarity"),
//                       const SizedBox(height: 3),
//                       _checkRow("✓ Presentation"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _checkRow(String text) {
//     return Row(
//       children: [
//         const Icon(Icons.check_circle_outline_rounded, color: AppColors.success, size: 10),
//         const SizedBox(width: 6),
//         Text(text, style: AppTextStyles.white9semibold),
//       ],
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // Step 4: Mentor guidlines with Mentor photo portrait
//   // ───────────────────────────────────────────────────────────────────────────
//   Widget _buildStep4(double val) {
//     final opacity = _getOpacityForSegment(start: 0.66, end: 0.83, val: val);
//     if (opacity <= 0.0) return const SizedBox.shrink();

//     // Pulse scale for sparkles
//     final sparkleScale = 0.8 + 0.2 * math.sin(val * 40);

//     Offset mentorCardOffset = const Offset(120.0, -150.0);
//     if (val >= 0.67) {
//       final t = ((val - 0.67) / 0.08).clamp(0.0, 1.0);
//       mentorCardOffset = Offset(
//         120.0 - 60 * t,
//         -150.0 + 30 * t,
//       );
//     }

//     return Opacity(
//       opacity: opacity,
//       child: Transform.translate(
//         offset: Offset(0, _floatAnimation.value),
//         child: Stack(
//           alignment: Alignment.center,
//           clipBehavior: Clip.none,
//           children: [
//             // Image 4: Mentor Photo Screen
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 15, offset: Offset(0, 4))],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   AppImage.onboardAnimationImg4,
//                   width: 170,
//                   height: 190,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Dr. Raj Sharma mentor text overlay card
//             Positioned(
//               child: Transform.translate(
//                 offset: mentorCardOffset,
//                 child: Container(
//                   width: 170,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.card,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.5),
//                     boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Dr. Raj Sharma",
//                         style: AppTextStyles.textPrimary11bold,
//                       ),
//                       const SizedBox(height: 2),
//                       const Text(
//                         "UPSC Mentor (15+ Yrs)",
//                         style: AppTextStyles.textSecondary8normal,
//                       ),
//                       const SizedBox(height: 6),
//                       const Row(
//                         children: [
//                           Icon(Icons.star_rounded, color: AppColors.gold, size: 10),
//                           SizedBox(width: 2),
//                           Text("4.9 Rating", style: AppTextStyles.textPrimary8bold),
//                           Spacer(),
//                           Text("Available Now", style: AppTextStyles.success8bold),
//                         ],
//                       ),
//                       const Divider(height: 12, thickness: 0.5),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(vertical: 6),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColors.gold.withValues(alpha: 0.12),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: const Text(
//                           "Book Consultation",
//                           style: AppTextStyles.goldMuted8semibold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Sparkles overlay near the card
//             Positioned(
//               top: -15,
//               right: 10,
//               child: Transform.scale(
//                 scale: sparkleScale,
//                 child: const Icon(Icons.auto_awesome, color: AppColors.goldLight, size: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // Step 5: Growth analysis graph with graph image
//   // ───────────────────────────────────────────────────────────────────────────
//   Widget _buildStep5(double val) {
//     final opacity = _getOpacityForSegment(start: 0.83, end: 1.0, val: val);
//     if (opacity <= 0.0) return const SizedBox.shrink();

//     double graphScale = 0.8;
//     if (val >= 0.84) {
//       graphScale = 0.8 + ((val - 0.84) / 0.08).clamp(0.0, 1.0) * 0.2;
//     }

//     return Opacity(
//       opacity: opacity,
//       child: Transform.translate(
//         offset: Offset(0, _floatAnimation.value),
//         child: Stack(
//           alignment: Alignment.center,
//           clipBehavior: Clip.none,
//           children: [
//             // Image 3: Progress Graph
//             Image.asset(
//               AppImage.onboardAnimationImg3,
//               width: 200,
//               fit: BoxFit.contain,
//             ),

//             // Mains Rank Gain card
//             Positioned(
//               bottom: 20,
//               child: Transform.scale(
//                 scale: graphScale,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.card,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.border),
//                     boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
//                   ),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.trending_up_rounded, color: AppColors.success, size: 16),
//                       SizedBox(width: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Mains Rank Gain", style: AppTextStyles.textSecondary8semibold),
//                           const Text("+12.4% Week", style: AppTextStyles.success10bold),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Bottom section
//   Widget _buildBottomSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//       decoration: const BoxDecoration(
//         color: Color(0xFF081525),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             "Your Path to UPSC Success",
//             style: AppTextStyles.white20bold,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Thousands of UPSC aspirants have cleared Mains and achieved their IAS/IPS dream by aligning their answers with our structured AI reviews and senior officer strategy guidance.",
//             style: AppTextStyles.white13normal.copyWith(fontSize: 12.5, height: 1.4, color: Colors.white60),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 24),
//           AnimatedBuilder(
//             animation: _buttonScaleAnimation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _buttonScaleAnimation.value,
//                 child: child,
//               );
//             },
//             child: GestureDetector(
//               onTap: _onGetStartedPressed,
//               child: Container(
//                 width: double.infinity,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   gradient: AppColors.goldGradient,
//                   borderRadius: BorderRadius.circular(14),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.gold.withValues(alpha: 0.4),
//                       blurRadius: 16,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Get Started",
//                       style: AppTextStyles.primaryDark15extraBold,
//                     ),
//                     const SizedBox(width: 8),
//                     Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 18),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _GoldenSpark {
//   double x;
//   double y;
//   final double size;
//   final double speed;
//   final double opacity;
//   _GoldenSpark({required this.x, required this.y, required this.size, required this.speed, required this.opacity});
// }

// class _SparksPainter extends CustomPainter {
//   final List<_GoldenSpark> sparks;
//   _SparksPainter({required this.sparks});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = AppColors.gold.withValues(alpha: 0.3);
//     for (var spark in sparks) {
//       paint.color = AppColors.gold.withValues(alpha: spark.opacity);
//       canvas.drawCircle(Offset(spark.x, spark.y), spark.size, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/core/routes/approute.dart';

/// ─────────────────────────────────────────────────────────────────────────
/// Premium single-page onboarding animation.
///
/// The ENTIRE illustration (logo → answer sheet → scan → AI evaluation →
/// mentor recommendation → progress dashboard → sparkles → hold) is driven
/// by a single [AnimationController] running an 8-second loop:
///   • 0.0s – 7.0s : the full narrative timeline described in the spec
///   • 7.0s – 8.0s : "hold" — the completed illustration stays on screen
///   • then it wraps back to 0 and restarts.
///
/// Every element reads its own phase out of that single controller via
/// small helper functions ([_in], [_inOut]) instead of using a separate
/// AnimationController per element — this keeps the whole 60fps loop to a
/// single Ticker.
///
/// A second, tiny controller ([_pressController]) is kept only for the
/// CTA button's *tap* feedback (press down / release), which is a discrete
/// user-interaction animation, not part of the narrative loop.
/// ─────────────────────────────────────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  // Single source of truth for the whole narrative animation.
  late final AnimationController _controller;

  // Tap-feedback only (press-down scale) — not part of the narrative loop.
  late final AnimationController _pressController;
  late final Animation<double> _pressScale;

  final List<_Spark> _sparks = List.generate(18, (i) {
    final r = math.Random(i * 17 + 3);
    return _Spark(dx: r.nextDouble(), dy: r.nextDouble(), size: 2 + r.nextDouble() * 3, phase: r.nextDouble());
  });

  // ── Timeline constants (all in milliseconds, total cycle = 8000ms) ──────
  static const double kTotalMs = 8000;

  static const double kLogoInStart = 0, kLogoInEnd = 500;
  static const double kLogoOutStart = 550, kLogoOutEnd = 850;

  static const double kSheetStart = 500, kSheetEnd = 1100;
  static const double kFloatStart = 1100; // continuous idle float begins once sheet has settled

  static const double kMagInStart = 1200, kMagInEnd = 1900;
  static const double kMagTrackEnd = 3150;
  static const double kMagOutStart = 3150, kMagOutEnd = 3450;

  static const double kScanStart = 2000, kScanEnd = 3200;
  static const double kScanFadeIn = 2100, kScanFadeOutStart = 3050;

  static const double kHighlightStart = 2800, kHighlightEnd = 3400;

  static const double kEvalStart = 3400, kEvalEnd = 4100;

  static const double kCheck1Start = 3900, kCheck1End = 4150;
  static const double kCheck2Start = 4150, kCheck2End = 4400;
  static const double kCheck3Start = 4400, kCheck3End = 4650;

  static const double kMentorStart = 4800, kMentorEnd = 5500;

  static const double kCtaPulseStart = 5500, kCtaPulseEnd = 7000;

  static const double kDashStart = 6000, kDashEnd = 6800;

  static const double kSparkleInStart = 6800, kSparkleInEnd = 6950;
  static const double kSparkleOutStart = 6950, kSparkleOutEnd = 7100;

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: kTotalMs.round()),
    )..repeat();

    _pressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _pressScale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _onGetStartedPressed() async {
    await _pressController.forward();
    await _pressController.reverse();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  // ── Timeline helpers ─────────────────────────────────────────────────────

  /// 0 before [startMs], eases 0→1 across the window, then HOLDS at 1
  /// (stays visible) until the loop restarts. Use for "appear and stay".
  static double _in(double val, double startMs, double endMs, {Curve curve = Curves.easeOutCubic}) {
    final s = startMs / kTotalMs;
    final e = endMs / kTotalMs;
    if (val <= s) return 0.0;
    if (e <= s) return 1.0;
    final raw = ((val - s) / (e - s)).clamp(0.0, 1.0);
    return curve.transform(raw);
  }

  /// Eases 0→1 into the window, holds at 1, then eases back 1→0 across the
  /// out-window. Use for transient elements (logo, magnifier, scanner line,
  /// sparkles) that should disappear again before the loop restarts.
  static double _inOut(double val, double inStart, double inEnd, double outStart, double outEnd) {
    final fadeIn = _in(val, inStart, inEnd, curve: Curves.easeOut);
    final fadeOut = 1.0 - _in(val, outStart, outEnd, curve: Curves.easeIn);
    return math.min(fadeIn, fadeOut).clamp(0.0, 1.0);
  }

  /// Continuous seamless idle float (returns to the same value every loop).
  static double _floatOffset(double val, {double amplitude = 6, double cyclesPerLoop = 3}) {
    return amplitude * math.sin(val * 2 * math.pi * cyclesPerLoop);
  }

  @override
  Widget build(BuildContext context) {
    const bgColors = [Color(0xFF0C1D33), Color(0xFF071221), Color(0xFF040A12)];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(center: Alignment(0, -0.1), radius: 1.4, colors: bgColors),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildDynamicQuoteBanner(),
              Expanded(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final val = _controller.value;
                    return Center(
                      child: SizedBox(
                        width: 340,
                        height: 440,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            _buildSparkles(val),
                            _buildLogo(val),
                            _buildAnswerSheetGroup(val),
                            _buildEvaluationCard(val),
                            _buildMentorCard(val),
                            _buildDashboard(val),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Header
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppColors.goldGradient.createShader(bounds),
            child: const Text('UPSC CONSULTANT', style: AppTextStyles.white16bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified_user_rounded, color: AppColors.goldLight, size: 12),
                SizedBox(width: 4),
                Text("Officer Mentors", style: AppTextStyles.goldLight9bold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Dynamic quote banner — text changes as the narrative timeline progresses
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildDynamicQuoteBanner() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final ms = _controller.value * kTotalMs;
        String text;
        IconData icon;

        if (ms < kScanStart) {
          text = "Upload your Mains answer copy in seconds";
          icon = Icons.camera_alt_rounded;
        } else if (ms < kEvalStart) {
          text = "AI scans structure, content and presentation";
          icon = Icons.center_focus_strong_rounded;
        } else if (ms < kMentorStart) {
          text = "Get real evaluation aligned with the UPSC pattern";
          icon = Icons.fact_check_rounded;
        } else if (ms < kDashStart) {
          text = "Align your strategy with senior UPSC officers";
          icon = Icons.workspace_premium_rounded;
        } else {
          text = "Build consistent score gains toward your IAS rank";
          icon = Icons.trending_up_rounded;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: ValueKey(text),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.goldLight, size: 16),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(text, style: AppTextStyles.white11semibold.copyWith(color: Colors.white70)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // 0.0s — App logo: fade in + scale 0.8 → 1.0, then fades out once the
  // answer sheet takes over the stage.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildLogo(double val) {
    final opacity = _inOut(val, kLogoInStart, kLogoInEnd, kLogoOutStart, kLogoOutEnd);
    if (opacity <= 0.0) return const SizedBox.shrink();

    final growth = _in(val, kLogoInStart, kLogoInEnd, curve: Curves.easeOutBack);
    final scale = 0.8 + 0.2 * growth;

    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.45), blurRadius: 24, spreadRadius: 2)],
          ),
          child: const Icon(Icons.workspace_premium_rounded, color: AppColors.primaryDark, size: 40),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // 0.5s — Answer sheet slides up + settles, then floats continuously.
  // Also hosts the magnifying glass, scanner line and line-highlights,
  // all of which are drawn relative to the sheet.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildAnswerSheetGroup(double val) {
    final sheetOpacity = _in(val, kSheetStart, kSheetEnd, curve: Curves.easeOut);
    if (sheetOpacity <= 0.0) return const SizedBox.shrink();

    final settle = _in(val, kSheetStart, kSheetEnd, curve: Curves.easeOutCubic);
    final scale = 0.9 + 0.1 * settle;
    final entranceY = 40 * (1 - settle); // slides up from +40 → 0
    final floatY = val >= kFloatStart / kTotalMs ? _floatOffset(val) : 0.0;

    const sheetWidth = 168.0;
    const sheetHeight = 220.0;

    return Opacity(
      opacity: sheetOpacity,
      child: Transform.translate(
        offset: Offset(0, entranceY + floatY),
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: sheetWidth,
            height: sheetHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Raw answer copy asset (reused from existing onboarding assets)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(AppImage.onboardAnimationImg1, width: sheetWidth, height: sheetHeight, fit: BoxFit.cover),
                ),

                // 2.8s — Highlighted important lines (blue glow, fade in, stays)
                ..._buildHighlightLines(val, sheetWidth),

                // 2.0s — Scanner line, top → bottom, once per loop
                _buildScannerLine(val, sheetWidth),

                // 1.2s — Magnifying glass
                _buildMagnifier(val, sheetHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHighlightLines(double val, double sheetWidth) {
    final glow = _in(val, kHighlightStart, kHighlightEnd, curve: Curves.easeOut);
    if (glow <= 0.0) return const [];

    const tops = [58.0, 96.0, 134.0];
    return tops
        .map(
          (top) => Positioned(
            top: top,
            left: 16,
            child: Opacity(
              opacity: glow,
              child: Container(
                width: sheetWidth - 46,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C0FF).withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: const Color(0xFF00C0FF).withValues(alpha: 0.35 * glow), blurRadius: 8, spreadRadius: 1)],
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildScannerLine(double val, double sheetWidth) {
    final travel = _in(val, kScanStart, kScanEnd, curve: Curves.linear);
    final opacity = _inOut(val, kScanStart, kScanFadeIn, kScanFadeOutStart, kScanEnd);
    if (opacity <= 0.0) return const SizedBox.shrink();

    return Positioned(
      top: 4 + travel * 208,
      left: 6,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: sheetWidth - 12,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF00C0FF),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [BoxShadow(color: const Color(0xFF00C0FF).withValues(alpha: 0.6), blurRadius: 10, spreadRadius: 3)],
          ),
        ),
      ),
    );
  }

  Widget _buildMagnifier(double val, double sheetHeight) {
    final opacity = _inOut(val, kMagInStart, kMagInEnd, kMagOutStart, kMagOutEnd);
    if (opacity <= 0.0) return const SizedBox.shrink();

    final scaleIn = _in(val, kMagInStart, kMagInEnd, curve: Curves.easeOutBack);
    final rotation = (5 + 3 * scaleIn) * math.pi / 180; // 5–8°

    // Tracks down the sheet alongside the scanner line while active.
    final track = _in(val, kMagInStart, kMagTrackEnd, curve: Curves.easeInOut);
    final top = 10 + track * (sheetHeight - 60);
    final wobbleX = 6 * math.sin(val * 2 * math.pi * 10);

    return Positioned(
      top: top,
      left: 8 + wobbleX,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: rotation,
          child: Transform.scale(
            scale: scaleIn,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: const Icon(Icons.search_rounded, color: AppColors.primary, size: 22),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // 3.4s — AI Evaluation card slides in from the right and stays.
  // 3.9s — Checklist items appear one by one inside it.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildEvaluationCard(double val) {
    final progress = _in(val, kEvalStart, kEvalEnd, curve: Curves.easeOutCubic);
    if (progress <= 0.0) return const SizedBox.shrink();

    final slideX = 90 * (1 - progress); // slides in from the right
    final floatY = val >= kFloatStart / kTotalMs ? _floatOffset(val, amplitude: 4, cyclesPerLoop: 2.4) : 0.0;

    return Positioned(
      top: 6,
      right: -8,
      child: Opacity(
        opacity: progress,
        child: Transform.translate(
          offset: Offset(slideX, floatY),
          child: Container(
            width: 168,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border, width: 1.5),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 14, offset: Offset(0, 6))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("AI Evaluation", style: AppTextStyles.white10semibold),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                      child: const Text("82%", style: AppTextStyles.goldLight10bold),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text("Evaluation Completed", style: AppTextStyles.white9semibold.copyWith(color: Colors.white54)),
                const Divider(height: 14, color: Colors.white10),
                _buildCheckItem("Structure", _in(val, kCheck1Start, kCheck1End, curve: Curves.easeOutBack)),
                const SizedBox(height: 4),
                _buildCheckItem("Content", _in(val, kCheck2Start, kCheck2End, curve: Curves.easeOutBack)),
                const SizedBox(height: 4),
                _buildCheckItem("Presentation", _in(val, kCheck3Start, kCheck3End, curve: Curves.easeOutBack)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text, double scale) {
    if (scale <= 0.0) return const SizedBox(height: 12);
    return Opacity(
      opacity: scale.clamp(0.0, 1.0),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 13),
            const SizedBox(width: 6),
            Text(text, style: AppTextStyles.white9semibold),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // 4.8s — Mentor recommendation card slides in from the left and stays.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildMentorCard(double val) {
    final progress = _in(val, kMentorStart, kMentorEnd, curve: Curves.easeOutCubic);
    if (progress <= 0.0) return const SizedBox.shrink();

    final slideX = -90 * (1 - progress); // slides in from the left
    final floatY = val >= kFloatStart / kTotalMs ? _floatOffset(val, amplitude: 4, cyclesPerLoop: 2.7) : 0.0;

    return Positioned(
      bottom: 96,
      left: -10,
      child: Opacity(
        opacity: progress,
        child: Transform.translate(
          offset: Offset(slideX, floatY),
          child: Container(
            width: 176,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.35), width: 1.5),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 14, offset: Offset(0, 6))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                      child: const Icon(Icons.person_rounded, color: AppColors.primaryDark, size: 18),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dr. Raj Sharma", style: AppTextStyles.textPrimary11bold),
                          Text("15+ Yrs · Senior Mentor", style: AppTextStyles.textSecondary8normal),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                  child: const Text("Book 1-on-1 Strategy Session", textAlign: TextAlign.center, style: AppTextStyles.goldMuted8semibold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // 6.0s — Progress dashboard: growth graph draws left→right, circular
  // ring fills 0 → 84%, target icon pulses gently.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildDashboard(double val) {
    final progress = _in(val, kDashStart, kDashEnd, curve: Curves.easeOut);
    if (progress <= 0.0) return const SizedBox.shrink();

    final graphDraw = _in(val, kDashStart, kDashStart + 600, curve: Curves.easeOut);
    final ringFill = _in(val, kDashStart, kDashEnd, curve: Curves.easeOutCubic) * 0.84;
    final targetPulse = val >= kDashStart / kTotalMs ? 1.0 + 0.06 * math.sin(val * 2 * math.pi * 5) : 1.0;
    final floatY = val >= kFloatStart / kTotalMs ? _floatOffset(val, amplitude: 3, cyclesPerLoop: 3.3) : 0.0;

    return Positioned(
      bottom: -4,
      child: Opacity(
        opacity: progress,
        child: Transform.translate(
          offset: Offset(0, floatY),
          child: Container(
            width: 210,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 14, offset: Offset(0, 6))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Mains Rank Gain", style: AppTextStyles.textSecondary8semibold),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 84,
                      height: 34,
                      child: CustomPaint(painter: _GrowthGraphPainter(progress: graphDraw)),
                    ),
                    const SizedBox(height: 2),
                    const Text("+12.4% Week", style: AppTextStyles.success10bold),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(54, 54),
                            painter: _RingPainter(fraction: ringFill),
                          ),
                          Text("${(ringFill / 0.84 * 84).round()}%", style: AppTextStyles.textPrimary8bold.copyWith(fontSize: 11)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Transform.scale(
                      scale: targetPulse,
                      child: const Icon(Icons.adjust_rounded, color: AppColors.gold, size: 16),
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

  // ───────────────────────────────────────────────────────────────────────
  // 6.8s — Soft sparkles fade in, then fade out.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildSparkles(double val) {
    final envelope = _inOut(val, kSparkleInStart, kSparkleInEnd, kSparkleOutStart, kSparkleOutEnd);
    if (envelope <= 0.0) return const SizedBox.shrink();

    return IgnorePointer(
      child: CustomPaint(
        size: const Size(340, 440),
        painter: _SparklesPainter(sparks: _sparks, envelope: envelope, val: val),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Bottom title + CTA. Button gets an idle pulse (5.5s → 7.0s window)
  // driven by the same main controller, layered under the tap-feedback scale.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildBottomSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF081525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Your Path to UPSC Success", style: AppTextStyles.white20bold, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(
            "Thousands of UPSC aspirants have cleared Mains and achieved their IAS/IPS dream by aligning their answers with our structured AI reviews and senior officer strategy guidance.",
            style: AppTextStyles.white13normal.copyWith(fontSize: 12.5, height: 1.4, color: Colors.white60),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: Listenable.merge([_controller, _pressScale]),
            builder: (context, child) {
              final s = _controller.value;
              double idlePulse = 1.0;
              if (s >= kCtaPulseStart / kTotalMs && s <= kCtaPulseEnd / kTotalMs) {
                final localMs = s * kTotalMs - kCtaPulseStart;
                idlePulse = 1.0 + 0.04 * math.sin(localMs / 750 * 2 * math.pi);
              }
              return Transform.scale(scale: idlePulse * _pressScale.value, child: child);
            },
            child: GestureDetector(
              onTap: _onGetStartedPressed,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get Started", style: AppTextStyles.primaryDark15extraBold),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Painters
// ═══════════════════════════════════════════════════════════════════════

/// Draws the ascending growth line, revealing it left→right based on
/// [progress] (0 = nothing drawn, 1 = fully drawn).
class _GrowthGraphPainter extends CustomPainter {
  final double progress;
  _GrowthGraphPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0) return;

    final path = Path()
      ..moveTo(0, size.height * 0.85)
      ..cubicTo(size.width * 0.25, size.height * 0.75, size.width * 0.35, size.height * 0.55, size.width * 0.55, size.height * 0.45)
      ..cubicTo(size.width * 0.7, size.height * 0.38, size.width * 0.8, size.height * 0.15, size.width, 0);

    final metric = path.computeMetrics().first;
    final drawPath = metric.extractPath(0, metric.length * progress.clamp(0.0, 1.0));

    final linePaint = Paint()
      ..color = AppColors.success
      ..strokeWidth = 2.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(drawPath, linePaint);

    // Leading dot at the tip of the drawn line.
    if (progress > 0.02) {
      final tangent = metric.getTangentForOffset(metric.length * progress.clamp(0.0, 1.0));
      if (tangent != null) {
        canvas.drawCircle(tangent.position, 3.2, Paint()..color = AppColors.success);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GrowthGraphPainter oldDelegate) => oldDelegate.progress != progress;
}

/// Circular progress ring, sweeping from 0 up to [fraction] (0.0 – 1.0).
class _RingPainter extends CustomPainter {
  final double fraction;
  _RingPainter({required this.fraction});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    final track = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.15)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, track);

    final arc = Paint()
      ..color = AppColors.gold
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweep = 2 * math.pi * fraction.clamp(0.0, 1.0);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, sweep, false, arc);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.fraction != fraction;
}

class _Spark {
  final double dx; // 0..1 fractional position within the canvas
  final double dy;
  final double size;
  final double phase; // 0..1 twinkle offset so sparks don't blink in sync
  _Spark({required this.dx, required this.dy, required this.size, required this.phase});
}

class _SparklesPainter extends CustomPainter {
  final List<_Spark> sparks;
  final double envelope; // overall fade in/out (0..1)
  final double val; // controller value, for twinkle motion
  _SparklesPainter({required this.sparks, required this.envelope, required this.val});

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in sparks) {
      final twinkle = 0.5 + 0.5 * math.sin((val * 6 + s.phase) * 2 * math.pi);
      final opacity = (envelope * twinkle).clamp(0.0, 1.0);
      if (opacity <= 0.02) continue;
      final paint = Paint()..color = AppColors.goldLight.withValues(alpha: opacity * 0.85);
      canvas.drawCircle(Offset(s.dx * size.width, s.dy * size.height), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklesPainter oldDelegate) => true;
}
