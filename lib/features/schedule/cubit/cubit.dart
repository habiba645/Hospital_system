import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medidesk_app/features/appointments/data/appointments_repository.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart' ;
import 'package:medidesk_app/features/schedule/data/models/schedule_models.dart';

import 'state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final AppointmentsRepository _appointmentsRepository;

  ScheduleCubit(this._appointmentsRepository)
      : super(const ScheduleInitial());

  Future<void> load() async {
    emit(const ScheduleLoading());

    try {
      final page = await _appointmentsRepository.getAppointments(
        page: 1,
        limit: 100,
      );

      final appointments = page.appointments;

      final today = DateTime.now();

      // Appointments for today
      final todayAppointments = appointments.where((appointment) {
        final date = appointment.dateTime.toLocal();

        return date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
      }).toList();

      final todaySchedules = _buildTodaySchedules(
        todayAppointments,
      );

      // Appointments for current week
      final weeklyAppointments = _buildWeeklyAppointments(
        appointments,
        today,
      );

      emit(
        ScheduleLoaded(
          todaySchedules: todaySchedules,
          weeklyAppointments: weeklyAppointments,
        ),
      );
    } on DioException catch (e) {
      emit(
        ScheduleError(
          _errorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        ScheduleError(
          'Failed to load schedule: $e',
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // TODAY
  // ─────────────────────────────────────────────

  List<DoctorDaySchedule> _buildTodaySchedules(
    List appointments,
  ) {
    final grouped = <String, List<ScheduleSlot>>{};

    final doctorDepartments = <String, String>{};

    for (final appointment in appointments) {
      final doctorName = appointment.doctorName;

      final startHour = _timeToHour(
        _extractTime(appointment.dateTime),
      );

      final slot = ScheduleSlot(
        patientName: appointment.patientName,
        startHour: startHour,
        endHour: startHour + 0.5,
        status: _mapStatus(
          appointment.status,
        ),
      );

      grouped
          .putIfAbsent(
            doctorName,
            () => <ScheduleSlot>[],
          )
          .add(slot);

      doctorDepartments[doctorName] =
          appointment.department;
    }

    return grouped.entries.map((entry) {
      final slots = entry.value
        ..sort(
          (a, b) => a.startHour.compareTo(b.startHour),
        );

      return DoctorDaySchedule(
        doctorName: entry.key,
        department: doctorDepartments[entry.key] ?? '',
        slots: slots,
      );
    }).toList();
  }

  // ─────────────────────────────────────────────
  // WEEKLY
  // ─────────────────────────────────────────────

  List<WeeklyAppointment> _buildWeeklyAppointments(
    List appointments,
    DateTime currentDate,
  ) {
    final startOfWeek = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    ).subtract(
      Duration(
        days: currentDate.weekday - 1,
      ),
    );

    final endOfWeek = startOfWeek.add(
      const Duration(days: 7),
    );

    return appointments
        .where((appointment) {
          final date = appointment.dateTime.toLocal();

          return !date.isBefore(startOfWeek) &&
              date.isBefore(endOfWeek);
        })
        .map(
          (appointment) {
            final date = appointment.dateTime.toLocal();

            final startHour = _timeToHour(
              _extractTime(appointment.dateTime),
            );

            return WeeklyAppointment(
              patientName: appointment.patientName,
              doctorName: appointment.doctorName,
              dayIndex: date.weekday - 1,
              startHour: startHour,
              endHour: startHour + 0.5,
              status: _mapStatus(
                appointment.status,
              ),
            );
          },
        )
        .toList();
  }

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  String _extractTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');

    return '$hour:$minute:$second';
  }

  double _timeToHour(String time) {
    final parts = time.split(':');

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return hour + (minute / 60);
  }

  SlotStatus _mapStatus(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.completed:
        return SlotStatus.completed;

      case AppointmentStatus.cancelled:
        return SlotStatus.cancelled;

      case AppointmentStatus.scheduled:
        return SlotStatus.upcoming;
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

    return 'Failed to load schedule. Please try again.';
  }
}