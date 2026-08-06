import 'package:flutter/material.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_card.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_stats_grid.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_header.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_list.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_toolbar.dart';

class DepartmentsScreen extends StatefulWidget {
  const DepartmentsScreen({super.key});

  @override
  State<DepartmentsScreen> createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  final _searchController = TextEditingController();
  late final List<DepartmentCardData> _allDepartments;

  String _query = '';

  @override
  void initState() {
    super.initState();
    _allDepartments = sampleDepartments;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DepartmentCardData> get _filteredDepartments {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return _allDepartments;
    return _allDepartments.where((department) {
      return department.name.toLowerCase().contains(query) ||
          department.headDoctor.toLowerCase().contains(query) ||
          department.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DepartmentsHeader(onAddDepartment: () {}),
          const SizedBox(height: 24),
          DepartmentStatsGrid(items: defaultDepartmentStats),
          const SizedBox(height: 24),
          DepartmentsToolbar(
            searchController: _searchController,
            onSearchChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: DepartmentsList(
              departments: _filteredDepartments,
              onDepartmentTap: (_) {},
              onDepartmentEdit: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
