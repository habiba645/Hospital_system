// core/constants/api_constants.dart
/// API configuration. Replace baseUrl with your backend endpoint.
class ApiConstants {
  // TODO: Point to your real backend
  static const String baseUrl = 'https://09f3-156-202-51-31.ngrok-free.app';

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
  static const String scheduleToday = '/schedule/today';
  static const String scheduleWeekly = '/schedule/weekly';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
