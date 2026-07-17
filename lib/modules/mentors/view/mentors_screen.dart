import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/constant/app_text_styles.dart';
import 'package:upsc_consultant/modules/home/widgets/top_mentors_section.dart';
import '../widgets/booking_bottom_sheet.dart';
import '../widgets/mentor_card.dart';

class MentorsScreen extends StatefulWidget {
  const MentorsScreen({super.key});

  @override
  State<MentorsScreen> createState() => _MentorsScreenState();
}

class _MentorsScreenState extends State<MentorsScreen> {
  String _selectedCategory = 'All';

  static const List<String> _categories = ['All', 'GS Strategy', 'Essay Expert', 'Current Affairs', 'Optional Subject'];

  static const List<MentorData> _allMentors = [
    MentorData(
      name: 'Anuj Sharma Sir',
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
    MentorData(
      name: 'Dr. Sanjay K. IAS (Retd.)',
      expertise: 'Interview Prep',
      rating: 5.0,
      studentsLabel: '20K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/men/82.jpg',
      price: 499,
    ),
    MentorData(
      name: 'Meera Deshmukh Ma\'am',
      expertise: 'Optional Subject',
      rating: 4.7,
      studentsLabel: '6K+ students',
      photoUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      price: 349,
    ),
  ];

  List<MentorData> get _filteredMentors {
    if (_selectedCategory == 'All') return _allMentors;
    return _allMentors.where((m) => m.expertise == _selectedCategory).toList();
  }

  void _showBookingSheet(BuildContext context, MentorData mentor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BookingBottomSheet(mentor: mentor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        // Header Section
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UPSC Mentors 🎓', style: AppTextStyles.pageTitle),
              SizedBox(height: 4),
              Text('Connect with verified senior bureaucrats and strategy experts.', style: AppTextStyles.pageSubtitle),
            ],
          ),
        ),
        SizedBox(height: 8),
        // Categories horizontal scroll
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: _categories.map((cat) {
              final isSelected = cat == _selectedCategory;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _selectedCategory = cat);
                  },
                  selectedColor: AppColors.gold,
                  backgroundColor: AppColors.chipBackground,
                  labelStyle: isSelected ? AppTextStyles.chipSelected.copyWith(color: AppColors.white) : AppTextStyles.chipUnselected,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  side: BorderSide.none,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                ),
              );
            }).toList(),
          ),
        ),

        // Mentors list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            itemCount: _filteredMentors.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final mentor = _filteredMentors[index];
              return MentorCard(mentor: mentor, onBookTap: () => _showBookingSheet(context, mentor));
            },
          ),
        ),
      ],
    );
  }
}
