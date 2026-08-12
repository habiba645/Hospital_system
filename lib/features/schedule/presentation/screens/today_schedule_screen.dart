import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/appointments/data/appointments_repository.dart';
import 'package:medidesk_app/features/schedule/cubit/cubit.dart';
import 'package:medidesk_app/features/schedule/cubit/state.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/doctor_timeline_column.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_hour_axis.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/schedule_status_legend.dart';

class TodayScheduleScreen extends StatelessWidget {
  const TodayScheduleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(
        context.read<AppointmentsRepository>(),
      )..load(),
      child: const _TodayScheduleView(),
    );
  }
}

class _TodayScheduleView extends StatelessWidget {
  const _TodayScheduleView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's schedule",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Timeline view of today’s appointments per doctor.',
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
                if (state is ScheduleLoading ||
                    state is ScheduleInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ScheduleError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                final loaded = state as ScheduleLoaded;

                if (loaded.todaySchedules.isEmpty) {
                  return const Center(
                    child: Text(
                      'No appointments scheduled for today.',
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const ScheduleHourAxis(
                          topOffset:
                              DoctorTimelineColumn.headerHeight,
                        ),
                        ...loaded.todaySchedules.map(
                          (schedule) =>
                              DoctorTimelineColumn(
                            schedule: schedule,
                          ),
                        ),
                      ],
                    ),
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