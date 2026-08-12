import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/data/models/schedule_models.dart';

class DoctorTimelineColumn extends StatelessWidget {
  final DoctorDaySchedule schedule;
  static const double headerHeight = 56;

  const DoctorTimelineColumn({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final totalHeight = (kScheduleEndHour - kScheduleStartHour) * kScheduleHourHeight;
    final hourCount = kScheduleEndHour - kScheduleStartHour;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: headerHeight,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.doctorName,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  schedule.department,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
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
                ...schedule.slots.map((slot) => _SlotBlock(slot: slot)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotBlock extends StatelessWidget {
  final ScheduleSlot slot;
  const _SlotBlock({required this.slot});

  @override
  Widget build(BuildContext context) {
    final top = (slot.startHour - kScheduleStartHour) * kScheduleHourHeight;
    final height = (slot.endHour - slot.startHour) * kScheduleHourHeight;

    return Positioned(
      top: top + 2,
      left: 8,
      right: 8,
      height: height - 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: slot.status.backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: slot.status.color, width: 3)),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          slot.patientName,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slot.status.color),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}