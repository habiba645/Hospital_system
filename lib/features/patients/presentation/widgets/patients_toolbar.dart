import 'package:flutter/material.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_filter.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_search_bar.dart';

class PatientsToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final List<String> filterOptions;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const PatientsToolbar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.filterOptions,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PatientSearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),
        PatientFilter(
          options: filterOptions,
          selected: selectedFilter,
          onSelected: onFilterSelected,
        ),
      ],
    );
  }
}
