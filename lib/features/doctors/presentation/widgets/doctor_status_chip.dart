import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum DoctorAvailability { available, onLeave, busy }

class DoctorStatusChip extends StatelessWidget {
  final DoctorAvailability status;

  const DoctorStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      DoctorAvailability.available => (
          'Available',
          AppColors.success,
          AppColors.successBg,
        ),
      DoctorAvailability.busy => (
          'In Clinic',
          AppColors.warning,
          AppColors.warningBg,
        ),
      DoctorAvailability.onLeave => (
          'On Leave',
          AppColors.textSecondary,
          AppColors.chipBackground,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
