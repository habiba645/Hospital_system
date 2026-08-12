import 'package:medidesk_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:medidesk_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:medidesk_app/features/auth/domain/entities/user_entity.dart';
import 'package:medidesk_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
    required bool isAdmin,
  }) async {
    final result = await remoteDataSource.login(
      email: email,
      password: password,
      isAdmin: isAdmin,
    );

    await localDataSource.saveToken(result.token);
    await localDataSource.saveUser(result.user);

    return result.user;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearAll();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return localDataSource.getUser();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await localDataSource.getToken();
    return token != null && token.isNotEmpty;
  }
}