import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart';

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.scheduled:
        return 'Upcoming';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case AppointmentStatus.scheduled:
        return AppColors.upcoming;
      case AppointmentStatus.completed:
        return AppColors.completed;
      case AppointmentStatus.cancelled:
        return AppColors.cancelled;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AppointmentStatus.scheduled:
        return AppColors.upcomingBg;
      case AppointmentStatus.completed:
        return AppColors.completedBg;
      case AppointmentStatus.cancelled:
        return AppColors.cancelledBg;
    }
  }
}