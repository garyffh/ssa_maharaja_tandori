import 'package:json_annotation/json_annotation.dart';

part 'verify_email.g.dart';

@JsonSerializable()
class VerifyEmail {
  VerifyEmail({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    this.captcha,
  });

  factory VerifyEmail.fromJson(Map<String, dynamic> json) => _$VerifyEmailFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailToJson(this);

  final   String firstName;
  final   String lastName;
  final   String emailAddress;
  final   String? captcha;

}
