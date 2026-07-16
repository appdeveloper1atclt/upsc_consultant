/// All API endpoint paths — update base URL per environment
class ApiEndpoints {
  ApiEndpoints._();

  // ── Base URL ────────────────────────────────────────────────────────────
  static const String baseUrl = 'https://api.upscconsultant.com/v1';

  // ── Auth ─────────────────────────────────────────────────────────────────
  static const String sendOtp     = '/auth/send-otp';
  static const String verifyOtp   = '/auth/verify-otp';
  static const String googleLogin = '/auth/google';
  static const String refreshToken = '/auth/refresh';
  static const String logout      = '/auth/logout';

  // ── User ─────────────────────────────────────────────────────────────────
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
}
