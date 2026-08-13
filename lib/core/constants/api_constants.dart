
// core/constants/api_constants.dart
/// API configuration. Replace baseUrl with your backend endpoint.
class ApiConstants {
  // TODO: Point to your real backend
  static const String baseUrl = 'https://bc23-156-202-86-193.ngrok-free.app';

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/me';

  // Admin
  static const String getDoctors = '/doctors';
  
  static const String departments = '/departments';
  static const String receptionists = '/receptionists';

  // Reception
  static const String patients = '/patients';
  static const String appointments = '/appointments';

  // Schedule
  static const String scheduleAdd = '/schedule/';
  static String scheduleByDoctor(int doctorId) => '/schedule/$doctorId';
  static String scheduleById(int scheduleId) => '/schedule/$scheduleId';
  static String scheduleByDay(int doctorId) => '/schedule/day/$doctorId';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}