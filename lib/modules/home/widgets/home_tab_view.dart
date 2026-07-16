import 'package:flutter/material.dart';
import 'answer_scanner.dart';
import 'quick_action_grid.dart';
import 'quote_banner.dart';
import 'scanner_status.dart';
import 'top_mentors_section.dart';

class HomeTabView extends StatelessWidget {
  final void Function(int index) onNavTap;

  const HomeTabView({super.key, required this.onNavTap});

  // Replace photoUrl with your own CDN links once real mentor photos are ready.
  static const List<MentorData> mentors = [
    MentorData(
      name: ' Anuj sharma Sir',
      expertise: 'GS Strategy',
      rating: 4.9,
      studentsLabel: '12K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      price: 299,
    ),
    MentorData(
      name: "Aradhya Ma'am",
      expertise: 'Essay Expert',
      rating: 4.9,
      studentsLabel: '8K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      price: 299,
    ),
    MentorData(
      name: 'Dr. Manan Arora',
      expertise: 'Current Affairs',
      rating: 4.8,
      studentsLabel: '15K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/men/56.jpg',
      price: 299,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnswerScannerBanner(onScanTap: () => onNavTap(2)),
          const SizedBox(height: 18),
          const ScannerStatsRow(),
          const SizedBox(height: 2),
          QuickActionsGrid(
            onCurrentAffairsTap: () => onNavTap(1),
            onPyqTap: () => onNavTap(3),
            onMcqTap: () => onNavTap(3),
            onMentorConnectTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connecting to verified mentors...')));
            },
            onPrelimsTap: () => onNavTap(3),
            onMainsTap: () => onNavTap(3),
          ),
          const SizedBox(height: 12),
          TopMentorsSection(
            mentors: mentors,
            onMentorTap: (m) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking session with ${m.name}...')));
            },
            onViewAllTap: () {},
          ),
          const SizedBox(height: 20),
          const QuoteBanner(),
        ],
      ),
    );
  }
}
