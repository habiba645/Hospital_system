import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

/// Header cell of a weekly grid column: day name + date number.
class WeeklyDayHeader extends StatelessWidget {
  final String dayLabel;
  final DateTime date;
  final bool isToday;

  const WeeklyDayHeader({
    super.key,
    required this.dayLabel,
    required this.date,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isToday ? AppColors.sidebarActive : AppColors.surface,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isToday ? AppColors.sidebarIconActive : AppColors.textTertiary,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${date.day}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isToday ? AppColors.sidebarIconActive : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}