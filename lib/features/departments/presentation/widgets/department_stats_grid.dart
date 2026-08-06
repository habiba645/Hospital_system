import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/statistics_card.dart';

class DepartmentStatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  const DepartmentStatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });
}

class DepartmentStatsGrid extends StatelessWidget {
  final List<DepartmentStatItem> items;

  const DepartmentStatsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 960
            ? 3
            : width >= 560
                ? 2
                : 1;
        const spacing = 16.0;
        final itemWidth =
            (width - spacing * (crossAxisCount - 1)) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: itemWidth,
                  child: StatisticsCard(
                    label: item.label,
                    value: item.value,
                    icon: item.icon,
                    iconColor: item.iconColor,
                    iconBackground: item.iconBackground,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

/// Summary stats shown above the departments list.
List<DepartmentStatItem> get defaultDepartmentStats => const [
      DepartmentStatItem(
        label: 'Total Departments',
        value: '12',
        icon: Icons.apartment_outlined,
        iconColor: AppColors.primary,
        iconBackground: AppColors.sidebarActive,
      ),
      DepartmentStatItem(
        label: 'Active Doctors',
        value: '48',
        icon: Icons.medical_services_outlined,
        iconColor: AppColors.secondary,
        iconBackground: AppColors.departmentChip,
      ),
      DepartmentStatItem(
        label: 'Active Patients',
        value: '1,284',
        icon: Icons.people_outline,
        iconColor: AppColors.info,
        iconBackground: AppColors.infoBg,
      ),
    ];
