import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../provider/pt_challenge_controller.dart';

class ResultLeaderboard extends StatelessWidget {
  final PtChallengeController controller;

  const ResultLeaderboard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final leaderboard = [
      {'rank': 1, 'name': 'Rahul Sharma', 'score': 95, 'isYou': false},
      {'rank': 2, 'name': 'Ankit Verma', 'score': 94, 'isYou': false},
      {'rank': 3, 'name': 'Shivam Mishra', 'score': 94, 'isYou': false},
      {'rank': controller.rank, 'name': 'You', 'score': controller.score, 'isYou': true},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.leaderboard_rounded, color: AppColors.gold, size: 18),
              SizedBox(width: 8),
              Text(
                'Today\'s Top Rank',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaderboard.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
            itemBuilder: (ctx, index) {
              final user = leaderboard[index];
              final isYou = user['isYou'] as bool;
              final rankVal = user['rank'] as int;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isYou
                            ? AppColors.gold.withValues(alpha: 0.15)
                            : (rankVal == 1
                                ? const Color(0xFFFFF7E6)
                                : Colors.grey[100]),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$rankVal',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: isYou
                                ? AppColors.goldDark
                                : (rankVal == 1 ? Colors.orange : AppColors.textSecondary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Text(
                      user['name'] as String,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 13,
                        fontWeight: isYou ? FontWeight.bold : FontWeight.w600,
                        color: isYou ? AppColors.goldDark : AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),

                    Text(
                      '${user['score']}',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 13,
                        fontWeight: isYou ? FontWeight.bold : FontWeight.w700,
                        color: isYou ? AppColors.goldDark : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
