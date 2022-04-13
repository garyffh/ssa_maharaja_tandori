import 'package:json_annotation/json_annotation.dart';

part 'driver_enable_deliveries.g.dart';

@JsonSerializable()
class DriverEnableDeliveries {
  DriverEnableDeliveries({
    required this.ackConditions,
    required this.available,
    required this.conditions,
    required this.plate,
    required this.model,
    required this.make,
    required this.colour,
  });

  factory DriverEnableDeliveries.fromJson(Map<String, dynamic> json) =>
      _$DriverEnableDeliveriesFromJson(json);

  Map<String, dynamic> toJson() => _$DriverEnableDeliveriesToJson(this);

  final bool ackConditions;
  final bool available;
  final String conditions;
  final String plate;
  final String model;
  final String make;
  final String colour;
}
