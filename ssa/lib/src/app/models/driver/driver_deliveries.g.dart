// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_deliveries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDeliveries _$DriverDeliveriesFromJson(Map<String, dynamic> json) =>
    DriverDeliveries(
      available: json['available'] as bool,
      deliveries: (json['deliveries'] as List<dynamic>)
          .map((e) => TrnDeliveryRead.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DriverDeliveriesToJson(DriverDeliveries instance) =>
    <String, dynamic>{
      'available': instance.available,
      'deliveries': instance.deliveries,
    };
