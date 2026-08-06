import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum ReceptionistStatus { active, inactive, onBreak }

class ReceptionistStatusChip extends StatelessWidget {
  final ReceptionistStatus status;

  const ReceptionistStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      ReceptionistStatus.active => (
          'Active',
          AppColors.success,
          AppColors.successBg,
        ),
      ReceptionistStatus.inactive => (
          'Inactive',
          AppColors.textSecondary,
          AppColors.chipBackground,
        ),
      ReceptionistStatus.onBreak => (
          'On Break',
          AppColors.warning,
          AppColors.warningBg,
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
