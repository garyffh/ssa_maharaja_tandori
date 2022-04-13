// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_time_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryTimeRead _$DeliveryTimeReadFromJson(Map<String, dynamic> json) =>
    DeliveryTimeRead(
      sysDeliveryTimeId: json['sysDeliveryTimeId'] as int,
      day: json['day'] as String,
      number: json['number'] as int,
      fromTime: json['fromTime'] as String,
      toTime: json['toTime'] as String,
    );

Map<String, dynamic> _$DeliveryTimeReadToJson(DeliveryTimeRead instance) =>
    <String, dynamic>{
      'sysDeliveryTimeId': instance.sysDeliveryTimeId,
      'day': instance.day,
      'number': instance.number,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
