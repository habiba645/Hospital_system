import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

/// Page title + subtitle + "Create Appointment" action.
class AppointmentsHeader extends StatelessWidget {
  final VoidCallback onCreatePressed;

  const AppointmentsHeader({super.key, required this.onCreatePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointments',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Create, edit, and track patient bookings.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: onCreatePressed,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Create Appointment'),
        ),
      ],
    );
  }
}