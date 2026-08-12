import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/appointments/presentation/models/appointment.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointment_row.dart';

/// Card containing the column headers + the list of [AppointmentRow]s.
class AppointmentsTable extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentsTable({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const _TableHeader(),
          const Divider(height: 1),
          Expanded(
            child: appointments.isEmpty
                ? const Center(
                    child: Text(
                      'No appointments match your search.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: appointments.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) => AppointmentRow(appointment: appointments[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.textTertiary,
      letterSpacing: 0.3,
    );
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          SizedBox(width: 36),
          SizedBox(width: 12),
          Expanded(flex: 3, child: Text('PATIENT', style: style)),
          Expanded(flex: 2, child: Text('DEPARTMENT', style: style)),
          Expanded(flex: 3, child: Text('DATE & TIME', style: style)),
          Expanded(flex: 2, child: Text('STATUS', style: style)),
          SizedBox(width: 72),
        ],
      ),
    );
  }
}