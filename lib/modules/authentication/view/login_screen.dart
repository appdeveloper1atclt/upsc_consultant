import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_text_styles.dart';
import '../../../core/routes/approute.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _mobileController = TextEditingController();
  final _mobileFocus = FocusNode();
  bool _mobileHasFocus = false;
  bool _isLoading = false;

  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<double>(begin: 30, end: 0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();

    _mobileFocus.addListener(() {
      setState(() => _mobileHasFocus = _mobileFocus.hasFocus);
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileFocus.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _getOtp() async {
    if (_mobileController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid 10-digit mobile number'),
          backgroundColor: AppColors.primaryDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      context.push('${AppRoutes.otpVerify}?mobile=${_mobileController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomPad + 20),
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) => Opacity(
            opacity: _fade.value,
            child: Transform.translate(offset: Offset(0, _slide.value), child: child),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: topPad + 48),

                // ── Logo ─────────────────────────────────────────────
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 2)],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppImage.appLogo,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFF3EDE2),
                        child: const Icon(Icons.school_rounded, color: AppColors.gold, size: 40),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Welcome Back!',
                  style: AppTextStyles.textPrimary26bold,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Login to continue your UPSC journey',
                  style: AppTextStyles.textHint14normal,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 36),

                // ── Mobile Number label ──────────────────────────────
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mobile Number',
                    style: AppTextStyles.textPrimary13bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Input Field
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _mobileHasFocus ? AppColors.gold : const Color(0xFFE2D9CC), width: _mobileHasFocus ? 1.5 : 1),
                  ),
                  child: Row(
                    children: [
                      // Flag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: _mobileHasFocus ? AppColors.gold.withValues(alpha: 0.3) : const Color(0xFFE2D9CC), width: 1)),
                        ),
                        child: const Row(
                          children: [
                            Text('🇮🇳', style: TextStyle(fontSize: 17)),
                            SizedBox(width: 6),
                            Text(
                              '+91',
                              style: AppTextStyles.textPrimary14semibold,
                            ),
                          ],
                        ),
                      ),

                      // Text input
                      Expanded(
                        child: TextField(
                          controller: _mobileController,
                          focusNode: _mobileFocus,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          cursorColor: AppColors.gold,
                          style: AppTextStyles.textPrimary14semibold.copyWith(fontSize: 15, letterSpacing: 1),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                            hintText: 'Enter mobile number',
                            hintStyle: AppTextStyles.greyB0B8C5_14normal,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                            counterText: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Send OTP Button
                GestureDetector(
                  onTap: _isLoading ? null : _getOtp,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFB8912E), Color(0xFFD4A843), Color(0xFFE8C060)]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 14, offset: const Offset(0, 4))],
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                          : const Text(
                              'Send OTP',
                              style: AppTextStyles.white15medium,
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // OR Divider
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: const Color(0xFFEDE5D8))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'OR',
                        style: AppTextStyles.greyB0B8C5_11normal,
                      ),
                    ),
                    Expanded(child: Container(height: 1, color: const Color(0xFFEDE5D8))),
                  ],
                ),

                const SizedBox(height: 20),

                // Google Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2D9CC), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.googleImg, height: 16, width: 16),
                        const SizedBox(width: 10),
                        const Text(
                          'Continue with Google',
                          style: AppTextStyles.textPrimary14semibold,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Terms ────────────────────────────────────────────
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.greyB0B8C5_11normal,
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: AppTextStyles.goldLight13medium.copyWith(color: const Color(0xFFD4A843), fontWeight: FontWeight.w600, fontSize: 11),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTextStyles.goldLight13medium.copyWith(color: const Color(0xFFD4A843), fontWeight: FontWeight.w600, fontSize: 11),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
