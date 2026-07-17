import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../widgets/settings_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Dashboard',
            style: AppTextStyles.textPrimary22bold,
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: const Text(
                    'AJ',
                    style: AppTextStyles.white20bold,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Abhishek Jha',
                        style: AppTextStyles.textPrimary16bold,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Aspirant ID: IAS2027-391',
                        style: AppTextStyles.textSecondary11semibold,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Target Attempt: UPSC CSE 2027',
                        style: AppTextStyles.goldMuted8semibold.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.premiumBadge,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.premiumBorder, width: 0.5),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.goldDark,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium Membership Active',
                        style: AppTextStyles.textPrimary13bold,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Unlimited AI answers scanning and mock feedback.',
                        style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 10.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Settings & Help',
            style: AppTextStyles.textPrimary16bold,
          ),
          const SizedBox(height: 10),
          SettingsItem(
            icon: Icons.person_outline_rounded,
            label: 'Account Profile',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Account Profile...')),
              );
            },
          ),
          SettingsItem(
            icon: Icons.bookmark_outline_rounded,
            label: 'Saved Editorial Summaries',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Saved Editorials...')),
              );
            },
          ),
          SettingsItem(
            icon: Icons.history_edu_rounded,
            label: 'My Descriptive Tests',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Descriptive Tests...')),
              );
            },
          ),
          SettingsItem(
            icon: Icons.support_agent_rounded,
            label: 'Help & Live Support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Help Support...')),
              );
            },
          ),
          SettingsItem(
            icon: Icons.logout_rounded,
            label: 'Sign Out',
            isDestructive: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signing Out...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
