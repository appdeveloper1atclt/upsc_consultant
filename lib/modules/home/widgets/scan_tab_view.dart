import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import 'answer_scanner.dart';
import 'scanner_inttulation.dart';

class ScanTabView extends StatelessWidget {
  const ScanTabView({super.key});

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => const UploadBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    final evaluations = [
      (title: 'GS Paper III Mock: Economic Development', status: 'Evaluation Completed', score: '84/150', date: 'July 10, 2026', color: AppColors.success),
      (
        title: 'GS Paper I: Indian Heritage and Culture',
        status: 'In Evaluation (24h remaining)',
        score: 'Pending',
        date: 'July 14, 2026',
        color: AppColors.warning,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Answer Sheet Evaluator',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text('Scan your answers and get expert evaluation within 24 hours.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20), boxShadow: AppShadows.card),
            child: Column(
              children: [
                // ── Premium animated scanner illustration ──────────────
                const AnimatedScannerIllustration(),
                const SizedBox(height: 16),
                const Text(
                  'Upload Answer PDF / Images',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.2),
                ),
                const SizedBox(height: 4),
                const Text('Supports PDF, JPG, PNG · Max 15 MB', style: TextStyle(fontSize: 11, color: Colors.white60)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _showUploadSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.upload_file_rounded, size: 18),
                  label: const Text('Choose File', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Submissions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: evaluations.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final eval = evaluations[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: AppShadows.card),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: AppColors.premiumBadge, shape: BoxShape.circle),
                      child: const Icon(Icons.description_outlined, color: AppColors.goldMuted, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eval.title,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  eval.date,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 10, color: AppColors.textHint),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(color: AppColors.textHint, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  eval.status,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: eval.color),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Score', style: TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                        Text(
                          eval.score,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
