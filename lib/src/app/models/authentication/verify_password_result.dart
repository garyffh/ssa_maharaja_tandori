import 'package:json_annotation/json_annotation.dart';

part 'verify_password_result.g.dart';

@JsonSerializable()
class VerifyPasswordResult {
  VerifyPasswordResult({
    required this.email,
  });

  factory VerifyPasswordResult.fromJson(Map<String, dynamic> json) => _$VerifyPasswordResultFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyPasswordResultToJson(this);

  final   String email;

}
