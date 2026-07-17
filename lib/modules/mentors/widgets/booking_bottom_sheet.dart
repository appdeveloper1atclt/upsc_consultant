import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/modules/home/widgets/top_mentors_section.dart';
import 'slot_chip.dart';
import '../view/payment_screen.dart';
import '../../../core/widgets/shimmer_placeholder.dart';

class BookingBottomSheet extends StatefulWidget {
  final MentorData mentor;

  const BookingBottomSheet({super.key, required this.mentor});

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  int _selectedSlotIndex = 0;

  final List<String> _slots = [
    "Today, 4:00 PM",
    "Tomorrow, 11:00 AM",
    "18th July, 2:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle for modal
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
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
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                    Text(
                      widget.mentor.expertise,
                      style: AppTextStyles.cardSubtitle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1),
          const Text(
            "Choose Session Slot",
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
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price per session", style: AppTextStyles.labelMedium),
                  Text(
                    "₹${widget.mentor.price}",
                    style: AppTextStyles.price.copyWith(fontSize: 20),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        mentor: widget.mentor,
                        selectedSlot: _slots[_selectedSlotIndex],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(140, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
