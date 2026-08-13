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

  /// Contains appointment date + appointment time.
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
    final rawDate =
        json['appointment_date'] as String? ?? '';

    final rawTime =
        json['appointment_time'] as String? ??
            '00:00:00';

    // Backend can return:
    // 2026-08-12T21:00:00.000Z
    //
    // We only take:
    // 2026-08-12
    //
    // because appointment_time contains
    // the actual appointment time.

    final datePart = rawDate.contains('T')
        ? rawDate.split('T').first
        : rawDate;

    final dateParts = datePart.split('-');
    final timeParts = rawTime.split(':');

    final year = int.tryParse(
          dateParts.length > 0
              ? dateParts[0]
              : '',
        ) ??
        0;

    final month = int.tryParse(
          dateParts.length > 1
              ? dateParts[1]
              : '',
        ) ??
        1;

    final day = int.tryParse(
          dateParts.length > 2
              ? dateParts[2]
              : '',
        ) ??
        1;

    final hour = int.tryParse(
          timeParts.length > 0
              ? timeParts[0]
              : '',
        ) ??
        0;

    final minute = int.tryParse(
          timeParts.length > 1
              ? timeParts[1]
              : '',
        ) ??
        0;

    final second = int.tryParse(
          timeParts.length > 2
              ? timeParts[2]
              : '',
        ) ??
        0;

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

      patientId:
          json['patient_id'] as int,

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

      status:
          AppointmentStatusApi.fromApi(
        json['status'] as String? ??
            'Scheduled',
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
        json['pagination']
                as Map<String, dynamic>? ??
            const {};

    return AppointmentsPage(
      appointments:
          (json['appointments']
                      as List<dynamic>? ??
                  [])
              .map(
                (e) => Appointment.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),

      total:
          pagination['total'] as int? ?? 0,

      page:
          pagination['page'] as int? ?? 1,

      limit:
          pagination['limit'] as int? ?? 20,

      totalPages:
          pagination['totalPages'] as int? ?? 0,
    );
  }
}