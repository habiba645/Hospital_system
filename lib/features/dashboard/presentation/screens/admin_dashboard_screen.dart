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

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeader(
            title: 'Overview',
            subtitle:
                'A snapshot of hospital activity, doctors, and today’s appointments.',
          ),
          const SizedBox(height: 32),
          DashboardStatsGrid(items: defaultAdminStats),
          const SizedBox(height: 24),
          DashboardPanels(
            activity: defaultRecentActivities,
            appointments: defaultTodayAppointments,
            onViewAllActivity: () {},
            onViewAllAppointments: () {},
          ),
          const SizedBox(height: 24),
          DashboardSectionCard(
            title: 'Quick Actions',
            child: QuickActionsGrid(
              actions: [
                QuickActionData(
                  label: 'Add Doctor',
                  description: 'Create a new doctor profile',
                  icon: Icons.medical_services_outlined,
                  iconColor: AppColors.primary,
                  iconBackground: AppColors.sidebarActive,
                  onTap: () => context.go('/admin/doctors'),
                ),
                QuickActionData(
                  label: 'Manage Departments',
                  description: 'Organize hospital services',
                  icon: Icons.apartment_outlined,
                  iconColor: AppColors.secondary,
                  iconBackground: AppColors.departmentChip,
                  onTap: () => context.go('/admin/departments'),
                ),
                QuickActionData(
                  label: 'Reception Staff',
                  description: 'View and assign receptionists',
                  icon: Icons.people_outline,
                  iconColor: AppColors.info,
                  iconBackground: AppColors.infoBg,
                  onTap: () => context.go('/admin/receptionists'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
