import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/departments/cubit/cubit.dart';
import 'package:medidesk_app/features/departments/data/department_repository.dart';
import 'package:medidesk_app/features/departments/data/models/department_model.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_card.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_stats_grid.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_status_chip.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_header.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_list.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/departments_toolbar.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentsCubit(
        departmentRepository: DepartmentRepository(dioClient: DioClient()),
      )..fetchDepartments(),
      child: const _DepartmentsView(),
    );
  }
}

class _DepartmentsView extends StatefulWidget {
  const _DepartmentsView();

  @override
  State<_DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<_DepartmentsView> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  DepartmentCardData _mapToCardData(DepartmentModel model) {
  return DepartmentCardData(
    id: model.id?.toString() ?? '',
    name: model.name,
    description: model.description,
    headDoctor: 'Not assigned',
    doctorCount: 0,
    activePatients: 0,
    status: DepartmentStatus.active,
  );
}

  List<DepartmentCardData> _filterDepartments(
    List<DepartmentCardData> departments,
  ) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return departments;
    return departments.where((department) {
      return department.name.toLowerCase().contains(query) ||
          department.headDoctor.toLowerCase().contains(query) ||
          department.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentsCubit, DepartmentsState>(
      builder: (context, state) {
        final isLoading = state.status == DepartmentsStatus.loading;
        final hasError = state.status == DepartmentsStatus.error;
        final cardDepartments = state.departments.map(_mapToCardData).toList();
        final filteredDepartments = _filterDepartments(cardDepartments);

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
                                      .read<DepartmentsCubit>()
                                      .fetchDepartments(),
                                  child: const Text('إعادة المحاولة'),
                                ),
                              ],
                            ),
                          )
                        : DepartmentsList(
                            departments: filteredDepartments,
                            onDepartmentTap: (_) {},
                            onDepartmentEdit: (_) {},
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}