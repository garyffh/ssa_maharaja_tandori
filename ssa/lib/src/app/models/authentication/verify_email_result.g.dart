// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailResult _$VerifyEmailResultFromJson(Map<String, dynamic> json) =>
    VerifyEmailResult(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      emailAddress: json['emailAddress'] as String,
    );

Map<String, dynamic> _$VerifyEmailResultToJson(VerifyEmailResult instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
    };
