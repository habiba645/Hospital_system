import 'package:equatable/equatable.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart';


abstract class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object?> get props => [];
}

class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial();
}

class AppointmentsLoading extends AppointmentsState {
  const AppointmentsLoading();
}

class AppointmentsLoaded extends AppointmentsState {
  final List<Appointment> appointments;
  final int page;
  final int totalPages;
  final int total;
  final String query;
  final AppointmentStatus? statusFilter;
  final bool isRefreshing;

  const AppointmentsLoaded({
    required this.appointments,
    required this.page,
    required this.totalPages,
    required this.total,
    this.query = '',
    this.statusFilter,
    this.isRefreshing = false,
  });

  factory AppointmentsLoaded.fromPage(
    AppointmentsPage page, {
    required String query,
    required AppointmentStatus? statusFilter,
    bool isRefreshing = false,
  }) {
    return AppointmentsLoaded(
      appointments: page.appointments,
      page: page.page,
      totalPages: page.totalPages,
      total: page.total,
      query: query,
      statusFilter: statusFilter,
      isRefreshing: isRefreshing,
    );
  }

  AppointmentsLoaded copyWith({
    List<Appointment>? appointments,
    int? page,
    int? totalPages,
    int? total,
    String? query,
    AppointmentStatus? statusFilter,
    bool clearStatusFilter = false,
    bool? isRefreshing,
  }) {
    return AppointmentsLoaded(
      appointments: appointments ?? this.appointments,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      query: query ?? this.query,
      statusFilter: clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [appointments, page, totalPages, total, query, statusFilter, isRefreshing];
}

class AppointmentsError extends AppointmentsState {
  final String message;

  const AppointmentsError(this.message);

  @override
  List<Object?> get props => [message];
}