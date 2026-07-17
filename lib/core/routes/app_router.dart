import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/authentication/view/login_screen.dart';
import '../../modules/authentication/view/otp_screen.dart';
import '../../modules/home/view/home_screen.dart';
import '../../modules/home/widgets/top_mentors_section.dart';
import '../../modules/mentors/view/mentor_detail_screen.dart';
import '../../modules/mentors/view/payment_screen.dart';
import '../../modules/home/view/analysis_screen.dart';
import '../../modules/daily_challenge/models/daily_challenge.dart';
import '../../modules/daily_challenge/views/pt_topic_select_screen.dart';
import '../../modules/daily_challenge/views/pt_instructions_screen.dart';
import '../../modules/daily_challenge/views/pt_quiz_screen.dart';
import '../../modules/daily_challenge/views/pt_result_screen.dart';
import '../../modules/daily_challenge/views/pt_preview_screen.dart';
import '../../modules/home/view/pending_learning_screen.dart';
import '../../modules/home/view/study_analytics_screen.dart';
import '../../modules/home/view/consultation_flow_screen.dart';
import 'approute.dart';


/// Central GoRouter configuration.
/// All app navigation is defined here — nowhere else.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true, // prints navigation logs in debug
  routes: [
    // ── Splash ──────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SplashScreen(),
      ),
    ),

    // ── Onboarding ──────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      pageBuilder: (context, state) => _slideIn(const OnboardingScreen()),
    ),

    // ── Login ────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      pageBuilder: (context, state) => _slideIn(const LoginScreen()),
    ),

    // ── OTP Verify ───────────────────────────────────────────────────────────
    // Receives mobileNumber as query param: /otp-verify?mobile=9876543210
    GoRoute(
      path: AppRoutes.otpVerify,
      name: 'otp-verify',
      pageBuilder: (context, state) {
        final mobile = state.uri.queryParameters['mobile'] ?? '';
        return _slideIn(OtpVerificationScreen(mobileNumber: mobile));
      },
    ),

    // ── Home ─────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (context, state) => _slideIn(const HomeScreen()),
    ),

    // ── Mentor Detail ────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.mentorDetail,
      name: 'mentor-detail',
      pageBuilder: (context, state) {
        final mentor = state.extra as MentorData;
        return _slideIn(MentorDetailScreen(mentor: mentor));
      },
    ),

    // ── Payment ──────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.payment,
      name: 'payment',
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final mentor = data['mentor'] as MentorData;
        final slot = data['slot'] as String;
        return _slideIn(PaymentScreen(mentor: mentor, selectedSlot: slot));
      },
    ),

    // ── Analysis ─────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.analysis,
      name: 'analysis',
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final fileName = data['fileName'] as String;
        final fileType = data['fileType'] as String;
        return _slideIn(AnalysisScreen(fileName: fileName, fileType: fileType));
      },
    ),

    // ── Daily PT Challenge Select ──────────────────────────────────────────
    GoRoute(
      path: AppRoutes.dailyPtSelect,
      name: 'daily-pt-select',
      pageBuilder: (context, state) => _slideIn(const PtTopicSelectScreen()),
    ),

    // ── Daily PT Challenge Instructions ─────────────────────────────────────
    GoRoute(
      path: AppRoutes.dailyPtInstructions,
      name: 'daily-pt-instructions',
      pageBuilder: (context, state) {
        final challenge = state.extra as DailyChallenge;
        return _slideIn(PtInstructionsScreen(challenge: challenge));
      },
    ),

    // ── Daily PT Challenge Quiz ─────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.dailyPtQuiz,
      name: 'daily-pt-quiz',
      pageBuilder: (context, state) => _slideIn(const PtQuizScreen()),
    ),

    // ── Daily PT Challenge Result ───────────────────────────────────────────
    GoRoute(
      path: AppRoutes.dailyPtResult,
      name: 'daily-pt-result',
      pageBuilder: (context, state) => _slideIn(const PtResultScreen()),
    ),

    // ── Daily PT Challenge Preview ──────────────────────────────────────────
    GoRoute(
      path: AppRoutes.dailyPtPreview,
      name: 'daily-pt-preview',
      pageBuilder: (context, state) => _slideIn(const PtPreviewScreen()),
    ),

    // ── Pending Learning ────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.pendingLearning,
      name: 'pending-learning',
      pageBuilder: (context, state) => _slideIn(const PendingLearningScreen()),
    ),

    // ── Study Analytics ─────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.studyAnalytics,
      name: 'study-analytics',
      pageBuilder: (context, state) => _slideIn(const StudyAnalyticsScreen()),
    ),

    // ── Consultation Flow ───────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.consult,
      name: 'consult',
      pageBuilder: (context, state) => _slideIn(const ConsultationFlowScreen()),
    ),
  ],


  // ── Global error page ────────────────────────────────────────────────────
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Color(0xFFD4A843), size: 60),
            const SizedBox(height: 16),
            Text('Page not found',
                style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800])),
            const SizedBox(height: 8),
            Text(state.error.toString(),
                style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                    color: Colors.grey)),
          ],
        ),
      ),
    ),
  ),
);

/// Bottom-to-top slide transition page
CustomTransitionPage<void> _slideIn(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween =
          Tween(begin: const Offset(0, 0.06), end: Offset.zero).chain(
        CurveTween(curve: Curves.easeOut),
      );
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: animation.drive(tween), child: child),
      );
    },
    transitionDuration: const Duration(milliseconds: 320),
  );
}
