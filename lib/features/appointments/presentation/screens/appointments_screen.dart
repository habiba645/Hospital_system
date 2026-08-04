import 'package:flutter/material.dart';
import 'package:medidesk_app/features/appointments/presentation/models/appointment.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointment_search_bar.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_header.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_table.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String _query = '';
  AppointmentStatus? _statusFilter;

  List<Appointment> get _filtered {
    return mockAppointments.where((appointment) {
      final matchesQuery = _query.isEmpty ||
          appointment.patientName.toLowerCase().contains(_query.toLowerCase()) ||
          appointment.doctorName.toLowerCase().contains(_query.toLowerCase());
      final matchesStatus = _statusFilter == null || appointment.status == _statusFilter;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentsHeader(
            onCreatePressed: () {
              // TODO: open the create-appointment flow once the backend/logic is wired up.
            },
          ),
          const SizedBox(height: 24),
          AppointmentSearchBar(
            onSearchChanged: (value) => setState(() => _query = value),
            selectedStatus: _statusFilter,
            onStatusChanged: (value) => setState(() => _statusFilter = value),
          ),
          const SizedBox(height: 20),
          Expanded(child: AppointmentsTable(appointments: _filtered)),
        ],
      ),
    );
  }
}