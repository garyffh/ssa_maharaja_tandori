import 'package:json_annotation/json_annotation.dart';

part 'password_reset.g.dart';

@JsonSerializable()
class PasswordReset {
  const PasswordReset({
    required this.code,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory PasswordReset.fromJson(Map<String, dynamic> json) => _$PasswordResetFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordResetToJson(this);

  final String code;
  final String email;
  final String password;
  final String confirmPassword;
}
