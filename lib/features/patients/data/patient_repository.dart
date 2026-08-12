// data/patient_repository.dart
import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/patients/data/models/patient_model.dart';

class PatientRepository {
  final DioClient dioClient;

  PatientRepository({required this.dioClient});

  Future<List<PatientModel>> getAllPatients() async {
    final response = await dioClient.get(ApiConstants.patients);
    final data = response.data['data'] ?? response.data;
    return (data as List).map((e) => PatientModel.fromJson(e)).toList();
  }

  Future<PatientModel> getPatientById(int id) async {
    final response = await dioClient.get('${ApiConstants.patients}/$id');
    final data = response.data['data'] ?? response.data;
    return PatientModel.fromJson(data);
  }

  Future<int> addPatient(PatientModel patient) async {
    final response = await dioClient.post(
      ApiConstants.patients,
      data: patient.toJson(),
    );
    return response.data['patient_id'];
  }

  Future<void> deletePatient(int id) async {
    await dioClient.delete('${ApiConstants.patients}/$id');
  }
}