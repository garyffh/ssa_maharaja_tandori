import 'package:json_annotation/json_annotation.dart';

part 'delivery_period_read.g.dart';

@JsonSerializable()
class DeliveryPeriodRead {
  DeliveryPeriodRead({
    required this.sysDeliveryPeriodId,
    required this.day,
    required this.number,
    required this.fromTime,
    required this.toTime,
    required this.orderBeforeDay,
    required this.orderBeforeTime,
  });


  factory DeliveryPeriodRead.fromJson(Map<String, dynamic> json) => _$DeliveryPeriodReadFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryPeriodReadToJson(this);

  final   int sysDeliveryPeriodId;
  final   String day;
  final   int number;
  final   String fromTime;
  final   String toTime;
  final   String orderBeforeDay;
  final   String orderBeforeTime;

}
