import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/routes/approute.dart';

class SecondOpinionCard extends StatelessWidget {
  const SecondOpinionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDD6FE), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Left chat bubble icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFEDE9FE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF7C3AED), size: 20),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Second Opinion ✨',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Get personalized guidance from our expert mentors',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Ask Now outline button
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.consult),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF7C3AED), width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              minimumSize: const Size(0, 0),
            ),
            child: Row(
              children: const [
                Text(
                  'Ask Now',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7C3AED),
                  ),
                ),
                SizedBox(width: 3),
                Icon(Icons.arrow_forward_rounded, color: Color(0xFF7C3AED), size: 10),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Overlapping mentors stack
          SizedBox(
            width: 48,
            height: 28,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: _circleAvatar('https://randomuser.me/api/portraits/women/44.jpg'),
                ),
                Positioned(
                  left: 10,
                  child: _circleAvatar('https://randomuser.me/api/portraits/men/32.jpg'),
                ),
                Positioned(
                  left: 20,
                  child: _circleAvatar('https://randomuser.me/api/portraits/men/46.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleAvatar(String url) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: ClipOval(
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }
}
