import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class TodayScheduleScreen extends StatelessWidget {
  const TodayScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's schedule",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          SizedBox(height: 4),
          Text('Timeline view of today’s appointments per doctor.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          SizedBox(height: 48),
          Expanded(
            child: Center(
              child: Text('Today schedule / timeline UI goes here',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}
