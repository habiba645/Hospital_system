import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

/// Shared timeline configuration used by both the today and weekly views.
const int kScheduleStartHour = 8;
const int kScheduleEndHour = 18;
const double kScheduleHourHeight = 64;

enum SlotStatus { upcoming, completed, cancelled }

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

/// One booked slot on a doctor's timeline (used by the today's schedule view).
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

/// Mock data — replace with the real per-doctor schedule once the backend
/// integration is wired up.
final List<DoctorDaySchedule> mockTodaySchedule = [
  const DoctorDaySchedule(
    doctorName: 'Dr. Alex Morgan',
    department: 'Cardiology',
    slots: [
      ScheduleSlot(patientName: 'Sarah Johnson', startHour: 9, endHour: 9.5, status: SlotStatus.completed),
      ScheduleSlot(patientName: 'Omar Hassan', startHour: 11, endHour: 11.5, status: SlotStatus.upcoming),
      ScheduleSlot(patientName: 'Laura Smith', startHour: 14, endHour: 14.5, status: SlotStatus.upcoming),
    ],
  ),
  const DoctorDaySchedule(
    doctorName: 'Dr. Lina Farouk',
    department: 'Dermatology',
    slots: [
      ScheduleSlot(patientName: 'Michael Chen', startHour: 10, endHour: 10.5, status: SlotStatus.upcoming),
      ScheduleSlot(patientName: 'Nadia Ali', startHour: 12.5, endHour: 13, status: SlotStatus.cancelled),
      ScheduleSlot(patientName: 'Youssef Ibrahim', startHour: 16, endHour: 16.5, status: SlotStatus.upcoming),
    ],
  ),
  const DoctorDaySchedule(
    doctorName: 'Dr. Karim Saad',
    department: 'Orthopedics',
    slots: [
      ScheduleSlot(patientName: 'Hana Adel', startHour: 8.5, endHour: 9, status: SlotStatus.completed),
      ScheduleSlot(patientName: 'Fady Nabil', startHour: 13, endHour: 13.5, status: SlotStatus.upcoming),
    ],
  ),
];

/// One booked appointment placed on the weekly grid.
class WeeklyAppointment {
  final String patientName;
  final String doctorName;
  final int dayIndex; // 0 = Monday ... 6 = Sunday
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

final List<WeeklyAppointment> mockWeeklyAppointments = [
  const WeeklyAppointment(patientName: 'Sarah Johnson', doctorName: 'Dr. Alex Morgan', dayIndex: 0, startHour: 9, endHour: 9.5, status: SlotStatus.completed),
  const WeeklyAppointment(patientName: 'Michael Chen', doctorName: 'Dr. Lina Farouk', dayIndex: 0, startHour: 11, endHour: 11.5, status: SlotStatus.upcoming),
  const WeeklyAppointment(patientName: 'Omar Hassan', doctorName: 'Dr. Alex Morgan', dayIndex: 1, startHour: 10, endHour: 10.5, status: SlotStatus.upcoming),
  const WeeklyAppointment(patientName: 'Nadia Ali', doctorName: 'Dr. Karim Saad', dayIndex: 2, startHour: 13, endHour: 13.5, status: SlotStatus.cancelled),
  const WeeklyAppointment(patientName: 'Laura Smith', doctorName: 'Dr. Lina Farouk', dayIndex: 2, startHour: 15, endHour: 15.5, status: SlotStatus.upcoming),
  const WeeklyAppointment(patientName: 'Youssef Ibrahim', doctorName: 'Dr. Karim Saad', dayIndex: 3, startHour: 9.5, endHour: 10, status: SlotStatus.upcoming),
  const WeeklyAppointment(patientName: 'Hana Adel', doctorName: 'Dr. Alex Morgan', dayIndex: 4, startHour: 12, endHour: 12.5, status: SlotStatus.completed),
  const WeeklyAppointment(patientName: 'Fady Nabil', doctorName: 'Dr. Lina Farouk', dayIndex: 4, startHour: 16, endHour: 16.5, status: SlotStatus.upcoming),
];