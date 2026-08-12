import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/features/appointments/cubit/state.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart';
import 'package:medidesk_app/features/appointments/data/appointments_repository.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsRepository _repository;

  String _query = '';
  AppointmentStatus? _statusFilter;
  int _page = 1;

  static const _limit = 20;

  AppointmentsCubit(this._repository)
      : super(const AppointmentsInitial());

  Future<void> loadAppointments({bool resetPage = true}) async {
    if (resetPage) {
      _page = 1;
    }

    emit(const AppointmentsLoading());
    await _fetch();
  }

  Future<void> search(String query) async {
    _query = query;
    _page = 1;

    emit(const AppointmentsLoading());
    await _fetch();
  }

  Future<void> filterByStatus(AppointmentStatus? status) async {
    _statusFilter = status;
    _page = 1;

    emit(const AppointmentsLoading());
    await _fetch();
  }

  Future<void> loadPage(int page) async {
    _page = page;

    emit(const AppointmentsLoading());
    await _fetch();
  }

  Future<void> cancelAppointment(int id) async {
    final previous = state;

    try {
      await _repository.updateAppointmentStatus(
        id,
        AppointmentStatus.cancelled,
      );

      await _fetch(
        silent: previous is AppointmentsLoaded,
      );
    } on DioException catch (e) {
      emit(AppointmentsError(_errorMessage(e)));
    }
  }

  Future<void> _fetch({bool silent = false}) async {
    if (silent && state is AppointmentsLoaded) {
      emit(
        (state as AppointmentsLoaded).copyWith(
          isRefreshing: true,
        ),
      );
    }

    try {
      final page = await _repository.getAppointments(
        page: _page,
        limit: _limit,
        status: _statusFilter?.apiValue,
        search: _query.isEmpty ? null : _query,
      );

      emit(
        AppointmentsLoaded.fromPage(
          page,
          query: _query,
          statusFilter: _statusFilter,
        ),
      );
    } on DioException catch (e) {
      emit(AppointmentsError(_errorMessage(e)));
    }
  }

  String _errorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return 'Something went wrong. Please try again.';
  }
}