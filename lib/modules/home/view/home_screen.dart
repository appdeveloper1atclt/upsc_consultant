import 'package:flutter/material.dart';
import 'package:upsc_consultant/core/constant/app_colors.dart';
import 'package:upsc_consultant/core/widgets/bottomnavigation_bar.dart';
import 'package:upsc_consultant/core/widgets/custom_appbar.dart';
import 'package:upsc_consultant/modules/current_affairs/view/current_affairs_screen.dart';
import 'package:upsc_consultant/modules/home/widgets/home_tab_view.dart';
import 'package:upsc_consultant/modules/home/widgets/scan_tab_view.dart';
import 'package:upsc_consultant/modules/profile/view/profile_screen.dart';
import 'package:upsc_consultant/modules/tests/view/tests_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  void _handleNavTap(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                HomeTabView(onNavTap: _handleNavTap),
                const CurrentAffairsScreen(),
                const ScanTabView(),
                const TestsScreen(),
                const ProfileScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: currentIndex,
        onTap: _handleNavTap,
      ),
    );
  }
}
