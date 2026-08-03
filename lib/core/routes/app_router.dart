import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidesk_app/core/widgets/app_shell.dart';
import 'package:medidesk_app/features/auth/presentation/screens/login_screen.dart';
import 'package:medidesk_app/features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:medidesk_app/features/dashboard/presentation/screens/reception_dashboard_screen.dart';
import 'package:medidesk_app/features/doctors/presentation/screens/doctors_screen.dart';
import 'package:medidesk_app/features/departments/presentation/screens/departments_screen.dart';
import 'package:medidesk_app/features/receptionists/presentation/screens/receptionists_screen.dart';
import 'package:medidesk_app/features/patients/presentation/screens/patients_screen.dart';
import 'package:medidesk_app/features/appointments/presentation/screens/appointments_screen.dart';
import 'package:medidesk_app/features/schedule/presentation/screens/today_schedule_screen.dart';
import 'package:medidesk_app/features/schedule/presentation/screens/weekly_schedule_screen.dart';

/// Central router. All main screens are wired; UI content can be filled later.
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      // ── Auth ──────────────────────────────────────────────
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ── Admin Shell ───────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            role: UserRole.admin,
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/admin',
            name: 'admin-dashboard',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: '/admin/doctors',
            name: 'admin-doctors',
            builder: (context, state) => const DoctorsScreen(),
          ),
          GoRoute(
            path: '/admin/departments',
            name: 'admin-departments',
            builder: (context, state) => const DepartmentsScreen(),
          ),
          GoRoute(
            path: '/admin/receptionists',
            name: 'admin-receptionists',
            builder: (context, state) => const ReceptionistsScreen(),
          ),
        ],
      ),

      // ── Reception Shell ───────────────────────────────────
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            role: UserRole.receptionist,
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/reception',
            name: 'reception-dashboard',
            builder: (context, state) => const ReceptionDashboardScreen(),
          ),
          GoRoute(
            path: '/reception/patients',
            name: 'reception-patients',
            builder: (context, state) => const PatientsScreen(),
          ),
          GoRoute(
            path: '/reception/appointments',
            name: 'reception-appointments',
            builder: (context, state) => const AppointmentsScreen(),
          ),
          GoRoute(
            path: '/reception/today',
            name: 'reception-today',
            builder: (context, state) => const TodayScheduleScreen(),
          ),
          GoRoute(
            path: '/reception/weekly',
            name: 'reception-weekly',
            builder: (context, state) => const WeeklyScheduleScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}

enum UserRole { admin, receptionist }
