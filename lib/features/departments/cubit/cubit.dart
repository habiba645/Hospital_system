import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:medidesk_app/features/departments/data/department_repository.dart';
import 'package:medidesk_app/features/departments/data/models/department_model.dart';

part 'state.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  final DepartmentRepository departmentRepository;

  DepartmentsCubit({required this.departmentRepository})
      : super(const DepartmentsState());

  Future<void> fetchDepartments() async {
    emit(state.copyWith(status: DepartmentsStatus.loading));
    try {
      final departments = await departmentRepository.getAllDepartments();
      emit(state.copyWith(
        status: DepartmentsStatus.loaded,
        departments: departments,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DepartmentsStatus.error,
        errorMessage:
            e.response?.data['message'] ?? 'حدث خطأ أثناء تحميل الأقسام',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DepartmentsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}