import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum PatientStatus { active, inactive, newPatient }

class PatientStatusChip extends StatelessWidget {
  final PatientStatus status;

  const PatientStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      PatientStatus.active => (
          'Active',
          AppColors.success,
          AppColors.successBg,
        ),
      PatientStatus.inactive => (
          'Inactive',
          AppColors.textSecondary,
          AppColors.chipBackground,
        ),
      PatientStatus.newPatient => (
          'New',
          AppColors.info,
          AppColors.infoBg,
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
