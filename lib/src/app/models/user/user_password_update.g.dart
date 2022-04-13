// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_password_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPasswordUpdate _$UserPasswordUpdateFromJson(Map<String, dynamic> json) =>
    UserPasswordUpdate(
      email: json['email'] as String,
      password: json['password'] as String,
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
    );

Map<String, dynamic> _$UserPasswordUpdateToJson(UserPasswordUpdate instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
