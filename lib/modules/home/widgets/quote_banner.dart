import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

class QuoteBanner extends StatelessWidget {
  const QuoteBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          CachedNetworkImage(
            // Swap for your own mountain/flag illustration asset when ready.
            imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=500&q=60',
            height: 92,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(height: 92, color: AppColors.primaryDark.withValues(alpha: 0.45)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"Discipline Today, Freedom Tomorrow."',
                  style: AppTextStyles.white14bold.copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 4),
                Text('Your Dream. Our Guidance. Your Success.', style: AppTextStyles.white10normal.copyWith(color: const Color(0xE6FFFFFF))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
