import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';

class ConsultationDetailsStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController noteController;
  final String selectedAttempt;
  final String selectedStage;
  final String selectedLanguage;
  final String selectedReason;
  final List<String> reasons;
  final ValueChanged<String> onAttemptChanged;
  final ValueChanged<String> onStageChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onReasonChanged;

  const ConsultationDetailsStep({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.noteController,
    required this.selectedAttempt,
    required this.selectedStage,
    required this.selectedLanguage,
    required this.selectedReason,
    required this.reasons,
    required this.onAttemptChanged,
    required this.onStageChanged,
    required this.onLanguageChanged,
    required this.onReasonChanged,
  });

  InputDecoration _getInputFieldDecoration({
    required String hint,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 13),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: AppColors.textSecondary, size: 18)
          : null,
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border, width: 0.8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 0.8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSelectionChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 38,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 0.8,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 13),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fill in your details so our mentor can understand your needs better.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 18),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Text Field
              _buildInputLabel('Full Name *'),
              TextFormField(
                controller: nameController,
                style: AppTextStyles.labelLarge,
                decoration: _getInputFieldDecoration(
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline_rounded,
                ),
              ),
              const SizedBox(height: 16),

              // Mobile Number Text Field
              _buildInputLabel('Mobile Number *'),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: AppTextStyles.labelLarge,
                decoration: _getInputFieldDecoration(
                  hint: 'Enter your mobile number',
                  prefixIcon: Icons.phone_iphone_rounded,
                ).copyWith(
                  prefixText: '+91 ',
                  prefixStyle: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // UPSC Attempt Selection
              _buildInputLabel('UPSC Attempt *'),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'First Attempt',
                      isSelected: selectedAttempt == 'First Attempt',
                      onTap: () => onAttemptChanged('First Attempt'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Repeat Aspirant',
                      isSelected: selectedAttempt == 'Repeat Aspirant',
                      onTap: () => onAttemptChanged('Repeat Aspirant'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Current Stage Selection
              _buildInputLabel('Current Stage *'),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Prelims',
                      isSelected: selectedStage == 'Prelims',
                      onTap: () => onStageChanged('Prelims'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Mains',
                      isSelected: selectedStage == 'Mains',
                      onTap: () => onStageChanged('Mains'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Interview',
                      isSelected: selectedStage == 'Interview',
                      onTap: () => onStageChanged('Interview'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Preferred Language Selection
              _buildInputLabel('Preferred Language *'),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'English',
                      isSelected: selectedLanguage == 'English',
                      onTap: () => onLanguageChanged('English'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Hindi',
                      isSelected: selectedLanguage == 'Hindi',
                      onTap: () => onLanguageChanged('Hindi'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSelectionChip(
                      label: 'Hinglish',
                      isSelected: selectedLanguage == 'Hinglish',
                      onTap: () => onLanguageChanged('Hinglish'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Reason for Consultation Dropdown
              _buildInputLabel('Reason for Consultation *'),
              DropdownButtonFormField<String>(
                initialValue: selectedReason,
                style: AppTextStyles.labelLarge,
                decoration: _getInputFieldDecoration(
                  hint: 'Select reason',
                  prefixIcon: Icons.help_outline_rounded,
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                items: reasons.map((String reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(
                      reason,
                      style: TextStyle(
                        color: reason == 'Select reason' ? AppColors.textHint : AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    onReasonChanged(val);
                  }
                },
              ),
              const SizedBox(height: 16),

              // Multiline tell us more
              _buildInputLabel('Tell us more (Optional)'),
              TextFormField(
                controller: noteController,
                maxLines: 3,
                maxLength: 300,
                style: AppTextStyles.labelLarge,
                decoration: _getInputFieldDecoration(
                  hint: 'Write your query or concern in detail...',
                  prefixIcon: Icons.chat_bubble_outline_rounded,
                ).copyWith(
                  counterStyle: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
