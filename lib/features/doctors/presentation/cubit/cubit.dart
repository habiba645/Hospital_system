// features/doctors/presentation/cubit/cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:medidesk_app/features/doctors/models/model.dart';
import 'package:medidesk_app/features/doctors/models/repo.dart';

part 'state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorRepository doctorRepository;

  DoctorsCubit({required this.doctorRepository}) : super(const DoctorsState());

  Future<void> fetchDoctors() async {
    emit(state.copyWith(status: DoctorsStatus.loading));
    try {
      final doctors = await doctorRepository.getAllDoctors();
      emit(state.copyWith(status: DoctorsStatus.loaded, doctors: doctors));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DoctorsStatus.error,
        errorMessage: e.response?.data['message'] ?? 'حدث خطأ أثناء تحميل الأطباء',
      ));
    } catch (e) {
      emit(state.copyWith(status: DoctorsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    emit(state.copyWith(status: DoctorsStatus.actionLoading));
    try {
      final newDoctor = await doctorRepository.addDoctor(doctor);
      final updatedList = List<DoctorModel>.from(state.doctors)..add(newDoctor);
      emit(state.copyWith(status: DoctorsStatus.actionSuccess, doctors: updatedList));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DoctorsStatus.actionError,
        errorMessage: e.response?.data['error'] ?? e.response?.data['message'] ?? 'حدث خطأ أثناء إضافة الطبيب',
      ));
    } catch (e) {
      emit(state.copyWith(status: DoctorsStatus.actionError, errorMessage: e.toString()));
    }
  }

  Future<void> updateDoctor(int id, DoctorModel doctor) async {
    emit(state.copyWith(status: DoctorsStatus.actionLoading));
    try {
      final updatedDoctor = await doctorRepository.updateDoctor(id, doctor);
      final updatedList = state.doctors
          .map((d) => d.id == id ? updatedDoctor : d)
          .toList();
      emit(state.copyWith(status: DoctorsStatus.actionSuccess, doctors: updatedList));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DoctorsStatus.actionError,
        errorMessage: e.response?.data['error'] ?? e.response?.data['message'] ?? 'حدث خطأ أثناء تعديل الطبيب',
      ));
    } catch (e) {
      emit(state.copyWith(status: DoctorsStatus.actionError, errorMessage: e.toString()));
    }
  }
}