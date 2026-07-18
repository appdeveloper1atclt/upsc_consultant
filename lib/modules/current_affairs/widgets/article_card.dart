import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_image.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';

class Article {
  final String category;
  final String title;
  final String description;
  final String date;
  final String readTime;

  const Article({
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.readTime,
  });
}

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onBookmarkTap;

  const ArticleCard({
    super.key,
    required this.article,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.premiumBadge,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              article.category,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: AppColors.goldMuted,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            article.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            article.description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImage.calenderImg,
                    width: 12,
                    height: 12,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    article.date,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.access_time_rounded,
                    size: 12,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    article.readTime,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  size: 20,
                  color: AppColors.goldMuted,
                ),
                onPressed: onBookmarkTap,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
