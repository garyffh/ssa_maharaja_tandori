// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_phone_verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPhoneVerify _$UserPhoneVerifyFromJson(Map<String, dynamic> json) =>
    UserPhoneVerify(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      mobileNumber: json['mobileNumber'] as String,
    );

Map<String, dynamic> _$UserPhoneVerifyToJson(UserPhoneVerify instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'mobileNumber': instance.mobileNumber,
    };
