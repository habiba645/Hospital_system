// features/doctors/presentation/cubit/state.dart
part of 'cubit.dart';

enum DoctorsStatus {
  initial,
  loading,
  loaded,
  error,
  actionLoading,
  actionSuccess,
  actionError,
}

class DoctorsState extends Equatable {
  final DoctorsStatus status;
  final List<DoctorModel> doctors;
  final String? errorMessage;

  const DoctorsState({
    this.status = DoctorsStatus.initial,
    this.doctors = const [],
    this.errorMessage,
  });

  DoctorsState copyWith({
    DoctorsStatus? status,
    List<DoctorModel>? doctors,
    String? errorMessage,
  }) {
    return DoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, doctors, errorMessage];
}