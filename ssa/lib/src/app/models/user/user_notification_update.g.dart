// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotificationUpdate _$UserNotificationUpdateFromJson(
        Map<String, dynamic> json) =>
    UserNotificationUpdate(
      typeId: json['typeId'] as int,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$UserNotificationUpdateToJson(
        UserNotificationUpdate instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'enabled': instance.enabled,
    };
