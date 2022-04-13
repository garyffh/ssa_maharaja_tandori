// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_enable_deliveries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverEnableDeliveries _$DriverEnableDeliveriesFromJson(
        Map<String, dynamic> json) =>
    DriverEnableDeliveries(
      ackConditions: json['ackConditions'] as bool,
      available: json['available'] as bool,
      conditions: json['conditions'] as String,
      plate: json['plate'] as String,
      model: json['model'] as String,
      make: json['make'] as String,
      colour: json['colour'] as String,
    );

Map<String, dynamic> _$DriverEnableDeliveriesToJson(
        DriverEnableDeliveries instance) =>
    <String, dynamic>{
      'ackConditions': instance.ackConditions,
      'available': instance.available,
      'conditions': instance.conditions,
      'plate': instance.plate,
      'model': instance.model,
      'make': instance.make,
      'colour': instance.colour,
    };
