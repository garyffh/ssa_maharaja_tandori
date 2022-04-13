import 'package:json_annotation/json_annotation.dart';

part 'verify_email_result.g.dart';

@JsonSerializable()
class VerifyEmailResult {
  VerifyEmailResult({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
  });

  factory VerifyEmailResult.fromJson(Map<String, dynamic> json) => _$VerifyEmailResultFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailResultToJson(this);

  final   String firstName;
  final   String lastName;
  final   String emailAddress;

}
