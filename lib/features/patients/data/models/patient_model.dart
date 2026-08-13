// models/patient_model.dart
class PatientModel {
  final int? id;
  final String fullName;
  final String nationalId;
  final String gender;
  final String dateOfBirth;
  final String phone;
  final String address;
  final String bloodType;
  final int? createdBy;

  PatientModel({
    this.id,
    required this.fullName,
    required this.nationalId,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
    required this.bloodType,
    this.createdBy,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['patient_id'], // ✅ fixed: backend returns "patient_id", not "id"
      fullName: json['full_name'] ?? '',
      nationalId: json['national_id'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      bloodType: json['blood_type'] ?? '',
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'national_id': nationalId,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'phone': phone,
      'address': address,
      'blood_type': bloodType,
      if (createdBy != null) 'created_by': createdBy,
    };
  }

  PatientModel copyWith({
    int? id,
    String? fullName,
    String? nationalId,
    String? gender,
    String? dateOfBirth,
    String? phone,
    String? address,
    String? bloodType,
    int? createdBy,
  }) {
    return PatientModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nationalId: nationalId ?? this.nationalId,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}