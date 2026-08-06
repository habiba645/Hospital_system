import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum DepartmentStatus { active, inactive }

class DepartmentStatusChip extends StatelessWidget {
  final DepartmentStatus status;

  const DepartmentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      DepartmentStatus.active => (
          'Active',
          AppColors.success,
          AppColors.successBg,
        ),
      DepartmentStatus.inactive => (
          'Inactive',
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
