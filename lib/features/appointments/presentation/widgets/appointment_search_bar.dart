import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/appointments/presentation/models/appointment.dart';

/// Search field + status filter dropdown used above the appointments table.
class AppointmentSearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final AppointmentStatus? selectedStatus;
  final ValueChanged<AppointmentStatus?> onStatusChanged;

  const AppointmentSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search by patient or doctor name...',
              prefixIcon: Icon(Icons.search, size: 20, color: AppColors.textTertiary),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AppointmentStatus?>(
              value: selectedStatus,
              hint: const Text(
                'All statuses',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
              items: [
                const DropdownMenuItem<AppointmentStatus?>(
                  value: null,
                  child: Text('All statuses'),
                ),
                ...AppointmentStatus.values.map(
                  (status) => DropdownMenuItem<AppointmentStatus?>(
                    value: status,
                    child: Text(status.label),
                  ),
                ),
              ],
              onChanged: onStatusChanged,
            ),
          ),
        ),
      ],
    );
  }
}