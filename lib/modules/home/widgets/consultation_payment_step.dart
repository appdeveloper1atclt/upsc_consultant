import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../model/session_type_model.dart';
import 'consultation_flow_widgets.dart';

class ConsultationPaymentStep extends StatelessWidget {
  final SessionTypeModel activeSession;
  final String selectedTimeSlot;
  final String formattedDate;
  final String selectedPaymentMethod;
  final bool couponApplied;
  final double discountAmount;
  final String appliedCouponCode;
  final TextEditingController couponController;
  final VoidCallback onApplyCoupon;
  final VoidCallback onRemoveCoupon;
  final ValueChanged<String> onPaymentMethodChanged;
  final String Function(String) getEndTime;

  const ConsultationPaymentStep({
    super.key,
    required this.activeSession,
    required this.selectedTimeSlot,
    required this.formattedDate,
    required this.selectedPaymentMethod,
    required this.couponApplied,
    required this.discountAmount,
    required this.appliedCouponCode,
    required this.couponController,
    required this.onApplyCoupon,
    required this.onRemoveCoupon,
    required this.onPaymentMethodChanged,
    required this.getEndTime,
  });

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 14 : 11.5,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, IconData icon) {
    final isSelected = selectedPaymentMethod == title;

    return GestureDetector(
      onTap: () => onPaymentMethodChanged(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.2 : 0.8,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 5 : 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double baseAmount = activeSession.price.toDouble();
    final double taxableAmount = baseAmount - discountAmount;
    final double gst = taxableAmount * 0.18;
    final double platformFee = 10.0;
    final double grandTotal = taxableAmount + gst + platformFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete your payment to confirm the session.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 18),

        // Session Summary Billing Receipt
        const Text(
          'Billing Summary',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),

        // Premium Voucher Ticket with Side Notches
        ClipPath(
          clipper: TicketClipper(),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activeSession.title,
                      style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        selectedTimeSlot,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Date: $formattedDate',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),

                // Ticket cut dotted divider line
                Row(
                  children: List.generate(
                    30,
                    (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : AppColors.divider,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                _buildSummaryRow('Base Fee', '₹${baseAmount.toStringAsFixed(0)}'),
                if (couponApplied) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Promo Discount ($appliedCouponCode)',
                        style: const TextStyle(fontSize: 11.5, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '-₹${discountAmount.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 11.5, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                _buildSummaryRow('GST (18%)', '₹${gst.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _buildSummaryRow('Platform Fee', '₹${platformFee.toStringAsFixed(0)}'),
                const SizedBox(height: 12),
                const Divider(color: AppColors.divider, height: 1),
                const SizedBox(height: 12),
                _buildSummaryRow('Grand Total', '₹${grandTotal.toStringAsFixed(2)}', isBold: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Coupon Box section
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 0.8),
          ),
          child: Row(
            children: [
              const Icon(Icons.local_offer_rounded, color: AppColors.gold, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: couponController,
                  enabled: !couponApplied,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: 'Enter Coupon (Try "UPSC100")',
                    hintStyle: TextStyle(fontSize: 12, color: AppColors.textHint),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (couponApplied)
                TextButton(
                  onPressed: onRemoveCoupon,
                  child: const Text('REMOVE', style: TextStyle(color: AppColors.error, fontSize: 11, fontWeight: FontWeight.w900)),
                )
              else
                TextButton(
                  onPressed: onApplyCoupon,
                  child: const Text('APPLY', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w900)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Payment Methods Section
        const Text(
          'Choose Payment Method',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),

        _buildPaymentOption('UPI', 'Pay using any UPI app', Icons.payment_rounded),
        const SizedBox(height: 10),
        _buildPaymentOption('Credit / Debit Card', 'Visa, Mastercard, RuPay', Icons.credit_card_rounded),
        const SizedBox(height: 10),
        _buildPaymentOption('Net Banking', 'All major banks supported', Icons.account_balance_rounded),
        const SizedBox(height: 10),
        _buildPaymentOption('Wallets', 'Paytm, PhonePe, Amazon Pay', Icons.wallet_rounded),
      ],
    );
  }
}
