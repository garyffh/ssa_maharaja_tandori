import 'package:json_annotation/json_annotation.dart';

part 'email_sign_up.g.dart';

@JsonSerializable()
class EmailSignUp {
  EmailSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.emailCode,
    this.captcha,
  });


  factory EmailSignUp.fromJson(Map<String, dynamic> json) => _$EmailSignUpFromJson(json);
  Map<String, dynamic> toJson() => _$EmailSignUpToJson(this);

  final   String firstName;
  final   String lastName;
  final   String email;
  final   String password;
  final   String confirmPassword;
  final   String emailCode;
  final   String? captcha;

}
