import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class MainsSubmit extends StatelessWidget {
  final String paperTitle;

  const MainsSubmit({super.key, required this.paperTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Circular icon decoration
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F3FF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF7C3AED),
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title and messaging
              const Text(
                'Submission Successful! 🎉',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your answer script has been uploaded and queued for evaluation.',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13.5, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'A senior IAS mentor will review your structure, content, and language to provide details, score, and model answers within 24 hours.',
                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondary, height: 1.45),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Done CTA
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Pop back to Mains home
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back to Mains Home', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
