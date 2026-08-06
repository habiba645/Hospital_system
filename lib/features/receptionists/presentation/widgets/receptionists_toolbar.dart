import 'package:flutter/material.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_filter.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_search_bar.dart';

class ReceptionistsToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final List<String> filterOptions;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const ReceptionistsToolbar({
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
        ReceptionistSearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),
        ReceptionistFilter(
          options: filterOptions,
          selected: selectedFilter,
          onSelected: onFilterSelected,
        ),
      ],
    );
  }
}
