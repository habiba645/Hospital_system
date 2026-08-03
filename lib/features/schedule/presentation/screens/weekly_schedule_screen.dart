import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class WeeklyScheduleScreen extends StatelessWidget {
  const WeeklyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly schedule',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          SizedBox(height: 4),
          Text('Week view of appointments across all doctors.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          SizedBox(height: 48),
          Expanded(
            child: Center(
              child: Text('Weekly schedule grid UI goes here',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}
