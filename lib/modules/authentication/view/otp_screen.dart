import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/routes/approute.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with SingleTickerProviderStateMixin {
  // 6 OTP boxes
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _isResending = false;

  // Countdown timer for resend
  int _secondsLeft = 30;
  Timer? _timer;

  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));

    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<double>(begin: 24, end: 0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();

    _startTimer();

    // Auto-move to next on input
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].addListener(() => _onOtpChanged(i));
    }
  }

  void _startTimer() {
    _secondsLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _onOtpChanged(int index) {
    final text = _otpControllers[index].text;
    if (text.length == 1) {
      // Move forward
      if (index < 5) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
        // All filled — auto verify
        _verifyOtp();
      }
    }
  }

  String get _fullOtp => _otpControllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    if (_fullOtp.length < 6) {
      _showSnack('Please enter the complete 6-digit OTP');
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // Navigate to home on success
      context.go(AppRoutes.home);
    }
  }

  Future<void> _resendOtp() async {
    if (_secondsLeft > 0) return;
    setState(() => _isResending = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isResending = false);
      _startTimer();
      // Clear all boxes
      for (var c in _otpControllers) {
        c.clear();
      }
      FocusScope.of(context).requestFocus(_focusNodes[0]);
      _showSnack('OTP resent to +91 ${widget.mobileNumber}');
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppColors.primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    _ctrl.dispose();
    super.dispose();
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
                SizedBox(height: topPad + 20),

                // ── Back + Logo row ───────────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F5F0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEDE5D8), width: 1),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Color(0xFF0A1628)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                // ── Logo ─────────────────────────────────────────────
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.25), blurRadius: 18, spreadRadius: 2)],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppImage.appLogo,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFF3EDE2),
                        child: const Icon(Icons.school_rounded, color: AppColors.gold, size: 36),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Title ─────────────────────────────────────────────
                const Text(
                  'Enter OTP',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF0A1628)),
                ),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: Color(0xFF718096), height: 1.5),
                    children: [
                      const TextSpan(text: "We've sent a 6-digit OTP to\n"),
                      TextSpan(
                        text: '+91 ${widget.mobileNumber}',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0A1628)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── OTP Boxes ─────────────────────────────────────────
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, (i) => _buildOtpBox(i))),

                const SizedBox(height: 36),

                // ── Verify Button ─────────────────────────────────────
                GestureDetector(
                  onTap: _isLoading ? null : _verifyOtp,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isLoading
                            ? [const Color(0xFFB8912E).withOpacity(0.6), const Color(0xFFE8C060).withOpacity(0.6)]
                            : const [Color(0xFFB8912E), Color(0xFFD4A843), Color(0xFFE8C060)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.28), blurRadius: 14, offset: const Offset(0, 4))],
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                          : const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.4,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Resend OTP ────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive OTP? ",
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: Color(0xFF718096)),
                    ),
                    GestureDetector(
                      onTap: _secondsLeft == 0 ? _resendOtp : null,
                      child: _isResending
                          ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2))
                          : Text(
                              _secondsLeft > 0 ? 'Resend in ${_secondsLeft}s' : 'Resend OTP',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _secondsLeft > 0 ? const Color(0xFFB0B8C5) : AppColors.gold,
                              ),
                            ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Change Number ─────────────────────────────────────
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Text(
                    'Change Mobile Number',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF718096),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF718096),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    final isFilled = _otpControllers[index].text.isNotEmpty;

    return SizedBox(
      width: 46,
      height: 54,
      child: Focus(
        onFocusChange: (_) => setState(() {}),
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          cursorColor: AppColors.gold,
          cursorWidth: 2,
          style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0A1628)),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (val) {
            if (val.isEmpty && index > 0) {
              // Backspace — go back
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: isFilled ? AppColors.gold.withOpacity(0.06) : const Color(0xFFF8F5F0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: isFilled ? AppColors.gold.withOpacity(0.5) : const Color(0xFFE2D9CC), width: isFilled ? 1.5 : 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.gold, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
