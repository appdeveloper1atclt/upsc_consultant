import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class StudyAnalyticsSection extends StatelessWidget {
  final VoidCallback onViewAllTap;

  const StudyAnalyticsSection({super.key, required this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.query_stats_rounded, color: AppColors.primary, size: 18),
                SizedBox(width: 6),
                Text(
                  'Study Analytics',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: onViewAllTap,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Analytics Row containing Chart (left) and Stats (right)
        SizedBox(
          height: 136,
          child: Row(
            children: [
              // ── Weekly Study Time Card ──────────────────────────────────────
              Expanded(
                flex: 12,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weekly Study Time',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),

                      // Custom Bar Chart Area with Friday Tooltip
                      SizedBox(
                        height: 94,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Mon-Sun Bars Row
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildBar('Mon', 0.45),
                                  _buildBar('Tue', 0.65),
                                  _buildBar('Wed', 0.50),
                                  _buildBar('Thu', 0.80),
                                  _buildBar('Fri', 0.72, isHighlighted: true),
                                  _buildBar('Sat', 0.55),
                                  _buildBar('Sun', 0.85),
                                ],
                              ),
                            ),

                            // Tooltip Badge for Friday
                            Positioned(
                              top: -4,
                              left: 68, // Centered precisely above the Fri bar
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F2537),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: const Text(
                                  '8h 45m',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // ── Performance Metrics Stats Cards ─────────────────────────────
              Expanded(
                flex: 13,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('82%', 'Accuracy', '↑ 8%'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildStatCard('486', 'Questions\nSolved', '↑ 32'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildStatCard('128', 'Rank\nThis Week', '↑ 45'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper to build a vertical study bar
  Widget _buildBar(String day, double heightPct, {bool isHighlighted = false}) {
    final double maxBarHeight = 58;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: maxBarHeight * heightPct,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: isHighlighted
                  ? [const Color(0xFF2563EB), const Color(0xFF3B82F6)]
                  : [const Color(0xFF93C5FD).withValues(alpha: 0.6), const Color(0xFF60A5FA).withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: const TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // Helper to build small vertical metrics cards
  Widget _buildStatCard(String value, String label, String trend) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stat Value
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 15.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F2537),
            ),
          ),

          // Stat Label
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 8.2,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              height: 1.1,
            ),
          ),

          // Growth Trend Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_upward_rounded, size: 7.5, color: Color(0xFF2E7D32)),
                const SizedBox(width: 1),
                Text(
                  trend.replaceAll('↑', '').trim(),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
