import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

enum AppointmentPreviewStatus { upcoming, completed, cancelled }

class AppointmentPreviewData {
  final String patientName;
  final String doctorName;
  final String department;
  final String timeLabel;
  final AppointmentPreviewStatus status;

  const AppointmentPreviewData({
    required this.patientName,
    required this.doctorName,
    required this.department,
    required this.timeLabel,
    required this.status,
  });
}

class AppointmentStatusChip extends StatelessWidget {
  final AppointmentPreviewStatus status;

  const AppointmentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      AppointmentPreviewStatus.upcoming => (
          'Upcoming',
          AppColors.upcoming,
          AppColors.upcomingBg,
        ),
      AppointmentPreviewStatus.completed => (
          'Completed',
          AppColors.completed,
          AppColors.completedBg,
        ),
      AppointmentPreviewStatus.cancelled => (
          'Cancelled',
          AppColors.cancelled,
          AppColors.cancelledBg,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class AppointmentPreviewItem extends StatelessWidget {
  final AppointmentPreviewData appointment;
  final bool showDivider;

  const AppointmentPreviewItem({
    super.key,
    required this.appointment,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(appointment.patientName),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patientName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${appointment.doctorName} · ${appointment.department}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    appointment.timeLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppointmentStatusChip(status: appointment.status),
                ],
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class TodayAppointmentsList extends StatelessWidget {
  final List<AppointmentPreviewData> appointments;

  const TodayAppointmentsList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No appointments scheduled for today',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < appointments.length; i++)
          AppointmentPreviewItem(
            appointment: appointments[i],
            showDivider: i < appointments.length - 1,
          ),
      ],
    );
  }
}

List<AppointmentPreviewData> get defaultTodayAppointments => const [
      AppointmentPreviewData(
        patientName: 'James Wilson',
        doctorName: 'Dr. Nora Patel',
        department: 'Cardiology',
        timeLabel: '09:30',
        status: AppointmentPreviewStatus.completed,
      ),
      AppointmentPreviewData(
        patientName: 'Mia Thompson',
        doctorName: 'Dr. Liam Brooks',
        department: 'Pediatrics',
        timeLabel: '10:15',
        status: AppointmentPreviewStatus.upcoming,
      ),
      AppointmentPreviewData(
        patientName: 'Omar Hassan',
        doctorName: 'Dr. Ava Kim',
        department: 'Dermatology',
        timeLabel: '11:00',
        status: AppointmentPreviewStatus.upcoming,
      ),
      AppointmentPreviewData(
        patientName: 'Sofia Reyes',
        doctorName: 'Dr. Ethan Cole',
        department: 'Orthopedics',
        timeLabel: '13:45',
        status: AppointmentPreviewStatus.cancelled,
      ),
    ];
