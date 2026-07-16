import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';

class MentorData {
  final String name;
  final String expertise;
  final double rating;
  final String studentsLabel;
  final String photoUrl;
  final int price;

  const MentorData({required this.name, required this.expertise, required this.rating, required this.studentsLabel, required this.photoUrl, this.price = 299});
}

class TopMentorsSection extends StatelessWidget {
  final List<MentorData> mentors;
  final void Function(MentorData mentor) onMentorTap;
  final VoidCallback onViewAllTap;

  const TopMentorsSection({super.key, required this.mentors, required this.onMentorTap, required this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Text('Top Mentors', style: AppTextStyles.sectionTitle),
                SizedBox(width: 4),
                Icon(Icons.verified_rounded, size: 15, color: Color(0xFF378ADD)),
              ],
            ),
            TextButton(
              onPressed: onViewAllTap,
              child: const Text(
                'View All',
                style: TextStyle(color: AppColors.goldMuted, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 168,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: mentors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final m = mentors[i];
              return GestureDetector(
                onTap: () => onMentorTap(m),
                child: Container(
                  width: 128,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: AppShadows.card),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: m.photoUrl,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(width: 44, height: 44, color: AppColors.chipBackground),
                          errorWidget: (_, __, ___) => Container(width: 44, height: 44, color: AppColors.chipBackground),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(m.name, style: AppTextStyles.cardTitle.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(m.expertise, style: AppTextStyles.cardSubtitle.copyWith(fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 12, color: AppColors.gold),
                          const SizedBox(width: 2),
                          Text(
                            '${m.rating}',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(m.studentsLabel, style: AppTextStyles.caption.copyWith(fontSize: 9), overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.premiumBadge, borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '₹${m.price} / session',
                          style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.goldMuted),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
