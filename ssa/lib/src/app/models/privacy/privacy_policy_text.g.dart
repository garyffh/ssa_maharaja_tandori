// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_policy_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyPolicyText _$PrivacyPolicyTextFromJson(Map<String, dynamic> json) =>
    PrivacyPolicyText(
      updateDT: DateTime.parse(json['updateDT'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$PrivacyPolicyTextToJson(PrivacyPolicyText instance) =>
    <String, dynamic>{
      'updateDT': instance.updateDT.toIso8601String(),
      'text': instance.text,
    };
