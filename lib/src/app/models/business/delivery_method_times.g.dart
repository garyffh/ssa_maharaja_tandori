// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_method_times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMethodTimes _$DeliveryMethodTimesFromJson(Map<String, dynamic> json) =>
    DeliveryMethodTimes(
      type: $enumDecode(_$DeliveryMethodTypeEnumMap, json['type']),
      times: (json['times'] as List<dynamic>)
          .map(
              (e) => DeliveryMethodInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
      openStatus:
          $enumDecode(_$DeliveryMethodOpenStatusEnumMap, json['openStatus']),
    );

Map<String, dynamic> _$DeliveryMethodTimesToJson(
        DeliveryMethodTimes instance) =>
    <String, dynamic>{
      'type': _$DeliveryMethodTypeEnumMap[instance.type],
      'times': instance.times,
      'openStatus': _$DeliveryMethodOpenStatusEnumMap[instance.openStatus],
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.store: 0,
  DeliveryMethodType.delivery: 1,
  DeliveryMethodType.table: 2,
  DeliveryMethodType.period: 3,
};

const _$DeliveryMethodOpenStatusEnumMap = {
  DeliveryMethodOpenStatus.closed: 0,
  DeliveryMethodOpenStatus.open: 1,
  DeliveryMethodOpenStatus.schedule: 2,
};
