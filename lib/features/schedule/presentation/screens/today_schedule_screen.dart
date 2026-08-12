import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/presentation/models/schedule_models.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/doctor_timeline_column.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_hour_axis.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_status_legend.dart';

class TodayScheduleScreen extends StatelessWidget {
  const TodayScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's schedule",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Timeline view of today’s appointments per doctor.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          const ScheduleStatusLegend(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ScheduleHourAxis(topOffset: DoctorTimelineColumn.headerHeight),
                    ...mockTodaySchedule.map((schedule) => DoctorTimelineColumn(schedule: schedule)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}