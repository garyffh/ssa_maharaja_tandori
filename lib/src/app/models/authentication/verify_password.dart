import 'package:json_annotation/json_annotation.dart';

part 'verify_password.g.dart';

@JsonSerializable()
class VerifyPassword {
  VerifyPassword({
    required this.email,
    this.captcha,
  });

  factory VerifyPassword.fromJson(Map<String, dynamic> json) => _$VerifyPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyPasswordToJson(this);

  final   String email;
  final   String? captcha;

}
