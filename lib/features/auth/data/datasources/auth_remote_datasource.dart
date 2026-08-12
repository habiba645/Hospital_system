import 'package:dio/dio.dart';
import 'package:medidesk_app/core/constants/api_constants.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/features/auth/data/models/user_model.dart';

class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse({required this.token, required this.user});
}

class AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSource(this._client);

  Future<LoginResponse> login({
    required String email,
    required String password,
    required bool isAdmin,
  }) async {
    final response = await _client.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
        'role': isAdmin ? 'admin' : 'receptionist',
      },
    );

    final data = response.data as Map<String, dynamic>;
    final token = data['token'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);

    return LoginResponse(token: token, user: user);
  }

  Future<void> logout() async {
    try {
      await _client.post(ApiConstants.logout);
    } on DioException {
      // Even if remote fails, local logout should proceed
    }
  }

  Future<UserModel> getMe() async {
    final response = await _client.get(ApiConstants.me);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}