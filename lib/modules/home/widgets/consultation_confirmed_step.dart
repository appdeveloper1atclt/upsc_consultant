import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/routes/approute.dart';
import 'package:go_router/go_router.dart';

class ConsultationConfirmedStep extends StatelessWidget {
  final String mentorName;
  final String bookingId;
  final String formattedDate;
  final String selectedTimeSlot;
  final String durationString;
  final double paidAmount;
  final String googleMeetLinkMessage;
  final VoidCallback onAddToCalendar;
  final VoidCallback onDownloadReceipt;

  const ConsultationConfirmedStep({
    super.key,
    required this.mentorName,
    required this.bookingId,
    required this.formattedDate,
    required this.selectedTimeSlot,
    required this.durationString,
    required this.paidAmount,
    this.googleMeetLinkMessage = 'Will be shared 30 min before',
    required this.onAddToCalendar,
    required this.onDownloadReceipt,
  });

  Widget _buildConfirmedRow(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isLink ? const Color(0xFF3B82F6) : AppColors.textPrimary,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Container(
          width: 68,
          height: 68,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 48),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Booking Confirmed!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        const Text(
          'Your consultation session is all set.',
          style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        // Session Confirmation Details Receipt Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Session Details',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildConfirmedRow('Booking ID', bookingId),
              _buildConfirmedRow('Mentor Name', mentorName),
              _buildConfirmedRow('Date', formattedDate),
              _buildConfirmedRow('Time', selectedTimeSlot),
              _buildConfirmedRow('Duration', durationString),
              _buildConfirmedRow('Google Meet Link', googleMeetLinkMessage),
              const SizedBox(height: 12),
              const Divider(color: AppColors.divider, height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount Paid',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${paidAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Bottom Action buttons
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.calendar_today_rounded, size: 15, color: AppColors.primary),
            label: const Text('Add to Calendar', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            onPressed: onAddToCalendar,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.download_rounded, size: 16, color: AppColors.primary),
            label: const Text('Download Receipt', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            onPressed: onDownloadReceipt,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              context.go(AppRoutes.home);
            },
            child: const Text('Back Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connecting to help desk support...')),
            );
          },
          child: const Text(
            'Need help? Contact Support',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6), decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
