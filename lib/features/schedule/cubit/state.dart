import 'package:medidesk_app/features/schedule/data/models/schedule_models.dart';

sealed class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

class ScheduleLoaded extends ScheduleState {
  final List<DoctorDaySchedule> todaySchedules;
  final List<WeeklyAppointment> weeklyAppointments;

  const ScheduleLoaded({
    required this.todaySchedules,
    required this.weeklyAppointments,
  });
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);
}