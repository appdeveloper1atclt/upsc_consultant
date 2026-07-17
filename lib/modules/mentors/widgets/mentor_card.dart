import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/modules/home/widgets/top_mentors_section.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/routes/approute.dart';

class MentorCard extends StatelessWidget {
  final MentorData mentor;
  final VoidCallback onBookTap;

  const MentorCard({super.key, required this.mentor, required this.onBookTap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar & Details (Tappable area)
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.push(AppRoutes.mentorDetail, extra: mentor);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar & Rating
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: CachedNetworkImage(
                          imageUrl: mentor.photoUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(width: 56, height: 56, color: AppColors.chipBackground),
                          errorWidget: (context, url, error) => Container(width: 56, height: 56, color: AppColors.chipBackground),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                          const SizedBox(width: 2),
                          Text(
                            "${mentor.rating}",
                            style: AppTextStyles.labelLarge.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                mentor.name,
                                style: AppTextStyles.mentorName.copyWith(fontSize: 15),
                              ),
                            ),
                            const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF378ADD)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          mentor.expertise,
                          style: AppTextStyles.designation.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mentor.studentsLabel,
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "₹${mentor.price} / session",
                          style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Action Button on the right
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 38), // Align with price row
              TextButton(
                onPressed: onBookTap,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: AppColors.gold.withValues(alpha: 0.12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Book",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.goldMuted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
