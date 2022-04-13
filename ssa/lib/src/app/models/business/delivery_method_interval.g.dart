// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_method_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMethodInterval _$DeliveryMethodIntervalFromJson(
        Map<String, dynamic> json) =>
    DeliveryMethodInterval(
      typeId: json['typeId'] as int,
      dayId: json['dayId'] as int,
      fromTime: DateTime.parse(json['fromTime'] as String),
      toTime: DateTime.parse(json['toTime'] as String),
      store: json['store'] as bool,
      delivery: json['delivery'] as bool,
      closed: json['closed'] as bool,
    );

Map<String, dynamic> _$DeliveryMethodIntervalToJson(
        DeliveryMethodInterval instance) =>
    <String, dynamic>{
      'typeId': instance.typeId,
      'dayId': instance.dayId,
      'fromTime': instance.fromTime.toIso8601String(),
      'toTime': instance.toTime.toIso8601String(),
      'store': instance.store,
      'delivery': instance.delivery,
      'closed': instance.closed,
    };
