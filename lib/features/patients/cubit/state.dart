part of 'cubit.dart';

enum PatientsStatus {
  initial,
  loading,
  loaded,
  error,
  actionLoading,
  actionSuccess,
  actionError,
}

class PatientsState extends Equatable {
  final PatientsStatus status;
  final List<PatientModel> patients;
  final String? errorMessage;

  const PatientsState({
    this.status = PatientsStatus.initial,
    this.patients = const [],
    this.errorMessage,
  });

  PatientsState copyWith({
    PatientsStatus? status,
    List<PatientModel>? patients,
    String? errorMessage,
  }) {
    return PatientsState(
      status: status ?? this.status,
      patients: patients ?? this.patients,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, patients, errorMessage];
}