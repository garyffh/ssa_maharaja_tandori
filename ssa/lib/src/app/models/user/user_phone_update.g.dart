// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_phone_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPhoneUpdate _$UserPhoneUpdateFromJson(Map<String, dynamic> json) =>
    UserPhoneUpdate(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      mobileCode: json['mobileCode'] as String,
      mobileNumber: json['mobileNumber'] as String,
    );

Map<String, dynamic> _$UserPhoneUpdateToJson(UserPhoneUpdate instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'mobileCode': instance.mobileCode,
      'mobileNumber': instance.mobileNumber,
    };
