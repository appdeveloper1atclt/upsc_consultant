import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/authentication/view/login_screen.dart';
import '../../modules/authentication/view/otp_screen.dart';
import '../../modules/home/view/home_screen.dart';
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
        return _slideIn(OtpScreen(mobileNumber: mobile));
      },
    ),

    // ── Home ─────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (context, state) => _slideIn(const HomeScreen()),
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
