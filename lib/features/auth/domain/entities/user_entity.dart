import 'package:equatable/equatable.dart';

enum UserRoleEntity { admin, receptionist }

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRoleEntity role;
  final String? phone;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, email, role, phone, avatarUrl];
}
