import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_image.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../daily_challenge/provider/pt_challenge_controller.dart';

class ProfileScreen extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const ProfileScreen({super.key, this.onTabChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  // Local editor fields, initialized in didChangeDependencies
  bool _initialized = false;
  late String _userName;
  late String _targetExam;
  late String _targetYear;
  late double _studyHours;

  late TextEditingController _nameController;

  final List<String> _examsList = ['UPSC CSE', 'State PSC', 'CAPF', 'CDS', 'Other'];
  final List<String> _yearsList = ['2026', '2027', '2028'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final controller = context.read<PtChallengeController>();
      _userName = controller.userName;
      _targetExam = controller.targetExam;
      _targetYear = controller.targetAttempt;
      _studyHours = controller.studyHours;
      _nameController = TextEditingController(text: _userName);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showSnack(String message, {IconData icon = Icons.info_rounded, Color color = AppColors.primary}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24), boxShadow: AppShadows.card),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 32),
                ),
                const SizedBox(height: 18),
                const Text('Sign Out', style: AppTextStyles.textPrimary18bold),
                const SizedBox(height: 8),
                const Text('Are you sure you want to sign out?', textAlign: TextAlign.center, style: AppTextStyles.textSecondary12medium),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSnack('Successfully signed out.', icon: Icons.check_circle_rounded, color: AppColors.textPrimary);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().scale(duration: 250.ms, curve: Curves.easeOutBack, begin: const Offset(0.85, 0.85));
      },
    );
  }

  void _showSavedEditorialSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.scaffold,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Saved Bookmarks', style: AppTextStyles.textPrimary16bold),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                  const Divider(color: AppColors.divider),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final editorials = [
                          'Socio-Economic Development Challenges in North-East India',
                          'Digital Personal Data Protection Act: Implementation Gaps',
                          'Reform of Multilateral Institutions (IMF & World Bank) & G20',
                          'Indo-Pacific Strategic Dynamics and Maritime Security Goals',
                        ];
                        final dates = ['Saved on July 14, 2026', 'Saved on July 12, 2026', 'Saved on July 08, 2026', 'Saved on June 30, 2026'];
                        return Card(
                          color: AppColors.card,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: AppColors.border, width: 0.5),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(color: AppColors.premiumBadge, shape: BoxShape.circle),
                              child: const Icon(Icons.bookmark_added_rounded, color: AppColors.gold, size: 18),
                            ),
                            title: Text(editorials[index], style: AppTextStyles.textPrimary12semibold),
                            subtitle: Text(dates[index], style: AppTextStyles.textSecondary8normal),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 18),
                              onPressed: () => _showSnack('Removed from saved list.'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showTestsListSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.scaffold,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('My Descriptive Mock Scores', style: AppTextStyles.textPrimary16bold),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                  const Divider(color: AppColors.divider),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: 3,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final subjects = [
                          'GS Paper II: Welfare Schemes for Vulnerable Sections',
                          'GS Paper III: Fiscal Consolidation and Inflation Control',
                          'GS Essay Paper: Tech Innovations vs Ethical Dilemmas',
                        ];
                        final scores = ['84/150 (56%)', '76/150 (50.6%)', '118/250 (47.2%)'];
                        final grades = ['Good', 'Needs Focus', 'Excellent'];
                        final colors = [AppColors.success, AppColors.warning, AppColors.success];

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border, width: 0.5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(subjects[index], style: AppTextStyles.textPrimary12semibold),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(color: colors[index].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                                          child: Text(
                                            grades[index],
                                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: colors[index]),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('Evaluated by IAS Mentor', style: AppTextStyles.textSecondary8semibold),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Score Obtained', style: AppTextStyles.textSecondary8normal),
                                  const SizedBox(height: 2),
                                  Text(
                                    scores[index],
                                    style: AppTextStyles.textPrimary12semibold.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PtChallengeController>();

    return ColoredBox(
      color: const Color(0xFFF9FAFC),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(controller),
            const SizedBox(height: 14),
            _buildStatsGrid(controller),
            const SizedBox(height: 16),
            _buildPremiumBanner(),
            const SizedBox(height: 20),
            _buildUpcomingConsultation(),
            const SizedBox(height: 20),
            _buildPerformanceMetrics(controller),
            const SizedBox(height: 20),
            _buildConsultationHistory(),
            const SizedBox(height: 24),
            if (_isEditing) ...[_buildTargetGoalsCard(controller), const SizedBox(height: 24)],
            const Text('Quick Access', style: AppTextStyles.textPrimary16bold),
            const SizedBox(height: 10),
            _buildSettingsList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(PtChallengeController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(color: Color(0xFF0F1E36), shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    'AJ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt_rounded, color: AppColors.textSecondary, size: 12),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.userName, style: AppTextStyles.textPrimary16bold.copyWith(fontSize: 17)),
                const SizedBox(height: 2),
                const Text('Aspirant ID: IAS2027-391', style: AppTextStyles.textSecondary11semibold),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.stars_rounded, color: AppColors.gold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Target: ${controller.targetExam} ${controller.targetAttempt}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.goldDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _userName = _nameController.text.trim();
                  controller.updateJourney(name: _userName, exam: _targetExam, attempt: _targetYear, hours: _studyHours);
                  _showSnack('Profile goals saved successfully!', icon: Icons.check_circle_rounded, color: AppColors.success);
                }
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(_isEditing ? Icons.save_rounded : Icons.edit_note_rounded, size: 14),
            label: Text(_isEditing ? 'Save' : 'Edit Profile', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(60, 32),
              foregroundColor: AppColors.goldDark,
              side: const BorderSide(color: AppColors.premiumBorder),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: AppColors.premiumBadge.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(PtChallengeController controller) {
    return Row(
      children: [
        _buildMiniBadge(Icons.book_outlined, 'Stage', 'Prelims + Mains', Colors.deepPurple, const Color(0xFFF3F0FF)),
        const SizedBox(width: 8),
        _buildMiniBadge(Icons.public_rounded, 'Optional', 'Geography', Colors.teal, const Color(0xFFE6FFFA)),
        const SizedBox(width: 8),
        _buildMiniBadge(Icons.access_time_rounded, 'Study Goal', '${controller.studyHours.toInt()}-8 Hours/Day', Colors.blue, const Color(0xFFEBF8FF)),
        const SizedBox(width: 8),
        _buildMiniBadge(Icons.g_translate_rounded, 'Language', 'English', Colors.orange, const Color(0xFFFFFAF0)),
      ],
    );
  }

  Widget _buildMiniBadge(IconData icon, String label, String value, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEDF2F7), width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 12),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            AutoSizeText(
              value,
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              maxLines: 1,
              minFontSize: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFEEBC8), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFFFEF3C7), shape: BoxShape.circle),
            child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD97706), size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Membership Active',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF92400E)),
                ),
                SizedBox(height: 2),
                Text('Enjoy unlimited access to all premium features.', style: TextStyle(fontSize: 11, color: Color(0xFFB45309))),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFD97706), size: 14),
        ],
      ),
    );
  }

  Widget _buildUpcomingConsultation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Upcoming Consultation', style: AppTextStyles.textPrimary16bold),
            TextButton(
              onPressed: () => widget.onTabChanged?.call(1),
              child: const Text(
                'View All',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 10)],
            border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(14)),
                child: Image.asset(AppImage.calenderImg, color: const Color(0xFFEA580C), width: 24, height: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        'One to One Session',
                        style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'With Dr. Raj Sharma',
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(AppImage.calenderImg, width: 12, height: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        const Text(
                          'Wed, 15 May 2026',
                          style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 12, color: AppColors.textSecondary),
                        SizedBox(width: 6),
                        Text(
                          '05:00 PM - 06:00 PM',
                          style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.videocam_rounded, size: 12, color: AppColors.textSecondary),
                        SizedBox(width: 6),
                        Text(
                          'Online (Google Meet)',
                          style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEDF2F7), width: 1.5),
                    ),
                    child: const CircleAvatar(radius: 26, backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/46.jpg')),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert Mentor',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textSecondary, size: 14),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(PtChallengeController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your Performance', style: AppTextStyles.textPrimary16bold),
            TextButton(
              onPressed: () => _showSnack('Opening performance report...'),
              child: const Text(
                'View Report',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildCircularProgress('Tests Attempted', '24', '/ 50', 24 / 50, Colors.blue),
            const SizedBox(width: 10),
            _buildCircularProgress('Avg. Accuracy', '72%', '↑ 8%', 0.72, AppColors.success),
            const SizedBox(width: 10),
            _buildCircularProgress('Answer Writing', '68%', '↑ 6%', 0.68, Colors.deepPurple),
            const SizedBox(width: 10),
            _buildCircularProgress('Current Streak', '${controller.currentStreak}', 'Days', 1.0, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularProgress(String label, String value, String subtext, double pct, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEDF2F7), width: 0.8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: pct,
                    strokeWidth: 4.5,
                    backgroundColor: color.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    if (subtext.isNotEmpty) ...[
                      Text(
                        subtext,
                        style: TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                          color: subtext.startsWith('↑') ? AppColors.success : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultationHistory() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Consultation History', style: AppTextStyles.textPrimary16bold),
            TextButton(
              onPressed: () => _showSnack('Showing full consultation history...'),
              child: const Text(
                'View All',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
          ),
          child: Column(
            children: [
              _buildHistoryRow(
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: Colors.teal,
                iconBg: const Color(0xFFE6FFFA),
                title: 'Session with Dr. Meera Singh',
                dateTime: 'Sun, 05 May 2026  |  06:00 PM - 07:00 PM',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: AppColors.divider, height: 1),
              ),
              _buildHistoryRow(
                icon: AppImage.calenderImg,
                iconColor: Colors.deepPurple,
                iconBg: const Color(0xFFF3F0FF),
                title: 'Session with Prof. Arvind Kumar',
                dateTime: 'Tue, 23 Apr 2026  |  05:00 PM - 06:00 PM',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow({required dynamic icon, required Color iconColor, required Color iconBg, required String title, required String dateTime}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: icon is String
              ? Image.asset(icon, color: iconColor, width: 18, height: 18)
              : Icon(icon as IconData, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFDEF7EC), borderRadius: BorderRadius.circular(4)),
                    child: const Text(
                      'Completed',
                      style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                dateTime,
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textSecondary, size: 12),
      ],
    );
  }

  Widget _buildTargetGoalsCard(PtChallengeController controller) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold, width: 1.0),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.flag_rounded, color: AppColors.goldDark, size: 15),
                  ),
                  const SizedBox(width: 8),
                  const Text('Edit Target & Goals', style: AppTextStyles.textPrimary14semibold),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(child: Text('Student Name:', style: AppTextStyles.textSecondary12medium)),
              SizedBox(
                width: 140,
                child: TextField(
                  controller: _nameController,
                  style: AppTextStyles.textPrimary12semibold,
                  decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 4)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Text('Target Examination:', style: AppTextStyles.textSecondary12medium)),
              DropdownButton<String>(
                value: _targetExam,
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.gold),
                underline: Container(height: 1.5, color: AppColors.gold),
                style: AppTextStyles.textPrimary12semibold.copyWith(color: AppColors.goldDark),
                onChanged: (val) {
                  if (val != null) setState(() => _targetExam = val);
                },
                items: _examsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Text('UPSC Attempt Year:', style: AppTextStyles.textSecondary12medium)),
              DropdownButton<String>(
                value: _targetYear,
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.gold),
                underline: Container(height: 1.5, color: AppColors.gold),
                style: AppTextStyles.textPrimary12semibold.copyWith(color: AppColors.goldDark),
                onChanged: (val) {
                  if (val != null) setState(() => _targetYear = val);
                },
                items: _yearsList.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Daily Study Commitment: ${_studyHours.toInt()} Hours', style: AppTextStyles.textSecondary12medium),
              Slider(
                value: _studyHours,
                min: 1.0,
                max: 8.0,
                divisions: 7,
                activeColor: AppColors.gold,
                inactiveColor: AppColors.chipBackground,
                onChanged: (val) => setState(() => _studyHours = val),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF2F7), width: 1),
      ),
      child: Column(
        children: [
          _buildLocalSettingsItem(icon: Icons.assignment_outlined, label: 'My Tests', onTap: _showTestsListSheet),
          _itemDivider(),
          _buildLocalSettingsItem(icon: Icons.edit_document, label: 'Answer Writing', onTap: () => widget.onTabChanged?.call(2)),
          _itemDivider(),
          _buildLocalSettingsItem(icon: Icons.bookmark_outline_rounded, label: 'Bookmarks', onTap: _showSavedEditorialSheet),
          _itemDivider(),
          _buildLocalSettingsItem(
            icon: Icons.file_download_outlined,
            label: 'Downloads',
            onTap: () => _showSnack('Checking local downloads...', icon: Icons.download_rounded, color: AppColors.success),
          ),
          _itemDivider(),
          _buildLocalSettingsItem(
            icon: Icons.support_agent_rounded,
            label: 'Help & Support',
            onTap: () => _showSnack('Connecting with a support mentor...', icon: Icons.support_agent_rounded, color: AppColors.primary),
          ),
          _itemDivider(),
          _buildLocalSettingsItem(icon: Icons.logout_rounded, label: 'Sign Out', isDestructive: true, onTap: _showLogoutDialog),
        ],
      ),
    );
  }

  Widget _buildLocalSettingsItem({required IconData icon, required String label, required VoidCallback onTap, bool isDestructive = false}) {
    final Color accent = isDestructive ? AppColors.error : AppColors.goldDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              Icon(Icons.chevron_right_rounded, color: isDestructive ? AppColors.error.withValues(alpha: 0.6) : AppColors.textHint, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(color: AppColors.divider, height: 1),
    );
  }
}
