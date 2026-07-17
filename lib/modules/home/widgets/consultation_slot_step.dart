import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class ConsultationSlotStep extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final List<DateTime> dates;
  final List<String> timeSlots;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onTimeSlotChanged;

  final String Function(DateTime) getMonthYearString;
  final String Function(DateTime) getWeekdayString;
  final String Function(DateTime) getFormattedDateShort;
  final bool Function(DateTime, DateTime) isSameDay;

  const ConsultationSlotStep({
    super.key,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.dates,
    required this.timeSlots,
    required this.onDateChanged,
    required this.onTimeSlotChanged,
    required this.getMonthYearString,
    required this.getWeekdayString,
    required this.getFormattedDateShort,
    required this.isSameDay,
  });

  @override
  Widget build(BuildContext context) {
    final String monthHeader = getMonthYearString(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose a convenient date & time for your consultation.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 18),

        // Date Month Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onPressed: () {
                final prev = selectedDate.subtract(const Duration(days: 1));
                if (!prev.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
                  onDateChanged(prev);
                }
              },
            ),
            Text(
              monthHeader,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onPressed: () {
                onDateChanged(selectedDate.add(const Duration(days: 1)));
              },
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal Dates Picker
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final d = dates[index];
              final isSame = isSameDay(d, selectedDate);
              final weekday = getWeekdayString(d);
              final dayNum = d.day.toString();

              return GestureDetector(
                onTap: () => onDateChanged(d),
                child: Container(
                  width: 52,
                  decoration: BoxDecoration(
                    color: isSame ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSame ? AppColors.primary : AppColors.border,
                      width: 0.8,
                    ),
                    boxShadow: isSame
                        ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 6, offset: const Offset(0, 3))]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekday,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isSame ? Colors.white70 : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        dayNum,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: isSame ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // Available Slots Section
        Text(
          'Available Slots - ${getFormattedDateShort(selectedDate)}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),

        // Group 1: Morning Slots
        Row(
          children: const [
            Icon(Icons.wb_sunny_outlined, color: AppColors.gold, size: 14),
            SizedBox(width: 6),
            Text(
              'Morning Slots',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSlotsGrid(timeSlots.sublist(0, 3)),
        const SizedBox(height: 16),

        // Group 2: Afternoon & Evening Slots
        Row(
          children: const [
            Icon(Icons.wb_twilight_rounded, color: Colors.blue, size: 14),
            SizedBox(width: 6),
            Text(
              'Afternoon & Evening Slots',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSlotsGrid(timeSlots.sublist(3)),
      ],
    );
  }

  Widget _buildSlotsGrid(List<String> slots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = slot == selectedTimeSlot;

        return GestureDetector(
          onTap: () => onTimeSlotChanged(slot),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 0.8,
              ),
            ),
            child: Center(
              child: Text(
                slot,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
