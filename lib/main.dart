import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidesk_app/core/network/dio_client.dart';
import 'package:medidesk_app/core/routes/app_router.dart';
import 'package:medidesk_app/core/theme/app_theme.dart';
import 'package:medidesk_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:medidesk_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:medidesk_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:medidesk_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:medidesk_app/features/auth/presentation/cubit/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MediDeskApp());
}

class MediDeskApp extends StatelessWidget {
  const MediDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection setup (can be replaced with get_it later)
    final dioClient = DioClient();
    final authLocal = AuthLocalDataSource();
    final authRemote = AuthRemoteDataSource(dioClient);
    final AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemote,
      localDataSource: authLocal,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<DioClient>.value(value: dioClient),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            )..checkAuthStatus(),
          ),
        ],
        child: MaterialApp.router(
          title: 'MediDesk',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
