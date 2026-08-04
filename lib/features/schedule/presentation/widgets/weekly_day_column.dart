import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/presentation/models/schedule_models.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/weekly_appointment_card.dart';
import 'package:medidesk_app/features/schedule/presentation/widgets/weekly_day_header.dart';

/// One day column of the weekly grid: header + hour grid + the day's
/// [WeeklyAppointment] cards positioned by time.
class WeeklyDayColumn extends StatelessWidget {
  final String dayLabel;
  final DateTime date;
  final bool isToday;
  final List<WeeklyAppointment> appointments;

  const WeeklyDayColumn({
    super.key,
    required this.dayLabel,
    required this.date,
    required this.appointments,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final totalHeight = (kScheduleEndHour - kScheduleStartHour) * kScheduleHourHeight;
    final hourCount = kScheduleEndHour - kScheduleStartHour;

    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.borderLight)),
      ),
      child: Column(
        children: [
          WeeklyDayHeader(dayLabel: dayLabel, date: date, isToday: isToday),
          SizedBox(
            height: totalHeight,
            child: Stack(
              children: [
                Column(
                  children: List.generate(
                    hourCount,
                    (_) => Container(
                      height: kScheduleHourHeight,
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.borderLight)),
                      ),
                    ),
                  ),
                ),
                ...appointments.map((appointment) {
                  final top = (appointment.startHour - kScheduleStartHour) * kScheduleHourHeight;
                  final height = (appointment.endHour - appointment.startHour) * kScheduleHourHeight;
                  return Positioned(
                    top: top + 1,
                    left: 3,
                    right: 3,
                    height: height - 2,
                    child: WeeklyAppointmentCard(appointment: appointment),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}