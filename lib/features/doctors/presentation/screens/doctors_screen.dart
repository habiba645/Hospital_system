// features/doctors/presentation/screens/doctors_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidesk_app/core/network/dio_client.dart';

import 'package:medidesk_app/features/doctors/models/model.dart';
import 'package:medidesk_app/features/doctors/models/repo.dart';
import 'package:medidesk_app/features/doctors/presentation/cubit/cubit.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctorform.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_header.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_list.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_toolbar.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsCubit(
        doctorRepository: DoctorRepository(dioClient: DioClient()),
      )..fetchDoctors(),
      child: const _DoctorsView(),
    );
  }
}

class _DoctorsView extends StatefulWidget {
  const _DoctorsView();

  @override
  State<_DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<_DoctorsView> {
  static const _allFilter = 'All';

  final _searchController = TextEditingController();
  String _query = '';
  String _selectedFilter = _allFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DoctorModel> _filtered(List<DoctorModel> doctors) {
    final query = _query.trim().toLowerCase();
    return doctors.where((doctor) {
      final deptName = departmentNameForId(doctor.deptId);
      final matchesFilter = _selectedFilter == _allFilter || deptName == _selectedFilter;
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return doctor.fullName.toLowerCase().contains(query) ||
          doctor.specialization.toLowerCase().contains(query) ||
          deptName.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _openAddDialog() async {
    final cubit = context.read<DoctorsCubit>();
    final doctor = await showDoctorFormDialog(context);
    if (doctor != null) {
      await cubit.addDoctor(doctor);
    }
  }

  Future<void> _openEditDialog(DoctorModel doctor) async {
    final cubit = context.read<DoctorsCubit>();
    final updated = await showDoctorFormDialog(context, existing: doctor);
    if (updated != null && doctor.id != null) {
      await cubit.updateDoctor(doctor.id!, updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state.status == DoctorsStatus.actionError && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
        if (state.status == DoctorsStatus.actionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Saved successfully')),
          );
        }
      },
      builder: (context, state) {
        final filterOptions = [
          _allFilter,
          ...{for (final d in state.doctors) departmentNameForId(d.deptId)},
        ];
        final filteredDoctors = _filtered(state.doctors);
        final isBusy = state.status == DoctorsStatus.loading ||
            state.status == DoctorsStatus.actionLoading;

        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorsHeader(
                title: 'Doctors',
                subtitle: 'Manage doctor profiles, departments, and working hours.',
                onAddDoctor: isBusy ? null : _openAddDialog,
              ),
              const SizedBox(height: 24),
              DoctorsToolbar(
                searchController: _searchController,
                onSearchChanged: (value) => setState(() => _query = value),
                filterOptions: filterOptions,
                selectedFilter: _selectedFilter,
                onFilterSelected: (value) => setState(() => _selectedFilter = value),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: state.status == DoctorsStatus.loading && state.doctors.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : state.status == DoctorsStatus.error
                        ? Center(child: Text(state.errorMessage ?? 'Failed to load doctors'))
                        : DoctorsList(
                            doctors: filteredDoctors,
                            onDoctorTap: (_) {},
                            onDoctorEdit: _openEditDialog,
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}