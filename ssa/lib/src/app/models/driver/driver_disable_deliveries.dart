import 'package:json_annotation/json_annotation.dart';

part 'driver_disable_deliveries.g.dart';

@JsonSerializable()
class DriverDisableDeliveries {
  DriverDisableDeliveries({
    required this.available,
  });

  factory DriverDisableDeliveries.fromJson(Map<String, dynamic> json) => _$DriverDisableDeliveriesFromJson(json);
  Map<String, dynamic> toJson() => _$DriverDisableDeliveriesToJson(this);

  final   bool available;


}
