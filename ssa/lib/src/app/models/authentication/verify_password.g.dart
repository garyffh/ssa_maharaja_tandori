// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPassword _$VerifyPasswordFromJson(Map<String, dynamic> json) =>
    VerifyPassword(
      email: json['email'] as String,
      captcha: json['captcha'] as String?,
    );

Map<String, dynamic> _$VerifyPasswordToJson(VerifyPassword instance) =>
    <String, dynamic>{
      'email': instance.email,
      'captcha': instance.captcha,
    };
