import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/patients/cubit/cubit.dart';
import 'package:medidesk_app/features/patients/data/models/patient_model.dart';
import 'package:medidesk_app/features/patients/data/patient_repository.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_card.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_status_chip.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_header.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_list.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_toolbar.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientsCubit(
        patientRepository: PatientRepository(dioClient: DioClient()),
      )..fetchPatients(),
      child: const _PatientsView(),
    );
  }
}

class _PatientsView extends StatefulWidget {
  const _PatientsView();

  @override
  State<_PatientsView> createState() => _PatientsViewState();
}

class _PatientsViewState extends State<_PatientsView> {
  static const _allFilter = 'All';

  final _searchController = TextEditingController();
  late final List<String> _filterOptions;

  String _query = '';
  String _selectedFilter = _allFilter;

  @override
  void initState() {
    super.initState();
    _filterOptions = [_allFilter, 'Active', 'Inactive', 'New'];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _statusLabel(PatientStatus status) => switch (status) {
        PatientStatus.active => 'Active',
        PatientStatus.inactive => 'Inactive',
        PatientStatus.newPatient => 'New',
      };

  int _calculateAge(String dateOfBirth) {
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      var age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return 0;
    }
  }

  PatientCardData _mapToCardData(PatientModel model) {
    return PatientCardData(
      id: model.id?.toString() ?? '',
      name: model.fullName,
      ageGender: '${_calculateAge(model.dateOfBirth)} · ${model.gender}',
      phone: model.phone,
      email: model.address,
      lastVisit: '-',
      status: PatientStatus.active,
    );
  }

  List<PatientCardData> _filterPatients(List<PatientCardData> patients) {
    final query = _query.trim().toLowerCase();
    return patients.where((patient) {
      final matchesFilter = _selectedFilter == _allFilter ||
          _statusLabel(patient.status) == _selectedFilter;
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return patient.name.toLowerCase().contains(query) ||
          patient.phone.toLowerCase().contains(query) ||
          patient.email.toLowerCase().contains(query);
    }).toList();
  }

  void _showAddPatientDialog(BuildContext context) {
    final cubit = context.read<PatientsCubit>();
    final formKey = GlobalKey<FormState>();
    final fullNameController = TextEditingController();
    final nationalIdController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final dobController = TextEditingController();
    String gender = 'Male';
    String bloodType = 'O+';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Add Patient'),
              content: SizedBox(
                width: 420,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: fullNameController,
                          decoration:
                              const InputDecoration(labelText: 'Full Name'),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: nationalIdController,
                          decoration:
                              const InputDecoration(labelText: 'National ID'),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: gender,
                          decoration:
                              const InputDecoration(labelText: 'Gender'),
                          items: const [
                            DropdownMenuItem(
                                value: 'Male', child: Text('Male')),
                            DropdownMenuItem(
                                value: 'Female', child: Text('Female')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => gender = value);
                            }
                          },
                        ),
                        TextFormField(
                          controller: dobController,
                          decoration: const InputDecoration(
                            labelText: 'Date of Birth (YYYY-MM-DD)',
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration:
                              const InputDecoration(labelText: 'Phone'),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: bloodType,
                          decoration:
                              const InputDecoration(labelText: 'Blood Type'),
                          items: const [
                            'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'
                          ]
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => bloodType = value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    cubit.addPatient(
                      PatientModel(
                        fullName: fullNameController.text.trim(),
                        nationalId: nationalIdController.text.trim(),
                        gender: gender,
                        dateOfBirth: dobController.text.trim(),
                        phone: phoneController.text.trim(),
                        address: addressController.text.trim(),
                        bloodType: bloodType,
                      ),
                    );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientsCubit, PatientsState>(
      listener: (context, state) {
        if (state.status == PatientsStatus.actionError &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
        if (state.status == PatientsStatus.actionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تمت العملية بنجاح')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == PatientsStatus.loading;
        final hasError = state.status == PatientsStatus.error;
        final cardPatients = state.patients.map(_mapToCardData).toList();
        final filteredPatients = _filterPatients(cardPatients);

        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PatientsHeader(
                onAddPatient: () => _showAddPatientDialog(context),
              ),
              const SizedBox(height: 24),
              PatientsToolbar(
                searchController: _searchController,
                onSearchChanged: (value) => setState(() => _query = value),
                filterOptions: _filterOptions,
                selectedFilter: _selectedFilter,
                onFilterSelected: (value) =>
                    setState(() => _selectedFilter = value),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : hasError
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(state.errorMessage ?? 'حدث خطأ'),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<PatientsCubit>()
                                      .fetchPatients(),
                                  child: const Text('إعادة المحاولة'),
                                ),
                              ],
                            ),
                          )
                        : PatientsList(
                            patients: filteredPatients,
                            onPatientTap: (_) {},
                            onPatientEdit: (_) {},
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}