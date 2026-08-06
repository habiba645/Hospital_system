import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class PatientsHeader extends StatelessWidget {
  final VoidCallback? onAddPatient;

  const PatientsHeader({super.key, this.onAddPatient});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patients',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Register new patients and look up existing records.',
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
          onPressed: onAddPatient,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Patient'),
        ),
      ],
    );
  }
}
