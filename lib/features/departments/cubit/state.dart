part of 'cubit.dart';

enum DepartmentsStatus { initial, loading, loaded, error }

class DepartmentsState extends Equatable {
  final DepartmentsStatus status;
  final List<DepartmentModel> departments;
  final String? errorMessage;

  const DepartmentsState({
    this.status = DepartmentsStatus.initial,
    this.departments = const [],
    this.errorMessage,
  });

  DepartmentsState copyWith({
    DepartmentsStatus? status,
    List<DepartmentModel>? departments,
    String? errorMessage,
  }) {
    return DepartmentsState(
      status: status ?? this.status,
      departments: departments ?? this.departments,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, departments, errorMessage];
}