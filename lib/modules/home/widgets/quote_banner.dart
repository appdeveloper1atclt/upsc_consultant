import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';

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
          Container(height: 92, color: AppColors.primaryDark.withOpacity(.45)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '"Discipline Today, Freedom Tomorrow."',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 4),
                Text('Your Dream. Our Guidance. Your Success.', style: TextStyle(fontSize: 10, color: Color(0xE6FFFFFF))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
