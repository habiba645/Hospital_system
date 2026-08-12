import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

const int kScheduleStartHour = 8;
const int kScheduleEndHour = 18;
const double kScheduleHourHeight = 64;

enum SlotStatus {
  upcoming,
  completed,
  cancelled,
}

extension SlotStatusX on SlotStatus {
  Color get color {
    switch (this) {
      case SlotStatus.upcoming:
        return AppColors.upcoming;

      case SlotStatus.completed:
        return AppColors.completed;

      case SlotStatus.cancelled:
        return AppColors.cancelled;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case SlotStatus.upcoming:
        return AppColors.upcomingBg;

      case SlotStatus.completed:
        return AppColors.completedBg;

      case SlotStatus.cancelled:
        return AppColors.cancelledBg;
    }
  }
}

class ScheduleSlot {
  final String patientName;
  final double startHour;
  final double endHour;
  final SlotStatus status;

  const ScheduleSlot({
    required this.patientName,
    required this.startHour,
    required this.endHour,
    required this.status,
  });
}

class DoctorDaySchedule {
  final String doctorName;
  final String department;
  final List<ScheduleSlot> slots;

  const DoctorDaySchedule({
    required this.doctorName,
    required this.department,
    required this.slots,
  });
}

class WeeklyAppointment {
  final String patientName;
  final String doctorName;
  final int dayIndex;
  final double startHour;
  final double endHour;
  final SlotStatus status;

  const WeeklyAppointment({
    required this.patientName,
    required this.doctorName,
    required this.dayIndex,
    required this.startHour,
    required this.endHour,
    required this.status,
  });
}