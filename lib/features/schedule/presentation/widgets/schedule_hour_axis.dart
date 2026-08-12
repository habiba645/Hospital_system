import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/presentation/models/schedule_models.dart';

class ScheduleHourAxis extends StatelessWidget {
  final double topOffset;

  const ScheduleHourAxis({super.key, this.topOffset = 0});

  @override
  Widget build(BuildContext context) {
    final totalHeight = (kScheduleEndHour - kScheduleStartHour) * kScheduleHourHeight;
    final hours = List<int>.generate(
      kScheduleEndHour - kScheduleStartHour + 1,
      (index) => kScheduleStartHour + index,
    );

    return SizedBox(
      width: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: topOffset),
          SizedBox(
            height: totalHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: hours.map((hour) {
                return Positioned(
                  top: (hour - kScheduleStartHour) * kScheduleHourHeight - 7,
                  left: 0,
                  right: 8,
                  child: Text(
                    _label(hour),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _label(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:00 $period';
  }
}