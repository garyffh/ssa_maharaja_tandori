// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordReset _$PasswordResetFromJson(Map<String, dynamic> json) =>
    PasswordReset(
      code: json['code'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$PasswordResetToJson(PasswordReset instance) =>
    <String, dynamic>{
      'code': instance.code,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
