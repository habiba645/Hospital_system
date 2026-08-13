// data/patient_repository.dart
import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:medidesk_app/features/patients/data/models/patient_model.dart';

class PatientRepository {
  final DioClient dioClient;
  final AuthLocalDataSource _authLocalDataSource;

  PatientRepository({
    required this.dioClient,
    AuthLocalDataSource? authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource ?? AuthLocalDataSource();

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
    // The backend requires "created_by" (the logged-in user's id).
    // We read it from local secure storage instead of asking the
    // caller to pass it manually every time.
    final currentUser = await _authLocalDataSource.getUser();
    final createdBy = int.tryParse(currentUser?.id ?? '');

    final payload = patient.toJson();
    if (createdBy != null) {
      payload['created_by'] = createdBy;
    }

    final response = await dioClient.post(
      ApiConstants.patients,
      data: payload,
    );
    return response.data['patient_id'];
  }

  Future<void> deletePatient(int id) async {
    await dioClient.delete('${ApiConstants.patients}/$id');
  }
}