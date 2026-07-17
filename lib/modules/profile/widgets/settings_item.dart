import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  /// Optional small trailing badge text, e.g. "1" for a notification count
  /// or "New" for a freshly-added feature. Purely cosmetic — omit for a
  /// plain chevron-only row.
  final String? badgeText;

  const SettingsItem({super.key, required this.icon, required this.label, required this.onTap, this.isDestructive = false, this.badgeText});

  @override
  Widget build(BuildContext context) {
    final Color accent = isDestructive ? AppColors.error : AppColors.goldDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: isDestructive ? AppColors.error.withValues(alpha: 0.15) : AppColors.divider, width: 0.6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(color: accent.withValues(alpha: 0.10), shape: BoxShape.circle),
                  child: Icon(icon, color: accent, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: isDestructive
                        ? AppTextStyles.textPrimary14semibold.copyWith(color: AppColors.error, fontSize: 13.5)
                        : AppTextStyles.textPrimary14semibold.copyWith(fontSize: 13.5),
                  ),
                ),
                if (badgeText != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(color: AppColors.premiumBadge, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.goldDark),
                    ),
                  ),
                ],
                Icon(Icons.chevron_right_rounded, color: isDestructive ? AppColors.error.withValues(alpha: 0.6) : AppColors.textHint, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
