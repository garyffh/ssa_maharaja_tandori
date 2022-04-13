import 'package:json_annotation/json_annotation.dart';

part 'delivery_method_interval.g.dart';

@JsonSerializable()
class DeliveryMethodInterval {

  DeliveryMethodInterval({
    required this.typeId,
    required this.dayId,
    required this.fromTime,
    required this.toTime,
    required this.store,
    required this.delivery,
    required this.closed,
  });

  factory DeliveryMethodInterval.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMethodIntervalToJson(this);

  final int typeId;
  final int dayId;
  final DateTime fromTime;
  final DateTime toTime;
  final bool store;
  final bool delivery;
  final bool closed;

}
