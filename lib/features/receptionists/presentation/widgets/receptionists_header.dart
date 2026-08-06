import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class ReceptionistsHeader extends StatelessWidget {
  final VoidCallback? onAddReceptionist;

  const ReceptionistsHeader({super.key, this.onAddReceptionist});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Receptionists',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage front-desk staff accounts.',
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
          onPressed: onAddReceptionist,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Receptionist'),
        ),
      ],
    );
  }
}
