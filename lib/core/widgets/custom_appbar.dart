import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Padding(padding: const EdgeInsets.all(10), child: Image.asset(AppImage.appLogo)),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, Aspirant 👋", style: AppTextStyles.textSecondary15normal),
                  const SizedBox(height: 2),
                  Text(
                    "Keep Learning, Keep Growing",
                    style: AppTextStyles.textPrimary18bold,
                  ),
                ],
              ),
            ),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 18, offset: const Offset(0, 8))],
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.notifications_none_rounded, color: AppColors.primary)),
                  Positioned(
                    right: 14,
                    top: 14,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
