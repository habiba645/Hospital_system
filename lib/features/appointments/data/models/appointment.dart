
class AppointmentsPage {
  final List<Appointment> appointments;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const AppointmentsPage({
    required this.appointments,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory AppointmentsPage.fromJson(
    Map<String, dynamic> json,
  ) {
    final pagination =
        json['pagination'] as Map<String, dynamic>? ?? const {};

    return AppointmentsPage(
      appointments:
          (json['appointments'] as List<dynamic>? ?? [])
              .map(
                (e) => Appointment.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      total: pagination['total'] as int? ?? 0,
      page: pagination['page'] as int? ?? 1,
      limit: pagination['limit'] as int? ?? 20,
      totalPages: pagination['totalPages'] as int? ?? 0,
    );
  }
}


enum AppointmentStatus {
  scheduled,
  completed,
  cancelled,
}

extension AppointmentStatusApi on AppointmentStatus {
  static AppointmentStatus fromApi(String value) {
    switch (value.toLowerCase()) {
      case 'completed':
        return AppointmentStatus.completed;

      case 'cancelled':
      case 'canceled':
        return AppointmentStatus.cancelled;

      case 'scheduled':
      default:
        return AppointmentStatus.scheduled;
    }
  }

  String get apiValue {
    switch (this) {
      case AppointmentStatus.scheduled:
        return 'Scheduled';

      case AppointmentStatus.completed:
        return 'Completed';

      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class Appointment {
  final int id;
  final int patientId;
  final String patientName;

  final int doctorId;
  final String doctorName;

  final int departmentId;
  final String department;

  /// Contains the appointment date AND appointment time.
  final DateTime dateTime;

  final AppointmentStatus status;

  final int? bookedBy;
  final String? notes;
  final DateTime? createdAt;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.departmentId,
    required this.department,
    required this.dateTime,
    required this.status,
    this.bookedBy,
    this.notes,
    this.createdAt,
  });

  factory Appointment.fromJson(
    Map<String, dynamic> json,
  ) {
    /*
      Backend response:

      "appointment_date": "2026-08-14T21:00:00.000Z",
      "appointment_time": "10:30:00"

      We only take the DATE part from appointment_date,
      because appointment_time contains the actual appointment time.

      This also prevents UTC -> local timezone conversion
      from accidentally changing the appointment date.
    */

    final rawDate =
        json['appointment_date'] as String;

    final datePart =
        rawDate.split('T').first;

    final dateParts =
        datePart.split('-');

    final rawTime =
        json['appointment_time'] as String;

    final timeParts =
        rawTime.split(':');

    final year =
        int.parse(dateParts[0]);

    final month =
        int.parse(dateParts[1]);

    final day =
        int.parse(dateParts[2]);

    final hour =
        int.parse(timeParts[0]);

    final minute =
        int.parse(timeParts[1]);

    final second =
        timeParts.length > 2
            ? int.parse(timeParts[2])
            : 0;

    final mergedDateTime = DateTime(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );

    return Appointment(
      id: json['appointment_id'] as int,
      patientId: json['patient_id'] as int,
      patientName:
          json['patient_name'] as String? ?? '',

      doctorId:
          json['doctor_id'] as int,
      doctorName:
          json['doctor_name'] as String? ?? '',

      departmentId:
          json['department_id'] as int,
      department:
          json['department_name'] as String? ?? '',

      dateTime: mergedDateTime,

      status: AppointmentStatusApi.fromApi(
        json['status'] as String? ?? 'Scheduled',
      ),

      bookedBy:
          json['booked_by'] as int?,

      notes:
          json['notes'] as String?,

      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(
                  json['created_at'] as String,
                )
              : null,
    );
  }
}