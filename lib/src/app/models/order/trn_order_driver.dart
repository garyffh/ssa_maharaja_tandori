import 'package:json_annotation/json_annotation.dart';

part 'trn_order_driver.g.dart';

@JsonSerializable()
class TrnOrderDriver {
  TrnOrderDriver({
    required this.plate,
    required this.make,
    required this.model,
    required this.colour,
  });

  factory TrnOrderDriver.fromJson(Map<String, dynamic> json) => _$TrnOrderDriverFromJson(json);
  Map<String, dynamic> toJson() => _$TrnOrderDriverToJson(this);

  final   String plate;
  final   String make;
  final   String model;
  final   String colour;

}
