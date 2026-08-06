import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class DepartmentsHeader extends StatelessWidget {
  final VoidCallback? onAddDepartment;

  const DepartmentsHeader({super.key, this.onAddDepartment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Departments',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Organize hospital services by department.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: onAddDepartment,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Department'),
        ),
      ],
    );
  }
}
