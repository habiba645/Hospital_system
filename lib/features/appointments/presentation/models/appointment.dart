enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment {
  final String id;
  final String patientName;
  final String doctorName;
  final String department;
  final DateTime dateTime;
  final AppointmentStatus status;

  const Appointment({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.department,
    required this.dateTime,
    required this.status,
  });
}

/// Mock data — replace with the real list coming from the appointments
/// repository once the backend integration is wired up.
final List<Appointment> mockAppointments = [
  Appointment(
    id: '1',
    patientName: 'Sarah Johnson',
    doctorName: 'Dr. Alex Morgan',
    department: 'Cardiology',
    dateTime: DateTime.now().add(const Duration(hours: 2)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: '2',
    patientName: 'Michael Chen',
    doctorName: 'Dr. Lina Farouk',
    department: 'Dermatology',
    dateTime: DateTime.now().add(const Duration(hours: 4)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: '3',
    patientName: 'Omar Hassan',
    doctorName: 'Dr. Alex Morgan',
    department: 'Cardiology',
    dateTime: DateTime.now().subtract(const Duration(hours: 3)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: '4',
    patientName: 'Nadia Ali',
    doctorName: 'Dr. Karim Saad',
    department: 'Orthopedics',
    dateTime: DateTime.now().subtract(const Duration(days: 1)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: '5',
    patientName: 'Laura Smith',
    doctorName: 'Dr. Lina Farouk',
    department: 'Dermatology',
    dateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: AppointmentStatus.cancelled,
  ),
  Appointment(
    id: '6',
    patientName: 'Youssef Ibrahim',
    doctorName: 'Dr. Karim Saad',
    department: 'Orthopedics',
    dateTime: DateTime.now().add(const Duration(days: 2)),
    status: AppointmentStatus.upcoming,
  ),
];