// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_delivery_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutDeliveryMethod _$CheckoutDeliveryMethodFromJson(
        Map<String, dynamic> json) =>
    CheckoutDeliveryMethod(
      storeStatusTime: DateTime.parse(json['storeStatusTime'] as String),
      storeStatus:
          $enumDecode(_$DeliveryMethodOpenStatusEnumMap, json['storeStatus']),
      storeTimes: (json['storeTimes'] as List<dynamic>)
          .map((e) => CheckoutDeliveryMethodInterval.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      deliveryTimes: (json['deliveryTimes'] as List<dynamic>)
          .map((e) => CheckoutDeliveryMethodInterval.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      periodTimes: (json['periodTimes'] as List<dynamic>)
          .map((e) => CheckoutDeliveryMethodInterval.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutDeliveryMethodToJson(
        CheckoutDeliveryMethod instance) =>
    <String, dynamic>{
      'storeStatusTime': instance.storeStatusTime.toIso8601String(),
      'storeStatus': _$DeliveryMethodOpenStatusEnumMap[instance.storeStatus],
      'storeTimes': instance.storeTimes,
      'deliveryTimes': instance.deliveryTimes,
      'periodTimes': instance.periodTimes,
    };

const _$DeliveryMethodOpenStatusEnumMap = {
  DeliveryMethodOpenStatus.closed: 0,
  DeliveryMethodOpenStatus.open: 1,
  DeliveryMethodOpenStatus.schedule: 2,
};
