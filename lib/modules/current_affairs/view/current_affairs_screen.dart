import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';
import '../widgets/article_card.dart';

class CurrentAffairsScreen extends StatefulWidget {
  const CurrentAffairsScreen({super.key});

  @override
  State<CurrentAffairsScreen> createState() => _CurrentAffairsScreenState();
}

class _CurrentAffairsScreenState extends State<CurrentAffairsScreen> {
  static const List<Article> articles = [
    Article(
      category: 'Polity & Governance',
      title: 'Judicial Reforms and Pendency of Cases in India',
      description:
          'An in-depth analysis of the causes of judicial delays and proposed structural reforms for GS Paper II.',
      date: 'July 15, 2026',
      readTime: '6 min read',
    ),
    Article(
      category: 'International Relations',
      title: 'India-Middle East-Europe Economic Corridor (IMEC)',
      description:
          'Examining the strategic and economic implications of IMEC corridors on global trade routes and geopolitics.',
      date: 'July 14, 2026',
      readTime: '8 min read',
    ),
    Article(
      category: 'Economy',
      title: 'GST Council Decisions and Cooperative Federalism',
      description:
          'A comprehensive review of the recent GST rate changes and their impact on state fiscal autonomy.',
      date: 'July 12, 2026',
      readTime: '5 min read',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Current Affairs',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Handpicked news summaries and editorial analyses for UPSC IAS aspirants.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articles.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final art = articles[index];
              return ArticleCard(
                article: art,
                onBookmarkTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bookmarked: ${art.title}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
