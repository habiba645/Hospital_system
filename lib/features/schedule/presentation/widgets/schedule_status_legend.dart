import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/schedule/presentation/models/schedule_models.dart';

/// Small legend explaining what each status color means.
class ScheduleStatusLegend extends StatelessWidget {
  const ScheduleStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: SlotStatus.values
          .map(
            (status) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: status.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status.name[0].toUpperCase() + status.name.substring(1),
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}