// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailSignUp _$EmailSignUpFromJson(Map<String, dynamic> json) => EmailSignUp(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      emailCode: json['emailCode'] as String,
      captcha: json['captcha'] as String?,
    );

Map<String, dynamic> _$EmailSignUpToJson(EmailSignUp instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'emailCode': instance.emailCode,
      'captcha': instance.captcha,
    };
