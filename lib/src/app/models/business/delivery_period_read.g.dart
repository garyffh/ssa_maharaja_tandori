// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_period_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryPeriodRead _$DeliveryPeriodReadFromJson(Map<String, dynamic> json) =>
    DeliveryPeriodRead(
      sysDeliveryPeriodId: json['sysDeliveryPeriodId'] as int,
      day: json['day'] as String,
      number: json['number'] as int,
      fromTime: json['fromTime'] as String,
      toTime: json['toTime'] as String,
      orderBeforeDay: json['orderBeforeDay'] as String,
      orderBeforeTime: json['orderBeforeTime'] as String,
    );

Map<String, dynamic> _$DeliveryPeriodReadToJson(DeliveryPeriodRead instance) =>
    <String, dynamic>{
      'sysDeliveryPeriodId': instance.sysDeliveryPeriodId,
      'day': instance.day,
      'number': instance.number,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
      'orderBeforeDay': instance.orderBeforeDay,
      'orderBeforeTime': instance.orderBeforeTime,
    };
