import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';

part 'trn_order_user_allocate_driver.g.dart';

@JsonSerializable()
class TrnOrderUserAllocateDriver {
  TrnOrderUserAllocateDriver({
    required this.trnOrderId,
    required this.deliveryMethodStatus,
    required this.plate,
    required this.make,
    required this.model,
    required this.colour,
  });

  factory TrnOrderUserAllocateDriver.fromJson(Map<String, dynamic> json) =>
      _$TrnOrderUserAllocateDriverFromJson(json);

  Map<String, dynamic> toJson() => _$TrnOrderUserAllocateDriverToJson(this);

  final String trnOrderId;
  final String deliveryMethodStatus;
  final String plate;
  final String make;
  final String model;
  final String colour;

  TrnOrderDeliveryMethodStatus get orderDeliveryMethodStatus =>
      TrnOrderDeliveryMethodStatus.values[int.parse(deliveryMethodStatus)];
}
