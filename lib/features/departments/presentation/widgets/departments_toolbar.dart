import 'package:flutter/material.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_search_bar.dart';

class DepartmentsToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const DepartmentsToolbar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DepartmentSearchBar(
      controller: searchController,
      onChanged: onSearchChanged,
    );
  }
}
