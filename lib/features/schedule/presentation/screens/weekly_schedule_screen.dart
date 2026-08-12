import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/cubit/cubit.dart';
import 'package:medidesk_app/features/schedule/cubit/state.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_hour_axis.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_status_legend.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/weekly_day_column.dart';

class WeeklyScheduleScreen extends StatelessWidget {
  const WeeklyScheduleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(
        context.read(),
      )..load(),
      child: const _WeeklyScheduleView(),
    );
  }
}

class _WeeklyScheduleView extends StatelessWidget {
  const _WeeklyScheduleView();

  static const List<String> _dayLabels = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  static const double _dayColumnWidth = 220;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(
      Duration(
        days: now.weekday - 1,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly schedule',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Week view of appointments across all doctors.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 16),

          const ScheduleStatusLegend(),

          const SizedBox(height: 24),

          Expanded(
            child: BlocBuilder<ScheduleCubit, ScheduleState>(
              builder: (context, state) {
                // Loading
                if (state is ScheduleLoading ||
                    state is ScheduleInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error
                if (state is ScheduleError) {
                  return Center(
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }

                // Loaded
                if (state is ScheduleLoaded) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                width:
                                    100 + (_dayColumnWidth * 7),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // Time axis
                                    const SizedBox(
                                      width: 100,
                                      child: ScheduleHourAxis(
                                        topOffset: 56,
                                      ),
                                    ),

                                    // Days
                                    ...List.generate(
                                      7,
                                      (index) {
                                        final date =
                                            startOfWeek.add(
                                          Duration(
                                            days: index,
                                          ),
                                        );

                                        final isToday =
                                            date.year ==
                                                    now.year &&
                                                date.month ==
                                                    now.month &&
                                                date.day ==
                                                    now.day;

                                        final dayAppointments =
                                            state
                                                .weeklyAppointments
                                                .where(
                                          (appointment) =>
                                              appointment.dayIndex ==
                                              index,
                                        ).toList();

                                        return SizedBox(
                                          width: _dayColumnWidth,
                                          child: WeeklyDayColumn(
                                            dayLabel:
                                                _dayLabels[index],
                                            date: date,
                                            isToday: isToday,
                                            appointments:
                                                dayAppointments,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // Safety fallback
                return const Center(
                  child: Text(
                    'No schedule available.',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}