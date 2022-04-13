import 'package:json_annotation/json_annotation.dart';

import 'condiment_table_item.dart';

part 'condiment_table.g.dart';

@JsonSerializable()
class CondimentTable {
  CondimentTable({
    required this.sysCondimentTableId,
    required this.number,
    required this.name,
    required this.multiple,
    required this.tQty,
    required this.defaultItem,
    required this.cP1Enabled,
    required this.cP1ZeroPrice,
    required this.cP1ButtonDescription,
    required this.cP1PrintDescription,
    required this.cP2Enabled,
    required this.cP2ZeroPrice,
    required this.cP2ButtonDescription,
    required this.cP2PrintDescription,
    required this.cP3Enabled,
    required this.cP3ZeroPrice,
    required this.cP3ButtonDescription,
    required this.cP3PrintDescription,
    required this.cP4Enabled,
    required this.cP4ZeroPrice,
    required this.cP4ButtonDescription,
    required this.cP4PrintDescription,
    required this.items,
  });

  factory CondimentTable.fromJson(Map<String, dynamic> json) =>
      _$CondimentTableFromJson(json);

  Map<String, dynamic> toJson() => _$CondimentTableToJson(this);


  final String sysCondimentTableId;
  final int number;
  final String name;
  final bool multiple;
  final double tQty;
  final bool defaultItem;
  final bool cP1Enabled;
  final bool cP1ZeroPrice;
  final String cP1ButtonDescription;
  final String cP1PrintDescription;
  final bool cP2Enabled;
  final bool cP2ZeroPrice;
  final String cP2ButtonDescription;
  final String cP2PrintDescription;
  final bool cP3Enabled;
  final bool cP3ZeroPrice;
  final String cP3ButtonDescription;
  final String cP3PrintDescription;
  final bool cP4Enabled;
  final bool cP4ZeroPrice;
  final String cP4ButtonDescription;
  final String cP4PrintDescription;
  final List<CondimentTableItem> items;

}
