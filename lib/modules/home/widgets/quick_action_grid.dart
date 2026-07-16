import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

class _QuickAction {
  final String title;
  final String icon;
  final double iconSize;
  final VoidCallback onTap;

  const _QuickAction({required this.title, required this.icon, required this.onTap, this.iconSize = 52});
}

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onCurrentAffairsTap;
  final VoidCallback onPyqTap;
  final VoidCallback onMcqTap;
  final VoidCallback onMentorConnectTap;
  final VoidCallback onPrelimsTap;
  final VoidCallback onMainsTap;

  const QuickActionsGrid({
    super.key,
    required this.onCurrentAffairsTap,
    required this.onPyqTap,
    required this.onMcqTap,
    required this.onMentorConnectTap,
    required this.onPrelimsTap,
    required this.onMainsTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(title: 'Current Affairs', icon: AppImage.CurrentAffairsImg, iconSize: 46, onTap: onCurrentAffairsTap),
      _QuickAction(title: 'Previous Year\nQuestions', icon: AppImage.pyqImg, onTap: onPyqTap),
      _QuickAction(title: 'MCQ Practice', icon: AppImage.mcqImg, onTap: onMcqTap),
      _QuickAction(title: 'Mentor Connect', icon: AppImage.mentorImg, onTap: onMentorConnectTap),
      _QuickAction(title: 'Prelims', icon: AppImage.prelimsImg, onTap: onPrelimsTap),
      _QuickAction(title: 'Mains', icon: AppImage.MainsImg, onTap: onMainsTap),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 12, childAspectRatio: 0.95),
      itemBuilder: (context, index) {
        final action = actions[index];
        return _ActionCard(action: action);
      },
    );
  }
}

class _ActionCard extends StatefulWidget {
  final _QuickAction action;
  const _ActionCard({required this.action});

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.action.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon — no background, fills the space
              Image.asset(widget.action.icon, width: widget.action.iconSize, height: widget.action.iconSize, fit: BoxFit.cover),

              const SizedBox(height: 8),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  widget.action.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontSize: 10.5, height: 1.25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
