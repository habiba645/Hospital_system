// cubit/cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:medidesk_app/features/patients/data/models/patient_model.dart';
import 'package:medidesk_app/features/patients/data/patient_repository.dart';

part 'state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  final PatientRepository patientRepository;

  PatientsCubit({required this.patientRepository}) : super(const PatientsState());

  Future<void> fetchPatients() async {
    emit(state.copyWith(status: PatientsStatus.loading));
    try {
      final patients = await patientRepository.getAllPatients();
      emit(state.copyWith(status: PatientsStatus.loaded, patients: patients));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.error,
        errorMessage: e.response?.data['message'] ?? 'حدث خطأ أثناء تحميل المرضى',
      ));
    } catch (e) {
      emit(state.copyWith(status: PatientsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addPatient(PatientModel patient) async {
    emit(state.copyWith(status: PatientsStatus.actionLoading));
    try {
      final newId = await patientRepository.addPatient(patient);
      final newPatient = patient.copyWith(id: newId);
      final updatedList = List<PatientModel>.from(state.patients)..add(newPatient);
      emit(state.copyWith(status: PatientsStatus.actionSuccess, patients: updatedList));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.actionError,
        errorMessage: e.response?.data['error'] ?? e.response?.data['message'] ?? 'حدث خطأ أثناء إضافة المريض',
      ));
    } catch (e) {
      emit(state.copyWith(status: PatientsStatus.actionError, errorMessage: e.toString()));
    }
  }

  Future<void> deletePatient(int id) async {
    emit(state.copyWith(status: PatientsStatus.actionLoading));
    try {
      await patientRepository.deletePatient(id);
      final updatedList = state.patients.where((p) => p.id != id).toList();
      emit(state.copyWith(status: PatientsStatus.actionSuccess, patients: updatedList));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.actionError,
        errorMessage: e.response?.data['message'] ?? 'حدث خطأ أثناء حذف المريض',
      ));
    } catch (e) {
      emit(state.copyWith(status: PatientsStatus.actionError, errorMessage: e.toString()));
    }
  }
}