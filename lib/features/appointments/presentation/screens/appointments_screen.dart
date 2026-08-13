import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/features/appointments/cubit/cubit.dart';
import 'package:medidesk_app/features/appointments/cubit/state.dart';
import 'package:medidesk_app/features/appointments/data/appointments_repository.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart';

import 'package:medidesk_app/features/appointments/presentation/widgets/appointment_search_bar.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_header.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_table.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentsCubit(
        context.read<AppointmentsRepository>(),
      )..loadAppointments(),
      child: const _AppointmentsView(),
    );
  }
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentsCubit>();

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentsHeader(
            onCreatePressed: () {
              _showCreateAppointmentDialog(
                context,
                cubit,
              );
            },
          ),

          const SizedBox(height: 24),

          BlocBuilder<AppointmentsCubit, AppointmentsState>(
            buildWhen: (_, state) =>
                state is AppointmentsLoaded ||
                state is AppointmentsInitial,
            builder: (context, state) {
              const AppointmentStatus? selectedStatus = null;

              return AppointmentSearchBar(
                onSearchChanged: cubit.search,
                selectedStatus: selectedStatus,
                onStatusChanged: cubit.filterByStatus,
              );
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
              builder: (context, state) {
                if (state is AppointmentsLoading ||
                    state is AppointmentsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is AppointmentsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is AppointmentsLoaded) {
                  return AppointmentsTable(
                    appointments: state.appointments,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateAppointmentDialog(
    BuildContext context,
    AppointmentsCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return _CreateAppointmentDialog(
          cubit: cubit,
        );
      },
    );
  }
}

// ============================================================
// CREATE APPOINTMENT DIALOG
// ============================================================

class _CreateAppointmentDialog extends StatefulWidget {
  final AppointmentsCubit cubit;

  const _CreateAppointmentDialog({
    required this.cubit,
  });

  @override
  State<_CreateAppointmentDialog> createState() =>
      _CreateAppointmentDialogState();
}

class _CreateAppointmentDialogState
    extends State<_CreateAppointmentDialog> {
  final patientIdController = TextEditingController();
  final doctorIdController = TextEditingController();
  final departmentIdController = TextEditingController();
  final scheduleIdController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final notesController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    patientIdController.dispose();
    doctorIdController.dispose();
    departmentIdController.dispose();
    scheduleIdController.dispose();
    dateController.dispose();
    timeController.dispose();
    notesController.dispose();

    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(
        now.year + 1,
        now.month,
        now.day,
      ),
    );

    if (date == null) return;

    dateController.text =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 8,
        minute: 0,
      ),
    );

    if (time == null) return;

    timeController.text =
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:00';
  }

  Future<void> _createAppointment() async {
    final patientId = int.tryParse(
      patientIdController.text.trim(),
    );

    final doctorId = int.tryParse(
      doctorIdController.text.trim(),
    );

    final departmentId = int.tryParse(
      departmentIdController.text.trim(),
    );

    final scheduleId = int.tryParse(
      scheduleIdController.text.trim(),
    );

    if (patientId == null ||
        doctorId == null ||
        departmentId == null ||
        scheduleId == null) {
      _showMessage(
        'Please enter valid Patient, Doctor, Department and Schedule IDs.',
      );
      return;
    }

    if (dateController.text.trim().isEmpty) {
      _showMessage(
        'Please select appointment date.',
      );
      return;
    }

    if (timeController.text.trim().isEmpty) {
      _showMessage(
        'Please select appointment time.',
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final appointmentId =
        await widget.cubit.createAppointment(
      patientId: patientId,
      doctorId: doctorId,
      departmentId: departmentId,
      scheduleId: scheduleId,
      appointmentDate: dateController.text.trim(),
      appointmentTime: timeController.text.trim(),
      notes: notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (appointmentId != null) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment created successfully. ID: $appointmentId',
          ),
        ),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Create Appointment',
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: patientIdController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  'Patient ID',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: doctorIdController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  'Doctor ID',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: departmentIdController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  'Department ID',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: scheduleIdController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  'Schedule ID',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: _inputDecoration(
                  'Appointment Date',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: timeController,
                readOnly: true,
                onTap: _pickTime,
                decoration: _inputDecoration(
                  'Appointment Time',
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: _inputDecoration(
                  'Notes',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: loading
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: loading
              ? null
              : _createAppointment,
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Create Appointment',
                ),
        ),
      ],
    );
  }
}