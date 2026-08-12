import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/departments/data/models/department_model.dart';

class DepartmentRepository {
  final DioClient dioClient;

  DepartmentRepository({required this.dioClient});

  Future<List<DepartmentModel>> getAllDepartments() async {
    final response = await dioClient.get(ApiConstants.departments);
    final data = response.data['departments'] as List;
    return data.map((e) => DepartmentModel.fromJson(e)).toList();
  }
}