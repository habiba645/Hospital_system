import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/dashboard_panels.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/dashboard_section_card.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/dashboard_stats_grid.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/quick_actions_grid.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/recent_activity_list.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/today_appointments_list.dart';

class ReceptionDashboardScreen extends StatelessWidget {
  const ReceptionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeader(
            title: 'Front Desk',
            subtitle:
                "Here's what's happening at the front desk today.",
          ),
          const SizedBox(height: 32),
          DashboardStatsGrid(items: defaultReceptionStats),
          const SizedBox(height: 24),
          DashboardPanels(
            activity: defaultReceptionActivities,
            appointments: defaultTodayAppointments,
            onViewAllActivity: () {},
            onViewAllAppointments: () =>
                context.go('/reception/appointments'),
          ),
          const SizedBox(height: 24),
          DashboardSectionCard(
            title: 'Quick Actions',
            child: QuickActionsGrid(
              actions: [
                QuickActionData(
                  label: 'Register Patient',
                  description: 'Add a new patient record',
                  icon: Icons.person_add_outlined,
                  iconColor: AppColors.primary,
                  iconBackground: AppColors.sidebarActive,
                  onTap: () => context.go('/reception/patients'),
                ),
                QuickActionData(
                  label: 'Book Appointment',
                  description: 'Schedule a new visit',
                  icon: Icons.event_available_outlined,
                  iconColor: AppColors.secondary,
                  iconBackground: AppColors.departmentChip,
                  onTap: () => context.go('/reception/appointments'),
                ),
                QuickActionData(
                  label: "Today's Schedule",
                  description: 'View appointments for today',
                  icon: Icons.today_outlined,
                  iconColor: AppColors.warning,
                  iconBackground: AppColors.warningBg,
                  onTap: () => context.go('/reception/today'),
                ),
                QuickActionData(
                  label: 'Weekly Schedule',
                  description: 'Browse the week ahead',
                  icon: Icons.date_range_outlined,
                  iconColor: AppColors.info,
                  iconBackground: AppColors.infoBg,
                  onTap: () => context.go('/reception/weekly'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
