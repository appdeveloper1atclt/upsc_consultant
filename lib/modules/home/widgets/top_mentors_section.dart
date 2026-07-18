import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import '../../../core/widgets/shimmer_placeholder.dart';

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
                style: TextStyle(color: AppColors.goldDark, fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 152,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: mentors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final m = mentors[i];
              return GestureDetector(
                onTap: () => onMentorTap(m),
                child: Container(
                  width: 118,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: AppShadows.card),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: m.photoUrl,
                          width: 38,
                          height: 38,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const ShimmerPlaceholder.circle(size: 38),
                          errorWidget: (_, __, ___) => Container(width: 38, height: 38, color: AppColors.chipBackground),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(m.name, style: AppTextStyles.cardTitle.copyWith(fontSize: 11.5), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 1),
                      Text(m.expertise, style: AppTextStyles.cardSubtitle.copyWith(fontSize: 9.5), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 12, color: AppColors.gold),
                          const SizedBox(width: 2),
                          Text('${m.rating}', style: AppTextStyles.textPrimary10bold),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(m.studentsLabel, style: AppTextStyles.caption.copyWith(fontSize: 8.5), overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.premiumBadge, borderRadius: BorderRadius.circular(8)),
                        child: Text('₹${m.price} / session', style: AppTextStyles.goldMuted95bold.copyWith(fontSize: 9)),
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
