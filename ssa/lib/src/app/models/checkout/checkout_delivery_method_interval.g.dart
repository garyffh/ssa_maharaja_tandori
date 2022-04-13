// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_delivery_method_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutDeliveryMethodInterval _$CheckoutDeliveryMethodIntervalFromJson(
        Map<String, dynamic> json) =>
    CheckoutDeliveryMethodInterval(
      intervalTime: json['intervalTime'] == null
          ? null
          : DateTime.parse(json['intervalTime'] as String),
      toTime: json['toTime'] == null
          ? null
          : DateTime.parse(json['toTime'] as String),
      isAsap: json['isAsap'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckoutDeliveryMethodIntervalToJson(
        CheckoutDeliveryMethodInterval instance) =>
    <String, dynamic>{
      'intervalTime': instance.intervalTime?.toIso8601String(),
      'toTime': instance.toTime?.toIso8601String(),
      'isAsap': instance.isAsap,
    };
