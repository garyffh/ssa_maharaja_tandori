// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverVehicle _$DriverVehicleFromJson(Map<String, dynamic> json) =>
    DriverVehicle(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      userCarId: json['userCarId'] as String,
      plate: json['plate'] as String,
      model: json['model'] as String,
      make: json['make'] as String,
      colour: json['colour'] as String,
      currentCar: json['currentCar'] as bool,
    );

Map<String, dynamic> _$DriverVehicleToJson(DriverVehicle instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'userCarId': instance.userCarId,
      'plate': instance.plate,
      'model': instance.model,
      'make': instance.make,
      'colour': instance.colour,
      'currentCar': instance.currentCar,
    };
