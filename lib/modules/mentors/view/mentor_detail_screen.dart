import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/core/routes/approute.dart';
import 'package:upsc_consultant/modules/home/widgets/top_mentors_section.dart';
import '../widgets/slot_chip.dart';
import '../../../core/widgets/shimmer_placeholder.dart';

class MentorDetailScreen extends StatefulWidget {
  final MentorData mentor;

  const MentorDetailScreen({super.key, required this.mentor});

  @override
  State<MentorDetailScreen> createState() => _MentorDetailScreenState();
}

class _MentorDetailScreenState extends State<MentorDetailScreen> {
  int _selectedSlotIndex = 0;

  final List<String> _slots = [
    "Today, 4:00 PM",
    "Tomorrow, 11:00 AM",
    "18th July, 2:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
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
          "Mentor Profile",
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
                // Profile Header Card
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(
                          imageUrl: widget.mentor.photoUrl,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const ShimmerPlaceholder.circle(size: 110),
                          errorWidget: (context, url, error) => Container(width: 110, height: 110, color: AppColors.chipBackground),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.mentor.name,
                            style: AppTextStyles.pageTitle.copyWith(fontSize: 22),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.verified_rounded, size: 20, color: Color(0xFF378ADD)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.mentor.expertise,
                        style: AppTextStyles.designation.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.goldMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded, size: 18, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text(
                            "${widget.mentor.rating} (Verified)",
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
                          ),
                          const SizedBox(width: 12),
                          Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppColors.textSecondary, shape: BoxShape.circle)),
                          const SizedBox(width: 12),
                          Text(
                            widget.mentor.studentsLabel,
                            style: AppTextStyles.caption.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Experience / About
                const Text(
                  "About Mentor",
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  "A distinguished UPSC expert specializing in ${widget.mentor.expertise}. With years of experience guiding top rankers, their strategy sessions focus on core concept building, daily answer evaluation guidelines, and time management skills for UPSC Mains.",
                  style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
                ),
                const SizedBox(height: 24),

                // Pricing Info card
                const Text(
                  "Fee Details",
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.payments_outlined, color: AppColors.goldMuted, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Personal 1-on-1 Session",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
                            ),
                            Text(
                              "45 minutes of detailed strategic roadmap call",
                              style: AppTextStyles.caption.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "₹${widget.mentor.price}",
                        style: AppTextStyles.price.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Choose Slot
                const Text(
                  "Select Available Slot",
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_slots.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SlotChip(
                          label: _slots[index],
                          isSelected: _selectedSlotIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedSlotIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 100), // spacer for sticky bottom button
              ],
            ),
          ),
          // Sticky Bottom Checkout CTA
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.card,
                border: Border(top: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans'),
                        ),
                        Text(
                          "₹${(widget.mentor.price * 1.18).round()}",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.goldMuted, fontFamily: 'PlusJakartaSans'),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to PaymentScreen via GoRouter
                          context.push(
                            AppRoutes.payment,
                            extra: {
                              'mentor': widget.mentor,
                              'slot': _slots[_selectedSlotIndex],
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Proceed to Payment",
                          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'PlusJakartaSans'),
                        ),
                      ),
                    ),
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
