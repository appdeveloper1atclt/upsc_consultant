import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../widgets/custom_segmented_tab_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StudyAnalyticsScreen extends StatefulWidget {
  const StudyAnalyticsScreen({super.key});

  @override
  State<StudyAnalyticsScreen> createState() => _StudyAnalyticsScreenState();
}

class _StudyAnalyticsScreenState extends State<StudyAnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _timeframeController;
  int _touchedIndex = -1;

  // Mock data for Weekly and Monthly views
  final List<double> weeklyHours = [4.5, 6.5, 5.0, 8.0, 7.2, 5.5, 8.5]; // Mon to Sun
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<double> monthlyHours = [32.5, 41.0, 36.8, 44.5]; // Week 1 to Week 4
  final List<String> monthlyWeeks = ['W1', 'W2', 'W3', 'W4'];

  // Subject breakdown mock data
  final List<SubjectTime> weeklySubjects = [
    SubjectTime(subject: 'GS-II Polity', hours: 14.5, color: const Color(0xFF0F2537), icon: Icons.gavel_rounded),
    SubjectTime(subject: 'Current Affairs', hours: 11.2, color: AppColors.goldDark, icon: Icons.newspaper_rounded),
    SubjectTime(subject: 'GS-I History', hours: 9.0, color: const Color(0xFF2563EB), icon: Icons.menu_book_rounded),
    SubjectTime(subject: 'Essay Writing', hours: 6.5, color: const Color(0xFFC62828), icon: Icons.edit_note_rounded),
    SubjectTime(subject: 'CSAT Math', hours: 4.0, color: const Color(0xFF107C41), icon: Icons.calculate_rounded),
  ];

  final List<SubjectTime> monthlySubjects = [
    SubjectTime(subject: 'GS-II Polity', hours: 52.0, color: const Color(0xFF0F2537), icon: Icons.gavel_rounded),
    SubjectTime(subject: 'Current Affairs', hours: 42.5, color: AppColors.goldDark, icon: Icons.newspaper_rounded),
    SubjectTime(subject: 'GS-I History', hours: 34.0, color: const Color(0xFF2563EB), icon: Icons.menu_book_rounded),
    SubjectTime(subject: 'Essay Writing', hours: 18.3, color: const Color(0xFFC62828), icon: Icons.edit_note_rounded),
    SubjectTime(subject: 'CSAT Math', hours: 15.0, color: const Color(0xFF107C41), icon: Icons.calculate_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _timeframeController = TabController(length: 2, vsync: this);
    _timeframeController.addListener(() {
      setState(() {
        _touchedIndex = -1; // Reset touched state on tab change
      });
    });
  }

  @override
  void dispose() {
    _timeframeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeekly = _timeframeController.index == 0;
    final double totalHours = isWeekly ? weeklyHours.reduce((a, b) => a + b) : monthlyHours.reduce((a, b) => a + b);
    final double dailyAverage = totalHours / (isWeekly ? 7 : 28);

    final subjects = isWeekly ? weeklySubjects : monthlySubjects;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('Study Analytics', style: AppTextStyles.appBarTitle),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeframe Segmented Selector
            CustomSegmentedTabBar(controller: _timeframeController, tabs: const ['Weekly View', 'Monthly View'])
                .animate()
                .fade(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 20),

            // Main Summary Dashboard
            _buildMainDashboard(totalHours, dailyAverage, isWeekly)
                .animate()
                .fade(delay: 50.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 20),

            // fl_chart Bar Chart Card
            _buildChartCard(isWeekly)
                .animate()
                .fade(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 20),

            // Subject wise study breakdown
            _buildSubjectBreakdown(subjects, totalHours)
                .animate()
                .fade(delay: 150.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 20),

            // Premium Performance Grid
            _buildPerformanceGrid(isWeekly)
                .animate()
                .fade(delay: 200.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 20),

            // AI Insights Recommendations
            _buildAiInsights()
                .animate()
                .fade(delay: 250.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMainDashboard(double totalHours, double dailyAverage, bool isWeekly) {
    final int totalHrs = totalHours.toInt();
    final int totalMins = ((totalHours - totalHrs) * 60).round();

    final int avgHrs = dailyAverage.toInt();
    final int avgMins = ((dailyAverage - avgHrs) * 60).round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL STUDY TIME',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textSecondary, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${totalHrs}h ${totalMins}m',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.primary),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.premiumBadge,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.premiumBorder, width: 0.6),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.workspace_premium_rounded, color: AppColors.goldDark, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Target Met',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.goldMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniDashboardStat(title: 'Daily Average', value: '${avgHrs}h ${avgMins}m', icon: Icons.av_timer_rounded, color: const Color(0xFF2563EB)),
              _buildMiniDashboardStat(title: 'Current Streak', value: '12 Days', icon: Icons.local_fire_department_rounded, color: Colors.orange),
              _buildMiniDashboardStat(
                title: 'Goal Progress',
                value: isWeekly ? '92%' : '88%',
                icon: Icons.track_changes_rounded,
                color: const Color(0xFF107C41),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniDashboardStat({required String title, required String value, required IconData icon, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildChartCard(bool isWeekly) {
    final List<double> data = isWeekly ? weeklyHours : monthlyHours;
    final List<String> labels = isWeekly ? weekdays : monthlyWeeks;
    final double maxVal = data.reduce((a, b) => a > b ? a : b) + 1.5;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Study Hours',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text('Tap on any bar to see exact details', style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
                ],
              ),
              const Icon(Icons.bar_chart_rounded, color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          AspectRatio(
            aspectRatio: 1.6,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxVal,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => const Color(0xFF0F2537),
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final double val = rod.toY;
                      final int hrs = val.toInt();
                      final int mins = ((val - hrs) * 60).round();
                      final String day = labels[groupIndex];
                      return BarTooltipItem(
                        '$day\n',
                        const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '${hrs}h ${mins}m',
                            style: const TextStyle(color: AppColors.goldLight, fontSize: 13, fontWeight: FontWeight.w900),
                          ),
                        ],
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
                      setState(() {
                        _touchedIndex = -1;
                      });
                      return;
                    }
                    setState(() {
                      _touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final int index = value.toInt();
                        if (index < 0 || index >= labels.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 6,
                          child: Text(
                            labels[index],
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSecondary),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value == 0 || value % 2 != 0) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text(
                            '${value.toInt()}h',
                            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textHint),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) => FlLine(color: AppColors.divider.withValues(alpha: 0.5), strokeWidth: 0.8),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(data.length, (index) {
                  final bool isTouched = index == _touchedIndex;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data[index],
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: isTouched ? [const Color(0xFF1D4ED8), const Color(0xFF3B82F6)] : [AppColors.primary, AppColors.primaryLight],
                        ),
                        width: isTouched ? 15 : 12,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                        backDrawRodData: BackgroundBarChartRodData(show: true, toY: maxVal, color: AppColors.surface.withValues(alpha: 0.5)),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectBreakdown(List<SubjectTime> subjects, double totalHours) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Subject Breakdown',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
              ),
              Icon(Icons.pie_chart_outline_rounded, color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 18),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subjects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final s = subjects[index];
              final double percentage = s.hours / totalHours;
              final int hrs = s.hours.toInt();
              final int mins = ((s.hours - hrs) * 60).round();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(s.icon, color: s.color, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            s.subject,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      Text(
                        '${hrs}h ${mins}m (${(percentage * 100).toStringAsFixed(0)}%)',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: s.color),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(3)),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 6,
                        width: MediaQuery.of(context).size.width * 0.78 * percentage,
                        decoration: BoxDecoration(color: s.color, borderRadius: BorderRadius.circular(3)),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceGrid(bool isWeekly) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: [
        _buildMetricCard(title: 'Quiz Accuracy', value: '82%', subText: '↑ 8% from last week', color: const Color(0xFF107C41), icon: Icons.fact_check_rounded),
        _buildMetricCard(
          title: 'Questions Solved',
          value: isWeekly ? '486' : '1,944',
          subText: '↑ 32 standard answers',
          color: AppColors.primary,
          icon: Icons.checklist_rtl_rounded,
        ),
        _buildMetricCard(
          title: 'Mock Tests Taken',
          value: isWeekly ? '3' : '12',
          subText: 'Completed & reviewed',
          color: AppColors.goldDark,
          icon: Icons.assignment_turned_in_rounded,
        ),
        _buildMetricCard(
          title: 'Focus Score',
          value: '89/100',
          subText: 'Highly attentive state',
          color: const Color(0xFFC62828),
          icon: Icons.psychology_rounded,
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required String subText, required Color color, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6), width: 0.8),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
              ),
              Icon(icon, color: color.withValues(alpha: 0.8), size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 2),
              Text(
                subText,
                style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsights() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0F2537), Color(0xFF081521)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.25), width: 1),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 14, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.auto_awesome_rounded, color: AppColors.gold, size: 18),
              SizedBox(width: 6),
              Text(
                'AI Study Insights',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildInsightItem(text: 'Your accuracy in GS-II Polity has risen by 8%. Continue with MCQ mock tests.', bulletColor: AppColors.gold),
          const SizedBox(height: 10),
          _buildInsightItem(
            text: 'Study patterns show focus peaks on Thursday & Sunday. Try scheduling complex History topics then.',
            bulletColor: AppColors.goldLight,
          ),
          const SizedBox(height: 10),
          _buildInsightItem(
            text: 'You are 2.5 hours behind on GS-I History targets. Dedicating 30 mins extra daily can bridge this.',
            bulletColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({required String text, required Color bulletColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: bulletColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, color: Color(0xE6FFFFFF), height: 1.35, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class SubjectTime {
  final String subject;
  final double hours;
  final Color color;
  final IconData icon;

  SubjectTime({required this.subject, required this.hours, required this.color, required this.icon});
}
