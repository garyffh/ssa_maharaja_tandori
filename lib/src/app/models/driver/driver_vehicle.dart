import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

part 'driver_vehicle.g.dart';

@JsonSerializable()
class DriverVehicle {
  DriverVehicle({
    required this.updateId,
    required this.userCarId,
    required this.plate,
    required this.model,
    required this.make,
    required this.colour,
    required this.currentCar,
  });

  DriverVehicle.updateCurrentCar({
    required this.currentCar,
    required DriverVehicle driverVehicle,
  })  : updateId = driverVehicle.updateId,
        userCarId = driverVehicle.userCarId,
        plate = driverVehicle.plate,
        model = driverVehicle.model,
        make = driverVehicle.make,
        colour = driverVehicle.colour;

  factory DriverVehicle.fromDriverVehicle(DriverVehicle source) =>
      DriverVehicle.fromJson(source.toJson());

  factory DriverVehicle.fromJson(Map<String, dynamic> json) =>
      _$DriverVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$DriverVehicleToJson(this);

  @Uint8ListConverter()
  final Uint8List updateId;
  final String userCarId;
  final String plate;
  final String model;
  final String make;
  final String colour;
  final bool currentCar;
}
