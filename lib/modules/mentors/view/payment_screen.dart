import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/modules/home/widgets/top_mentors_section.dart';
import '../../../core/widgets/shimmer_placeholder.dart';

class PaymentScreen extends StatefulWidget {
  final MentorData mentor;
  final String selectedSlot;

  const PaymentScreen({
    super.key,
    required this.mentor,
    required this.selectedSlot,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'upi';
  bool _isProcessing = false;

  void _processPayment() {
    setState(() => _isProcessing = true);

    // Simulate payment processing for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isProcessing = false);
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Payment Successful! 🎉",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Your session with ${widget.mentor.name} is confirmed.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _infoRow("Mentor", widget.mentor.name),
                    const SizedBox(height: 8),
                    _infoRow("Slot", widget.selectedSlot),
                    const SizedBox(height: 8),
                    _infoRow("Amount Paid", "₹${(widget.mentor.price * 1.18).round()}"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Pop dialog and pop payment screen to go back to mentors
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'PlusJakartaSans'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans'),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gst = widget.mentor.price * 0.18;
    final int total = (widget.mentor.price + gst).round();

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Secure Checkout",
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mentor details card summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: widget.mentor.photoUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const ShimmerPlaceholder.circle(size: 50),
                          errorWidget: (context, url, error) => Container(width: 50, height: 50, color: AppColors.chipBackground),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mentor.name,
                              style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
                            ),
                            Text(
                              widget.mentor.expertise,
                              style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset(AppImage.calenderImg, width: 12, height: 12, color: AppColors.gold),
                                const SizedBox(width: 6),
                                Text(
                                  widget.selectedSlot,
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.goldMuted, fontFamily: 'PlusJakartaSans'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Payment Methods Options
                const Text(
                  "Choose Payment Method",
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _paymentMethodTile(
                        id: 'upi',
                        title: 'UPI (GPay / PhonePe / Paytm)',
                        icon: Icons.qr_code_2_rounded,
                        subtitle: 'Pay instantly using any UPI app',
                      ),
                      const Divider(height: 1, indent: 56),
                      _paymentMethodTile(
                        id: 'card',
                        title: 'Credit / Debit Card',
                        icon: Icons.credit_card_rounded,
                        subtitle: 'Visa, MasterCard, RuPay, Maestro',
                      ),
                      const Divider(height: 1, indent: 56),
                      _paymentMethodTile(
                        id: 'netbanking',
                        title: 'Net Banking',
                        icon: Icons.account_balance_rounded,
                        subtitle: 'All major Indian banks supported',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Billing Details summary card
                const Text(
                  "Billing Summary",
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Session Price", style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans')),
                          Text("₹${widget.mentor.price}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("GST (18%)", style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans')),
                          Text("₹${gst.toStringAsFixed(1)}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans')),
                        ],
                      ),
                      const Divider(height: 24, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
                          ),
                          Text(
                            "₹$total",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.goldMuted, fontFamily: 'PlusJakartaSans'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Secure trust banner
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Text(
                      "256-Bit SSL Secure Connection",
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 80), // spacer for bottom action button
              ],
            ),
          ),
          // Floating Bottom Button Area
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: const Border(top: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: SafeArea(
                top: false,
                child: GestureDetector(
                  onTap: _processPayment,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Pay ₹$total",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Full Screen Processing Loader
          if (_isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: AppColors.card,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.gold)),
                        SizedBox(height: 18),
                        Text(
                          "Processing Secure Payment...",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _paymentMethodTile({
    required String id,
    required String title,
    required IconData icon,
    required String subtitle,
  }) {
    final isSelected = _selectedMethod == id;
    return InkWell(
      onTap: () => setState(() => _selectedMethod = id),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gold.withValues(alpha: 0.12) : AppColors.chipBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? AppColors.goldMuted : AppColors.textSecondary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans'),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.gold : AppColors.textSecondary,
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
