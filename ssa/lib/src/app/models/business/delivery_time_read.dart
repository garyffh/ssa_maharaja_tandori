import 'package:json_annotation/json_annotation.dart';

part 'delivery_time_read.g.dart';

@JsonSerializable()
class DeliveryTimeRead {
  DeliveryTimeRead({
    required this.sysDeliveryTimeId,
    required this.day,
    required this.number,
    required this.fromTime,
    required this.toTime,
  });

  factory DeliveryTimeRead.fromJson(Map<String, dynamic> json) => _$DeliveryTimeReadFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryTimeReadToJson(this);

  final   int sysDeliveryTimeId;
  final   String day;
  final   int number;
  final   String fromTime;
  final   String toTime;

}
