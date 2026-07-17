import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../model/session_type_model.dart';

class ConsultationSessionStep extends StatelessWidget {
  final int selectedSessionIndex;
  final List<SessionTypeModel> sessions;
  final ValueChanged<int> onSessionChanged;

  const ConsultationSessionStep({
    super.key,
    required this.selectedSessionIndex,
    required this.sessions,
    required this.onSessionChanged,
  });

  Widget _buildInclusionItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle_rounded, color: AppColors.gold, size: 13),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the type of session that suits you best.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),

        // Session List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final s = sessions[index];
            final isSelected = index == selectedSessionIndex;
            final isRecommended = index == 0;

            return GestureDetector(
              onTap: () => onSessionChanged(index),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: isSelected ? 1.5 : 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(s.icon, color: s.color, size: 20),
                    ),
                    const SizedBox(width: 12),

                    // Middle details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                s.title,
                                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                              ),
                              if (isRecommended) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.premiumBadge,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.premiumBorder, width: 0.5),
                                  ),
                                  child: const Text(
                                    'POPULAR',
                                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.goldMuted),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.subtitle,
                            style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, height: 1.3),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.videocam_rounded, color: AppColors.textSecondary, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                '60 mins Video call',
                                style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.stars_rounded, color: AppColors.gold, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                'Certified Mentor',
                                style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${s.price} /session',
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Right Radio indicator
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 5.5 : 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Inclusion details Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.chipSelected,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.premiumBorder.withValues(alpha: 0.5), width: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All sessions include:',
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: AppColors.goldMuted),
              ),
              const SizedBox(height: 8),
              _buildInclusionItem('Personalized Guidance'),
              const SizedBox(height: 6),
              _buildInclusionItem('Strategy Discussion'),
              const SizedBox(height: 6),
              _buildInclusionItem('Doubt Resolution'),
            ],
          ),
        ),
      ],
    );
  }
}
