import 'package:flutter/material.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_filter.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_search_bar.dart';

class DoctorsToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final List<String> filterOptions;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const DoctorsToolbar({
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
        DoctorSearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),
        DoctorFilter(
          options: filterOptions,
          selected: selectedFilter,
          onSelected: onFilterSelected,
        ),
      ],
    );
  }
}
