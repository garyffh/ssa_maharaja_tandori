import 'package:json_annotation/json_annotation.dart';

part 'condiment_table_item.g.dart';


@JsonSerializable()
class CondimentTableItem {
  CondimentTableItem({
    required this.number,
    required this.sysSitemId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.tax,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.specialPrice1,
    required this.specialPrice2,
    required this.specialPrice3,
    required this.specialPrice4,
    required this.specialPrice5,
  });

  factory CondimentTableItem.fromJson(Map<String, dynamic> json) =>
      _$CondimentTableItemFromJson(json);

  Map<String, dynamic> toJson() => _$CondimentTableItemToJson(this);

  final int number;
  final String sysSitemId;
  final String name;
  final String shortDescription;
  final String description;
  final int tax;
  final double price1;
  final double price2;
  final double price3;
  final double price4;
  final double price5;
  final double? specialPrice1;
  final double? specialPrice2;
  final double? specialPrice3;
  final double? specialPrice4;
  final double? specialPrice5;


}
