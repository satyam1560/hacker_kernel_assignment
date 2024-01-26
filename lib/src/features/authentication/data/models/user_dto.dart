import 'package:hacker_kernel_assignment/src/features/authentication/domain/entities/user.dart';

class UserDto extends User {
  const UserDto({
    required super.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> map) {
    return UserDto(
      token: map['token'] as String,
    );
  }
}
