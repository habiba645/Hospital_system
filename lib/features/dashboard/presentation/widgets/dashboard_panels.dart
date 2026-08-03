import 'package:flutter/material.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/dashboard_section_card.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/recent_activity_list.dart';
import 'package:medidesk_app/features/dashboard/presentation/widgets/today_appointments_list.dart';

class DashboardPanels extends StatelessWidget {
  final List<ActivityItemData> activity;
  final List<AppointmentPreviewData> appointments;
  final VoidCallback? onViewAllActivity;
  final VoidCallback? onViewAllAppointments;

  const DashboardPanels({
    super.key,
    required this.activity,
    required this.appointments,
    this.onViewAllActivity,
    this.onViewAllAppointments,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 960;

        final activityPanel = DashboardSectionCard(
          title: 'Recent Activity',
          actionLabel: 'View all',
          onAction: onViewAllActivity,
          child: RecentActivityList(items: activity),
        );

        final appointmentsPanel = DashboardSectionCard(
          title: "Today's Appointments",
          actionLabel: 'View all',
          onAction: onViewAllAppointments,
          child: TodayAppointmentsList(appointments: appointments),
        );

        if (!isWide) {
          return Column(
            children: [
              activityPanel,
              const SizedBox(height: 16),
              appointmentsPanel,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: activityPanel),
            const SizedBox(width: 16),
            Expanded(child: appointmentsPanel),
          ],
        );
      },
    );
  }
}
