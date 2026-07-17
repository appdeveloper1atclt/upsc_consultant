import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class ConsultationStepper extends StatelessWidget {
  final int currentStep;
  const ConsultationStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final int stepsCount = 4;
    final List<String> stepLabels = ['Details', 'Slot', 'Session', 'Payment'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.divider.withValues(alpha: 0.5), width: 0.8)),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(stepsCount, (index) {
              final isCompleted = index < currentStep;
              final isActive = index == currentStep;

              return Expanded(
                child: Row(
                  children: [
                    // Step Dot
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.primary
                            : (isActive ? AppColors.gold : AppColors.surface),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? AppColors.goldDark : AppColors.border,
                          width: isActive ? 1.5 : 1,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 13)
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: isActive
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                      ),
                    ),
                    // Connector Line
                    if (index < stepsCount - 1)
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: isCompleted ? AppColors.primary : AppColors.divider,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          // Labels Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(stepsCount, (index) {
              final isActive = index == currentStep;
              final isCompleted = index < currentStep;
              return Expanded(
                child: Text(
                  stepLabels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: (isActive || isCompleted) ? FontWeight.w900 : FontWeight.bold,
                    color: isActive 
                        ? AppColors.goldMuted 
                        : (isCompleted ? AppColors.textPrimary : AppColors.textSecondary),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
