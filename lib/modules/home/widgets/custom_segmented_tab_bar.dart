import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class CustomSegmentedTabBar extends StatefulWidget {
  final TabController controller;
  final List<String> tabs;

  const CustomSegmentedTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  State<CustomSegmentedTabBar> createState() => _CustomSegmentedTabBarState();
}

class _CustomSegmentedTabBarState extends State<CustomSegmentedTabBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTabSelection);
  }

  @override
  void didUpdateWidget(covariant CustomSegmentedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleTabSelection);
      widget.controller.addListener(_handleTabSelection);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = widget.controller.index;
    final int totalTabs = widget.tabs.length;

    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          final double tabWidth = totalWidth / totalTabs;

          return Stack(
            children: [
              // Smooth sliding indicator background
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                left: selectedIndex * tabWidth,
                width: tabWidth,
                height: constraints.maxHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.15),
                      width: 0.5,
                    ),
                  ),
                ),
              ),

              // Tab text buttons
              Row(
                children: List.generate(totalTabs, (index) {
                  final bool isSelected = index == selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.controller.animateTo(index);
                      },
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                          ),
                          child: Text(widget.tabs[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
