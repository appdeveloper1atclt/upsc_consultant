import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/widgets/shimmer_placeholder.dart';
import '../../daily_challenge/provider/pt_challenge_controller.dart';
import '../widgets/settings_item.dart';

class ProfileScreen extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const ProfileScreen({super.key, this.onTabChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  bool _isLoadingPhoto = false;

  // Profile data
  String _userName = 'Abhishek Jha';
  String _targetYear = '2027';
  String _selectedStage = 'Mains'; // Prelims, Mains, Interview
  String _optionalSubject = 'PSIR'; // PSIR, Geography, History, Sociology, Public Administration
  String _examMedium = 'English'; // English, Hindi
  String _photoUrl = 'https://randomuser.me/api/portraits/men/22.jpg';

  // Next scheduled mentor session — surfaced prominently since booking a
  // slot and reaching a mentor are the two core things a student needs
  // fast access to from their profile.
  final String _nextMentorName = 'Dr. Tanvi Sharma';
  final String _nextMentorTopic = 'Syllabus & Optional Prep';
  final String _nextMentorSlot = 'Tomorrow, 5:00 PM';

  final List<String> _stagesList = ['Prelims', 'Mains', 'Interview'];
  final List<String> _yearsList = ['2025', '2026', '2027', '2028', '2029'];
  final List<String> _optionalsList = ['PSIR', 'Geography', 'History', 'Sociology', 'Public Administration', 'Philosophy', 'Anthropology'];
  final List<String> _mediumList = ['English', 'Hindi'];

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _simulatePhotoChange(String newUrl) {
    setState(() {
      _isLoadingPhoto = true;
    });

    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _photoUrl = newUrl;
          _isLoadingPhoto = false;
        });
        _showSnack('Profile picture updated successfully!', icon: Icons.check_circle_rounded, color: AppColors.success);
      }
    });
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

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Profile Picture', style: AppTextStyles.textPrimary16bold),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, size: 20)),
                ],
              ),
              const SizedBox(height: 18),
              const Text('Choose a simulated avatar below to see the shimmer loading and profile updates:', style: AppTextStyles.textSecondary12medium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _avatarChoice('https://randomuser.me/api/portraits/men/22.jpg', 'Avatar 1'),
                  _avatarChoice('https://randomuser.me/api/portraits/women/33.jpg', 'Avatar 2'),
                  _avatarChoice('https://randomuser.me/api/portraits/men/86.jpg', 'Avatar 3'),
                  _avatarChoice('https://randomuser.me/api/portraits/women/44.jpg', 'Avatar 4'),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _simulatePhotoChange('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                  label: const Text('Simulate Custom Upload', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _avatarChoice(String url, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _simulatePhotoChange(url);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: CircleAvatar(radius: 28, backgroundImage: NetworkImage(url)),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.textSecondary8semibold),
        ],
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
                const Text(
                  'Are you sure you want to sign out? Your descriptive feedback data will remain saved on our cloud servers.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textSecondary12medium,
                ),
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
          ).animate().scale(duration: 250.ms, curve: Curves.easeOutBack, begin: const Offset(0.85, 0.85)),
        );
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
                      const Text('Saved Editorial Summaries', style: AppTextStyles.textPrimary16bold),
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

  void _showScheduledBookingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Scheduled Bookings', style: AppTextStyles.textPrimary16bold),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.selectedCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.premiumBorder, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(color: AppColors.premiumBadge, shape: BoxShape.circle),
                          child: const Icon(Icons.calendar_today_rounded, color: AppColors.gold, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Session with $_nextMentorName', style: AppTextStyles.textPrimary13bold),
                              const SizedBox(height: 2),
                              Text('$_nextMentorTopic · 1 to 1 Session', style: AppTextStyles.textSecondary11semibold),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, color: AppColors.goldMuted, size: 12),
                                  const SizedBox(width: 4),
                                  Text('$_nextMentorSlot (30 min)', style: AppTextStyles.goldMuted8semibold.copyWith(fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showSnack('Opening chat with $_nextMentorName...', icon: Icons.chat_bubble_rounded, color: AppColors.primary);
                            },
                            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                            label: const Text('Chat'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showSnack('Joining call with $_nextMentorName...', icon: Icons.videocam_rounded, color: AppColors.success);
                            },
                            icon: const Icon(Icons.videocam_rounded, size: 16),
                            label: const Text('Join Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onTabChanged?.call(1);
                  },
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Book Another Slot', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.gold),
                    foregroundColor: AppColors.goldDark,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final challengeController = context.watch<PtChallengeController>();
    final streakDays = challengeController.currentStreak;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGradientHeader(),
            Transform.translate(
              offset: const Offset(0, -36),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: _buildProfileCard()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  _buildMembershipCard(),
                  const SizedBox(height: 16),
                  _buildNextSessionCard(),
                  const SizedBox(height: 20),

                  const Text('Quick Actions', style: AppTextStyles.textPrimary16bold),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _shortcutButton(
                        icon: Icons.calendar_month_rounded,
                        label: 'Book Mentor',
                        color: AppColors.primary,
                        onTap: () => widget.onTabChanged?.call(1),
                      ),
                      const SizedBox(width: 10),
                      _shortcutButton(
                        icon: Icons.chat_bubble_rounded,
                        label: 'Chat Mentor',
                        color: AppColors.success,
                        onTap: () => widget.onTabChanged?.call(1),
                      ),
                      const SizedBox(width: 10),
                      _shortcutButton(
                        icon: Icons.document_scanner_rounded,
                        label: 'Scan Answers',
                        color: AppColors.goldDark,
                        onTap: () => widget.onTabChanged?.call(2),
                      ),
                      const SizedBox(width: 10),
                      _shortcutButton(icon: Icons.quiz_rounded, label: 'All Mocks', color: AppColors.primaryLight, onTap: () => widget.onTabChanged?.call(3)),
                    ],
                  ).animate().fade(delay: 150.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 20),

                  const Text('Aspirant Performance Metrics', style: AppTextStyles.textPrimary16bold),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _statCard(
                        icon: Icons.local_fire_department_rounded,
                        value: '$streakDays Days',
                        label: 'PT Quiz Streak',
                        color: Colors.orange[800]!,
                        bg: Colors.orange[50]!,
                      ),
                      _statCard(
                        icon: Icons.query_stats_rounded,
                        value: '84%',
                        label: 'Prelims Accuracy',
                        color: AppColors.success,
                        bg: AppColors.success.withValues(alpha: 0.08),
                      ),
                      _statCard(
                        icon: Icons.fact_check_rounded,
                        value: '8 Submitted',
                        label: 'Mains Evaluations',
                        color: AppColors.goldMuted,
                        bg: AppColors.premiumBadge,
                      ),
                      _statCard(
                        icon: Icons.schedule_send_rounded,
                        value: '3 Done (1 Upcoming)',
                        label: 'Mentor Sessions',
                        color: AppColors.primary,
                        bg: AppColors.chipBackground,
                      ),
                    ],
                  ).animate().fade(delay: 200.ms, duration: 450.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 20),

                  _buildTargetGoalsCard(),
                  const SizedBox(height: 20),

                  _buildCountdownCard(),
                  const SizedBox(height: 24),

                  const Text('Settings & Help Support', style: AppTextStyles.textPrimary16bold),
                  const SizedBox(height: 10),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SettingsItem(icon: Icons.person_outline_rounded, label: 'Account Profile', onTap: () => setState(() => _isEditing = !_isEditing)),
                      SettingsItem(icon: Icons.calendar_today_outlined, label: 'My Booked Slots Calendar', badgeText: '1', onTap: _showScheduledBookingsSheet),
                      SettingsItem(icon: Icons.bookmark_outline_rounded, label: 'Saved Editorial Summaries', onTap: _showSavedEditorialSheet),
                      SettingsItem(icon: Icons.history_edu_rounded, label: 'My Descriptive Mock Scores', onTap: _showTestsListSheet),
                      SettingsItem(
                        icon: Icons.support_agent_rounded,
                        label: 'Help & Live Support',
                        onTap: () => _showSnack('Opening Support chat with IAS mentor...', icon: Icons.support_agent_rounded, color: AppColors.primary),
                      ),
                      SettingsItem(icon: Icons.logout_rounded, label: 'Sign Out', isDestructive: true, onTap: _showLogoutDialog),
                    ].animate(interval: 40.ms).fade(delay: 300.ms, duration: 400.ms).slideX(begin: 0.08, end: 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Gradient banner header — title + edit control sit on a colored curved
  // banner, with the profile card overlapping its bottom edge.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildGradientHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 64),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Student Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                Material(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        if (_isEditing) _userName = _nameController.text.trim();
                        _isEditing = !_isEditing;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Icon(_isEditing ? Icons.save_rounded : Icons.edit_note_rounded, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            _isEditing ? 'Save' : 'Edit Target',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 350.ms),
            const SizedBox(height: 4),
            Text(
              'Your UPSC journey, one focused step at a time',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12.5, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Elevated profile card, overlapping the header's bottom edge.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(22), boxShadow: AppShadows.card),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showPhotoOptions,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.goldGradient),
                  child: _isLoadingPhoto
                      ? const ShimmerPlaceholder.circle(size: 74)
                      : CircleAvatar(radius: 37, backgroundColor: AppColors.chipBackground, backgroundImage: NetworkImage(_photoUrl)),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEditing)
                  TextField(
                    controller: _nameController,
                    style: AppTextStyles.textPrimary14semibold,
                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 4), isDense: true, hintText: 'Enter Student Name'),
                  )
                else
                  Text(_userName, style: AppTextStyles.textPrimary16bold.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                const Text('Aspirant ID: IAS2027-391', style: AppTextStyles.textSecondary11semibold),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.chipSelected,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.premiumBorder, width: 0.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars_rounded, color: AppColors.gold, size: 10),
                          const SizedBox(width: 4),
                          Text('CSE $_targetYear', style: AppTextStyles.goldMuted8semibold.copyWith(fontSize: 9.5)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        _selectedStage,
                        style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.success),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  // ───────────────────────────────────────────────────────────────────────
  // Membership card
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildMembershipCard() {
    return GlassContainer(
      opacity: 0.1,
      shadowStrength: 3,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.premiumBorder, width: 0.8),
      color: AppColors.premiumBadge.withValues(alpha: 0.2),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.premiumBadge.withValues(alpha: 0.15), AppColors.goldShimmer.withValues(alpha: 0.08)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.workspace_premium_rounded, color: AppColors.goldDark, size: 28)
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(duration: 1200.ms, begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1))
                .rotate(duration: 2500.ms, begin: -0.05, end: 0.05),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Premium membership active', style: AppTextStyles.textPrimary13bold),
                  const SizedBox(height: 3),
                  Text(
                    'Unlock unlimited scanned answer evaluation & daily mock test reviews.',
                    style: AppTextStyles.textSecondary11semibold.copyWith(fontSize: 10.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(delay: 50.ms, duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  // ───────────────────────────────────────────────────────────────────────
  // NEW — "Next Mentor Session" card: the fastest path to booking a slot
  // or reaching a mentor, front and center on the profile.
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildNextSessionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.divider, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Next Mentor Session', style: AppTextStyles.textPrimary14semibold),
              GestureDetector(
                onTap: _showScheduledBookingsSheet,
                child: const Text(
                  'View all',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(color: AppColors.premiumBadge, shape: BoxShape.circle),
                child: const Icon(Icons.person_rounded, color: AppColors.goldDark, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_nextMentorName, style: AppTextStyles.textPrimary13bold),
                    const SizedBox(height: 2),
                    Text(_nextMentorTopic, style: AppTextStyles.textSecondary11semibold),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  _nextMentorSlot,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.success),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showSnack('Opening chat with $_nextMentorName...', icon: Icons.chat_bubble_rounded, color: AppColors.primary),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                  label: const Text('Message'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => widget.onTabChanged?.call(1),
                  icon: const Icon(Icons.calendar_month_rounded, size: 16),
                  label: const Text('Book Slot'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(delay: 80.ms, duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  // ───────────────────────────────────────────────────────────────────────
  // Target & Goals editor card
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildTargetGoalsCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _isEditing ? AppColors.gold : Colors.transparent, width: _isEditing ? 1.0 : 0.0),
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
                  const Text('Target & Goals Setup', style: AppTextStyles.textPrimary14semibold),
                ],
              ),
              if (_isEditing)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                  child: const Text(
                    'Editing Active',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.goldDark),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(child: Text('UPSC Attempt Year:', style: AppTextStyles.textSecondary12medium)),
              _isEditing
                  ? DropdownButton<String>(
                      value: _targetYear,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.gold),
                      underline: Container(height: 1.5, color: AppColors.gold),
                      onChanged: (val) {
                        if (val != null) setState(() => _targetYear = val);
                      },
                      items: _yearsList.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                    )
                  : Text(_targetYear, style: AppTextStyles.textPrimary12semibold.copyWith(color: AppColors.goldDark)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text('Target UPSC Stage:', style: AppTextStyles.textSecondary12medium),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _stagesList.map((stg) {
                    final isSel = _selectedStage == stg;
                    return ChoiceChip(
                      label: Text(stg),
                      selected: isSel,
                      onSelected: _isEditing
                          ? (sel) {
                              if (sel) setState(() => _selectedStage = stg);
                            }
                          : null,
                      selectedColor: AppColors.premiumBadge,
                      backgroundColor: AppColors.chipBackground,
                      labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSel ? AppColors.goldDark : AppColors.textSecondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Text('Optional Subject:', style: AppTextStyles.textSecondary12medium)),
              _isEditing
                  ? DropdownButton<String>(
                      value: _optionalSubject,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.gold),
                      underline: Container(height: 1.5, color: AppColors.gold),
                      onChanged: (val) {
                        if (val != null) setState(() => _optionalSubject = val);
                      },
                      items: _optionalsList.map((sub) => DropdownMenuItem(value: sub, child: Text(sub))).toList(),
                    )
                  : Text(_optionalSubject, style: AppTextStyles.textPrimary12semibold.copyWith(color: AppColors.goldDark)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Medium of Exam:', style: AppTextStyles.textSecondary12medium),
              const SizedBox(width: 20),
              Wrap(
                spacing: 8,
                children: _mediumList.map((med) {
                  final isSel = _examMedium == med;
                  return ChoiceChip(
                    label: Text(med),
                    selected: isSel,
                    onSelected: _isEditing
                        ? (sel) {
                            if (sel) setState(() => _examMedium = med);
                          }
                        : null,
                    selectedColor: AppColors.premiumBadge,
                    backgroundColor: AppColors.chipBackground,
                    labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSel ? AppColors.goldDark : AppColors.textSecondary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  // ───────────────────────────────────────────────────────────────────────
  // Countdown card
  // ───────────────────────────────────────────────────────────────────────
  Widget _buildCountdownCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('UPSC CSE $_targetYear PRELIMS COUNTDOWN', style: AppTextStyles.goldLight10bold),
              const Icon(Icons.hourglass_bottom_rounded, color: AppColors.goldLight, size: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '320',
                style: TextStyle(fontSize: 32, fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(width: 6),
              const Text(
                'Days',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Remaining for CSE $_targetYear', style: AppTextStyles.white10normal, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.68,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
              minHeight: 6,
            ),
          ),
        ],
      ),
    ).animate().fade(delay: 250.ms, duration: 450.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _shortcutButton({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Expanded(
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider, width: 0.8),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 19),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textPrimary11bold.copyWith(fontSize: 9.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard({required IconData icon, required String value, required String label, required Color color, required Color bg}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label, style: AppTextStyles.textSecondary8semibold.copyWith(fontSize: 9), maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontFamily: 'PlusJakartaSans'),
          ),
        ],
      ),
    );
  }
}
