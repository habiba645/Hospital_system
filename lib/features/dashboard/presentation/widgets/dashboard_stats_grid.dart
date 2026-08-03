import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/statistics_card.dart';

class DashboardStatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String? trendLabel;
  final bool? trendUp;

  const DashboardStatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.trendLabel,
    this.trendUp,
  });
}

class DashboardStatsGrid extends StatelessWidget {
  final List<DashboardStatItem> items;

  const DashboardStatsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 1100
            ? 4
            : width >= 720
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
                    trendLabel: item.trendLabel,
                    trendUp: item.trendUp,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

/// Default admin overview stats used by the dashboard screen.
List<DashboardStatItem> get defaultAdminStats => const [
      DashboardStatItem(
        label: 'Total Doctors',
        value: '48',
        icon: Icons.medical_services_outlined,
        iconColor: AppColors.primary,
        iconBackground: AppColors.sidebarActive,
        trendLabel: '+3',
        trendUp: true,
      ),
      DashboardStatItem(
        label: 'Departments',
        value: '12',
        icon: Icons.apartment_outlined,
        iconColor: AppColors.secondary,
        iconBackground: AppColors.departmentChip,
        trendLabel: '+1',
        trendUp: true,
      ),
      DashboardStatItem(
        label: 'Receptionists',
        value: '16',
        icon: Icons.people_outline,
        iconColor: AppColors.info,
        iconBackground: AppColors.infoBg,
        trendLabel: '0',
        trendUp: true,
      ),
      DashboardStatItem(
        label: "Today's Appointments",
        value: '127',
        icon: Icons.calendar_month_outlined,
        iconColor: AppColors.warning,
        iconBackground: AppColors.warningBg,
        trendLabel: '+12%',
        trendUp: true,
      ),
    ];
