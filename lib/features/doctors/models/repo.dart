// features/doctors/models/repo.dart
import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/doctors/models/model.dart';

class DoctorRepository {
  final DioClient dioClient;

  DoctorRepository({required this.dioClient});

  Future<List<DoctorModel>> getAllDoctors() async {
    final response = await dioClient.get(ApiConstants.getDoctors);
    final data = response.data['doctors'] as List;
    return data
        .map((e) => DoctorModel.fromEntryJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DoctorModel> addDoctor(DoctorModel doctor) async {
    final response = await dioClient.post(
      ApiConstants.getDoctors,
      data: doctor.toJson(),
    );
    return _parseSingle(response.data, fallback: doctor);
  }

  Future<DoctorModel> updateDoctor(int id, DoctorModel doctor) async {
    final response = await dioClient.put(
      '${ApiConstants.getDoctors}/$id',
      data: doctor.toJson(),
    );
    return _parseSingle(response.data, fallback: doctor.copyWith(id: id));
  }

  /// The API's create/update response shape isn't finalized yet, so this
  /// handles a few likely shapes and falls back to the sent model otherwise.
  DoctorModel _parseSingle(dynamic data, {required DoctorModel fallback}) {
    try {
      if (data is Map<String, dynamic>) {
        if (data['doctor'] is Map && (data['doctor'] as Map).containsKey('doctor')) {
          return DoctorModel.fromEntryJson(data['doctor']);
        }
        if (data.containsKey('doctor')) {
          return DoctorModel.fromEntryJson(data);
        }
        if (data.containsKey('doctor_id')) {
          return DoctorModel.fromEntryJson({'doctor': data});
        }
      }
    } catch (_) {
      // fall through to fallback below
    }
    return fallback;
  }
}