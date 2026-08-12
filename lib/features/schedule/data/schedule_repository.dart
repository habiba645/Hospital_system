import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/schedule/data/models/schedule_slot_model.dart';

class ScheduleRepository {
  final DioClient dioClient;

  ScheduleRepository({
    required this.dioClient,
  });

  Future<List<ScheduleSlotModel>> getDoctorSchedule(
    int doctorId,
  ) async {
    final response = await dioClient.get(
      ApiConstants.scheduleByDoctor(doctorId),
    );

    final data = response.data as Map<String, dynamic>;

    final schedule = data['schedule'] as List<dynamic>? ?? [];

    return schedule
        .map(
          (e) => ScheduleSlotModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<Map<String, dynamic>> getDoctorScheduleByDay(
    int doctorId,
    String dayOfWeek,
  ) async {
    final response = await dioClient.get(
      ApiConstants.scheduleByDay(doctorId),
      queryParameters: {
        'day_of_week': dayOfWeek,
      },
    );

    return response.data as Map<String, dynamic>;
  }

  Future<void> addDoctorSchedule(
    ScheduleSlotModel slot,
  ) async {
    await dioClient.post(
      ApiConstants.scheduleAdd,
      data: slot.toJson(),
    );
  }

  Future<void> updateSchedule(
    int id,
    Map<String, dynamic> updates,
  ) async {
    await dioClient.patch(
      ApiConstants.scheduleById(id),
      data: updates,
    );
  }

  Future<void> deleteSchedule(int id) async {
    await dioClient.delete(
      ApiConstants.scheduleById(id),
    );
  }
}