import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/appointments/data/models/appointment.dart';

class AppointmentsRepository {
  final DioClient _dioClient;

  AppointmentsRepository(this._dioClient);

  Future<AppointmentsPage> getAppointments({
    int page = 1,
    int limit = 20,
    String? status,
    int? doctorId,
    String? search,
  }) async {
    final response = await _dioClient.get(
      ApiConstants.appointments,
      queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status,
        if (doctorId != null) 'doctor_id': doctorId,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw const FormatException(
        'Invalid appointments response format.',
      );
    }

    return AppointmentsPage.fromJson(data);
  }

  /// Gets all appointments across all backend pages.
  Future<List<Appointment>> getAllAppointments({
    int limit = 100,
  }) async {
    final firstPage = await getAppointments(
      page: 1,
      limit: limit,
    );

    final appointments = <Appointment>[
      ...firstPage.appointments,
    ];

    if (firstPage.totalPages <= 1) {
      return appointments;
    }

    for (
      int page = 2;
      page <= firstPage.totalPages;
      page++
    ) {
      final result = await getAppointments(
        page: page,
        limit: limit,
      );

      appointments.addAll(result.appointments);
    }

    return appointments;
  }

  Future<Appointment> getAppointmentById(int id) async {
    final response = await _dioClient.get(
      '${ApiConstants.appointments}/$id',
    );

    final data = response.data as Map<String, dynamic>;

    return Appointment.fromJson(
      data['appointment'] as Map<String, dynamic>,
    );
  }

  Future<int> createAppointment({
    required int patientId,
    required int doctorId,
    required int departmentId,
    required int scheduleId,
    required String appointmentDate,
    required String appointmentTime,
    String? notes,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.appointments,
      data: {
        'patient_id': patientId,
        'doctor_id': doctorId,
        'department_id': departmentId,
        'schedule_id': scheduleId,
        'appointment_date': appointmentDate,
        'appointment_time': appointmentTime,
        if (notes != null) 'notes': notes,
      },
    );

    final data = response.data as Map<String, dynamic>;

    return data['appointment_id'] as int;
  }

  Future<void> updateAppointment(
    int id,
    Map<String, dynamic> fields,
  ) async {
    await _dioClient.patch(
      '${ApiConstants.appointments}/$id',
      data: fields,
    );
  }

  Future<void> updateAppointmentStatus(
    int id,
    AppointmentStatus status,
  ) async {
    await _dioClient.patch(
      '${ApiConstants.appointments}/$id/status',
      data: {
        'status': status.apiValue,
      },
    );
  }

  Future<void> deleteAppointment(int id) async {
    await _dioClient.delete(
      '${ApiConstants.appointments}/$id',
    );
  }
}