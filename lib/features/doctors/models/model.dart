// features/doctors/models/model.dart

class DoctorWorkingDay {
  final String dayOfWeek;
  final String startTime; // "HH:mm:ss"
  final String endTime;   // "HH:mm:ss"

  const DoctorWorkingDay({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorWorkingDay.fromJson(Map<String, dynamic> json) {
    return DoctorWorkingDay(
      dayOfWeek: json['day_of_week'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'day_of_week': dayOfWeek,
        'start_time': startTime,
        'end_time': endTime,
      };
}

class DoctorModel {
  final int? id;
  final String username;
  final String fullName;
  final String phone;
  final String email;
  final int? deptId;
  final String specialization;
  final String consultationFee; // kept as string, API returns "500.00"
  final List<DoctorWorkingDay> workingDays;
  final int? slotDurationMinutes;
  final String? password; // only used when creating a doctor

  const DoctorModel({
    this.id,
    required this.username,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.deptId,
    required this.specialization,
    required this.consultationFee,
    this.workingDays = const [],
    this.slotDurationMinutes,
    this.password,
  });

  /// Parses one item of the `doctors` array returned by GET /doctors,
  /// e.g. { "doctor": {...}, "working_days": [...], "slot_duration_minutes": 30 }
  factory DoctorModel.fromEntryJson(Map<String, dynamic> json) {
    final doctorJson = (json['doctor'] ?? json) as Map<String, dynamic>;
    final workingDaysJson = json['working_days'] as List? ?? [];
    return DoctorModel(
      id: doctorJson['doctor_id'],
      username: doctorJson['username'] ?? '',
      fullName: doctorJson['full_name'] ?? '',
      phone: doctorJson['phone'] ?? '',
      email: doctorJson['email'] ?? '',
      deptId: doctorJson['dept_id'],
      specialization: doctorJson['specialization'] ?? '',
      consultationFee: (doctorJson['consultation_fee'] ?? '0').toString(),
      workingDays: workingDaysJson
          .map((e) => DoctorWorkingDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      slotDurationMinutes: json['slot_duration_minutes'],
      password: null,
    );
  }

  /// Body sent to POST /doctors (create) and PUT /doctors/:id (update).
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'dept_id': deptId,
      'specialization': specialization,
      'consultation_fee': consultationFee,
      'slot_duration_minutes': slotDurationMinutes,
      'working_days': workingDays.map((d) => d.toJson()).toList(),
      if (password != null && password!.isNotEmpty) 'password': password,
    };
  }

  DoctorModel copyWith({
    int? id,
    String? username,
    String? fullName,
    String? phone,
    String? email,
    int? deptId,
    String? specialization,
    String? consultationFee,
    List<DoctorWorkingDay>? workingDays,
    int? slotDurationMinutes,
    String? password,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      deptId: deptId ?? this.deptId,
      specialization: specialization ?? this.specialization,
      consultationFee: consultationFee ?? this.consultationFee,
      workingDays: workingDays ?? this.workingDays,
      slotDurationMinutes: slotDurationMinutes ?? this.slotDurationMinutes,
      password: password ?? this.password,
    );
  }

  String get workingHoursLabel {
    if (workingDays.isEmpty) return 'No schedule set';
    final days = workingDays.map((d) => d.dayOfWeek.substring(0, 3)).join(', ');
    final first = workingDays.first;
    return '$days · ${_shortTime(first.startTime)}–${_shortTime(first.endTime)}';
  }

  static String _shortTime(String time) {
    final parts = time.split(':');
    if (parts.length < 2) return time;
    return '${parts[0]}:${parts[1]}';
  }
}

/// Departments are mocked for now (no dedicated endpoint wired here yet).
class MockDepartment {
  final int id;
  final String name;
  const MockDepartment(this.id, this.name);
}

const List<MockDepartment> mockDepartments = [
  MockDepartment(1, 'Cardiology'),
  MockDepartment(2, 'Neurology'),
  MockDepartment(3, 'Pediatrics'),
  MockDepartment(4, 'Orthopedics'),
  MockDepartment(5, 'Dermatology'),
];

String departmentNameForId(int? id) {
  if (id == null) return 'Unassigned';
  final match = mockDepartments.where((d) => d.id == id);
  return match.isEmpty ? 'Unassigned' : match.first.name;
}