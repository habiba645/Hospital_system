import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case AppointmentStatus.upcoming:
        return AppColors.upcoming;
      case AppointmentStatus.completed:
        return AppColors.completed;
      case AppointmentStatus.cancelled:
        return AppColors.cancelled;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AppointmentStatus.upcoming:
        return AppColors.upcomingBg;
      case AppointmentStatus.completed:
        return AppColors.completedBg;
      case AppointmentStatus.cancelled:
        return AppColors.cancelledBg;
    }
  }
}

class Appointment {
  final String id;
  final String patientName;
  final String doctorName;
  final String department;
  final DateTime dateTime;
  final AppointmentStatus status;

  const Appointment({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.department,
    required this.dateTime,
    required this.status,
  });
}

/// Mock data — replace with the real list coming from the appointments
/// repository once the backend integration is wired up.
final List<Appointment> mockAppointments = [
  Appointment(
    id: '1',
    patientName: 'Sarah Johnson',
    doctorName: 'Dr. Alex Morgan',
    department: 'Cardiology',
    dateTime: DateTime.now().add(const Duration(hours: 2)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: '2',
    patientName: 'Michael Chen',
    doctorName: 'Dr. Lina Farouk',
    department: 'Dermatology',
    dateTime: DateTime.now().add(const Duration(hours: 4)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: '3',
    patientName: 'Omar Hassan',
    doctorName: 'Dr. Alex Morgan',
    department: 'Cardiology',
    dateTime: DateTime.now().subtract(const Duration(hours: 3)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: '4',
    patientName: 'Nadia Ali',
    doctorName: 'Dr. Karim Saad',
    department: 'Orthopedics',
    dateTime: DateTime.now().subtract(const Duration(days: 1)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: '5',
    patientName: 'Laura Smith',
    doctorName: 'Dr. Lina Farouk',
    department: 'Dermatology',
    dateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: AppointmentStatus.cancelled,
  ),
  Appointment(
    id: '6',
    patientName: 'Youssef Ibrahim',
    doctorName: 'Dr. Karim Saad',
    department: 'Orthopedics',
    dateTime: DateTime.now().add(const Duration(days: 2)),
    status: AppointmentStatus.upcoming,
  ),
];