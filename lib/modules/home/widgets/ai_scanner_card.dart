import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'answer_scanner.dart'; // To use UploadBottomSheet

class AiScannerCard extends StatelessWidget {
  final void Function(int index) onNavTap;

  const AiScannerCard({super.key, required this.onNavTap});

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => UploadBottomSheet(onUploadSuccess: () => onNavTap(2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Abstract background graphic on the right
            Positioned(
              right: -15,
              top: -15,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEEF2F6).withValues(alpha: 0.5),
                ),
              ),
            ),

            // Content padding
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AI Powered Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFFDE68A), width: 0.6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.bolt_rounded, color: Color(0xFFB45309), size: 11),
                              SizedBox(width: 3),
                              Text(
                                'AI POWERED',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFB45309),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Title
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              height: 1.25,
                            ),
                            children: [
                              TextSpan(text: "Scan Your Answer Sheet\n& Get "),
                              TextSpan(
                                text: "AI Analysis",
                                style: TextStyle(color: AppColors.goldDark),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Scan Button
                        GestureDetector(
                          onTap: () => _showUploadSheet(context),
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.gold, AppColors.goldLight],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.document_scanner_rounded, color: AppColors.primaryDark, size: 14),
                                SizedBox(width: 6),
                                Text(
                                  'Scan / Upload PDF',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11.5,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 12),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Footer text
                        Row(
                          children: const [
                            Icon(Icons.verified_user_outlined, size: 11, color: AppColors.textSecondary),
                            SizedBox(width: 4),
                            Text(
                              'Supports PDF only • Secure & Private',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 9,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right visual decoration - simulated answer sheet paper & magnifier
                  Expanded(
                    flex: 38,
                    child: SizedBox(
                      height: 130,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Leaf background shape
                          Positioned(
                            right: -10,
                            bottom: 5,
                            child: Icon(
                              Icons.spa_rounded,
                              size: 54,
                              color: const Color(0xFFA7F3D0).withValues(alpha: 0.35),
                            ),
                          ),

                          // The Answer Sheet Container
                          Positioned(
                            top: 10,
                            right: 0,
                            child: Container(
                              width: 80,
                              height: 110,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 8,
                                    offset: const Offset(3, 3),
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'ANSWER SHEET',
                                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 5.5, fontWeight: FontWeight.w900, color: AppColors.textSecondary),
                                    ),
                                  ),
                                  const Divider(height: 6, thickness: 0.5),
                                  _mockAnswerRow('1', true),
                                  _mockAnswerRow('2', false),
                                  _mockAnswerRow('3', true),
                                  _mockAnswerRow('4', false),
                                  _mockAnswerRow('5', true),
                                ],
                              ),
                            ),
                          ),

                          // The Magnifier glass decoration
                          Positioned(
                            top: 35,
                            left: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.9),
                                border: Border.all(color: const Color(0xFF94A3B8), width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.search_rounded, color: AppColors.gold, size: 18),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 68,
                            left: 28,
                            child: Transform.rotate(
                              angle: 0.78, // 45 degrees
                              child: Container(
                                width: 6,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF64748B),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _mockAnswerRow(String num, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text('$num.', style: const TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(width: 4),
          _mockCircle(active),
          const SizedBox(width: 2),
          _mockCircle(!active),
          const SizedBox(width: 2),
          _mockCircle(false),
        ],
      ),
    );
  }

  Widget _mockCircle(bool filled) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? const Color(0xFF7C3AED) : Colors.transparent,
        border: Border.all(color: filled ? const Color(0xFF7C3AED) : const Color(0xFFCBD5E1), width: 0.5),
      ),
    );
  }
}
