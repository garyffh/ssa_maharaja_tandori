import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_delivery_zone.g.dart';

@CopyWith()
@JsonSerializable()
class StoreDeliveryZone {

  StoreDeliveryZone({
    required this.storeDeliveryZoneId,
    required this.name,
    required this.number,
    required this.deliveryDistance,
    required this.deliveryFee,
    required this.deliveryCost,
    required this.walk,
    required this.bicycle,
    required this.drive,
  });

  factory StoreDeliveryZone.fromJson(Map<String, dynamic> json) =>
      _$StoreDeliveryZoneFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDeliveryZoneToJson(this);

  String storeDeliveryZoneId;
  String name;
  final int number;
  final double deliveryDistance;
  final double deliveryFee;
  final double deliveryCost;
  final bool walk;
  final bool bicycle;
  final bool drive;


}
