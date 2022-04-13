import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery_read.dart';

part 'driver_deliveries.g.dart';

@JsonSerializable()
class DriverDeliveries {
  DriverDeliveries({
    required this.available,
    required this.deliveries,
  });

  factory DriverDeliveries.fromDriverDeliveries(DriverDeliveries source) => DriverDeliveries.fromJson(source.toJson());

  factory DriverDeliveries.fromJson(Map<String, dynamic> json) => _$DriverDeliveriesFromJson(json);
  Map<String, dynamic> toJson() => _$DriverDeliveriesToJson(this);

  final   bool available;
  final   List<TrnDeliveryRead> deliveries;

}
