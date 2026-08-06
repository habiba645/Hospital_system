import 'package:flutter/material.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_card.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_header.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_list.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctors_toolbar.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  static const _allFilter = 'All';

  final _searchController = TextEditingController();
  late final List<DoctorCardData> _allDoctors;
  late final List<String> _filterOptions;

  String _query = '';
  String _selectedFilter = _allFilter;

  @override
  void initState() {
    super.initState();
    _allDoctors = sampleDoctors;
    final departments = _allDoctors.map((d) => d.department).toSet().toList()
      ..sort();
    _filterOptions = [_allFilter, ...departments];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DoctorCardData> get _filteredDoctors {
    final query = _query.trim().toLowerCase();
    return _allDoctors.where((doctor) {
      final matchesFilter = _selectedFilter == _allFilter ||
          doctor.department == _selectedFilter;
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return doctor.name.toLowerCase().contains(query) ||
          doctor.specialty.toLowerCase().contains(query) ||
          doctor.department.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorsHeader(
            title: 'Doctors',
            subtitle: 'Manage doctor profiles, departments, and working hours.',
            onAddDoctor: () {},
          ),
          const SizedBox(height: 24),
          DoctorsToolbar(
            searchController: _searchController,
            onSearchChanged: (value) => setState(() => _query = value),
            filterOptions: _filterOptions,
            selectedFilter: _selectedFilter,
            onFilterSelected: (value) =>
                setState(() => _selectedFilter = value),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: DoctorsList(
              doctors: _filteredDoctors,
              onDoctorTap: (_) {},
              onDoctorEdit: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
