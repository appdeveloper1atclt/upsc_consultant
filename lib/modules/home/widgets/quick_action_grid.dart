import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';

class _QuickAction {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const _QuickAction({required this.title, required this.icon, required this.onTap, required this.gradientColors});
}

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onCurrentAffairsTap;
  final VoidCallback onPyqTap;
  final VoidCallback onMcqTap;
  final VoidCallback onMentorConnectTap;
  final VoidCallback onPrelimsTap;
  final VoidCallback onMainsTap;
  final VoidCallback onViewAllTap;

  const QuickActionsGrid({
    super.key,
    required this.onCurrentAffairsTap,
    required this.onPyqTap,
    required this.onMcqTap,
    required this.onMentorConnectTap,
    required this.onPrelimsTap,
    required this.onMainsTap,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        title: 'Current Affairs',
        icon: AppImage.CurrentAffairsImg,
        onTap: onCurrentAffairsTap,
        gradientColors: const [Color(0xFFE0F2FE), Color(0xFF93C5FD)], // Richer Sky Blue
      ),
      _QuickAction(
        title: 'Previous Year\nQuestions',
        icon: AppImage.pyqImg,
        onTap: onPyqTap,
        gradientColors: const [Color(0xFFFEF3C7), Color(0xFFFCD34D)], // Richer Golden Amber
      ),
      _QuickAction(
        title: 'MCQ Practice',
        icon: AppImage.mcqImg,
        onTap: onMcqTap,
        gradientColors: const [Color(0xFFFEE2E2), Color(0xFFFCA5A5)], // Richer Rose Pink
      ),
      _QuickAction(
        title: 'Mentor Connect',
        icon: AppImage.mentorImg,
        onTap: onMentorConnectTap,
        gradientColors: const [Color(0xFFF3E8FF), Color(0xFFD8B4FE)], // Richer Purple
      ),
      _QuickAction(
        title: 'Prelims',
        icon: AppImage.prelimsImg,
        onTap: onPrelimsTap,
        gradientColors: const [Color(0xFFEEF2FF), Color(0xFFC7D2FE)], // Soft Indigo/Blue (matches Cap)
      ),
      _QuickAction(
        title: 'Mains',
        icon: AppImage.MainsImg,
        onTap: onMainsTap,
        gradientColors: const [Color(0xFFFFEAD2), Color(0xFFFFB070)], // Warm Peach/Orange (matches Quill)
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quick Access',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F2537)),
            ),
            TextButton(
              onPressed: onViewAllTap,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Text(
                'View All',
                style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Grid View of Action Cards
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 10,
            childAspectRatio: 0.95, // Matches the mockup's card shape (taller, almost square)
          ),
          itemBuilder: (context, index) {
            final action = actions[index];
            return _ActionCard(action: action);
          },
        ),
      ],
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
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: widget.action.gradientColors),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.action.gradientColors.last.withValues(alpha: 0.5), width: 1.0),
            boxShadow: [BoxShadow(color: widget.action.gradientColors.last.withValues(alpha: 0.25), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.action.icon, width: 65, height: 65, fit: BoxFit.cover),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  widget.action.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w900, color: Color(0xFF0F2537), fontSize: 11, height: 1.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
