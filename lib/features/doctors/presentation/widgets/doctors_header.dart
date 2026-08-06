import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class DoctorsHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onAddDoctor;

  const DoctorsHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onAddDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: onAddDoctor,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Doctor'),
        ),
      ],
    );
  }
}
