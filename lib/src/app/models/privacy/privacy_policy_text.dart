import 'package:json_annotation/json_annotation.dart';

part 'privacy_policy_text.g.dart';

@JsonSerializable()
class PrivacyPolicyText {
  PrivacyPolicyText({
    required this.updateDT,
    required this.text,
  });

  factory PrivacyPolicyText.fromJson(Map<String, dynamic> json) => _$PrivacyPolicyTextFromJson(json);
  Map<String, dynamic> toJson() => _$PrivacyPolicyTextToJson(this);

  final   DateTime updateDT;
  final   String text;

}
