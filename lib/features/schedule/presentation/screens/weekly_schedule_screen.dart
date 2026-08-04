import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/presentation/models/schedule_models.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_hour_axis.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_status_legend.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/weekly_day_column.dart';

class WeeklyScheduleScreen extends StatelessWidget {
  const WeeklyScheduleScreen({super.key});

  static const _dayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly schedule',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Week view of appointments across all doctors.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          const ScheduleStatusLegend(),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ScheduleHourAxis(topOffset: 56),
                      ...List.generate(7, (index) {
                        final date = startOfWeek.add(Duration(days: index));
                        final isToday =
                            date.year == now.year && date.month == now.month && date.day == now.day;
                        final dayAppointments =
                            mockWeeklyAppointments.where((a) => a.dayIndex == index).toList();
                        return Expanded(
                          child: WeeklyDayColumn(
                            dayLabel: _dayLabels[index],
                            date: date,
                            isToday: isToday,
                            appointments: dayAppointments,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}