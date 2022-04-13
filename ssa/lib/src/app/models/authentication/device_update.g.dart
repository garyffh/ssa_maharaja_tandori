// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceUpdate _$DeviceUpdateFromJson(Map<String, dynamic> json) => DeviceUpdate(
      typeId: json['typeId'] as int,
      token: json['token'] as String?,
      version: json['version'] as int,
    );

Map<String, dynamic> _$DeviceUpdateToJson(DeviceUpdate instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'token': instance.token,
      'version': instance.version,
    };
