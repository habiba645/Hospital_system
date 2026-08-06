import 'package:flutter/material.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_card.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_status_chip.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_header.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_list.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patients_toolbar.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  static const _allFilter = 'All';

  final _searchController = TextEditingController();
  late final List<PatientCardData> _allPatients;
  late final List<String> _filterOptions;

  String _query = '';
  String _selectedFilter = _allFilter;

  @override
  void initState() {
    super.initState();
    _allPatients = samplePatients;
    _filterOptions = [
      _allFilter,
      'Active',
      'Inactive',
      'New',
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PatientCardData> get _filteredPatients {
    final query = _query.trim().toLowerCase();
    return _allPatients.where((patient) {
      final matchesFilter = _selectedFilter == _allFilter ||
          _statusLabel(patient.status) == _selectedFilter;
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return patient.name.toLowerCase().contains(query) ||
          patient.phone.toLowerCase().contains(query) ||
          patient.email.toLowerCase().contains(query);
    }).toList();
  }

  String _statusLabel(PatientStatus status) => switch (status) {
        PatientStatus.active => 'Active',
        PatientStatus.inactive => 'Inactive',
        PatientStatus.newPatient => 'New',
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientsHeader(onAddPatient: () {}),
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
            child: PatientsList(
              patients: _filteredPatients,
              onPatientTap: (_) {},
              onPatientEdit: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
