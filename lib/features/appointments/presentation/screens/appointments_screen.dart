import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/features/appointments/cubit/cubit.dart';
import 'package:medidesk_app/features/appointments/cubit/state.dart';
import 'package:medidesk_app/features/appointments/data/appointments_repository.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart'
  ;
import 'package:medidesk_app/features/appointments/presentation/widgets/appointment_search_bar.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_header.dart';
import 'package:medidesk_app/features/appointments/presentation/widgets/appointments_table.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentsCubit>(
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
              // TODO: open the create-appointment flow.
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
}