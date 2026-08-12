import 'package:flutter/material.dart';
import 'package:medidesk_app/features/appointments/presentation/models/appointment.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointment_status_style.dart';

/// Small pill showing an appointment's status with its themed color.
class AppointmentStatusChip extends StatelessWidget {
  final AppointmentStatus status;

  const AppointmentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}