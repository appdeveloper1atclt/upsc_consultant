import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_consultant/core/routes/approute.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1B4B).withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          // Crown Illustration / Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events_rounded, color: Color(0xFFFBBF24), size: 28),
          ),
          const SizedBox(width: 14),

          // Main text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Go Premium. Unlock Unlimited Possibilities!',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Unlimited AI Evaluation, Mentor Review,\nMock Tests & more.',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 9.5,
                    color: Color(0xFFC7D2FE),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // White explore plans CTA button
          ElevatedButton(
            onPressed: () {
              context.push(AppRoutes.upgrade);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF312E81),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(0, 0),
            ),
            child: Row(
              children: const [
                Text(
                  'Explore Plans',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
