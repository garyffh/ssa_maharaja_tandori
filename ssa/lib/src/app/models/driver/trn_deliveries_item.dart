import 'package:json_annotation/json_annotation.dart';

part 'trn_deliveries_item.g.dart';

@JsonSerializable()
class TrnDeliveriesItem {
  TrnDeliveriesItem({
    required this.itemNumber,
    required this.itemTypeId,
    required this.isReadable,
    required this.isCondiment,
    required this.isInstructions,
    required this.isScale,
    required this.description,
    required this.exTaxTotal,
    required this.total,
    required this.qty,
    required this.unitPrice,
    required this.sysSitemId,
    required this.sysSitem,
    required this.plu,


  });

  factory TrnDeliveriesItem.fromTrnDeliveriesItem(TrnDeliveriesItem source) => TrnDeliveriesItem.fromJson(source.toJson());

  factory TrnDeliveriesItem.fromJson(Map<String, dynamic> json) => _$TrnDeliveriesItemFromJson(json);
  Map<String, dynamic> toJson() => _$TrnDeliveriesItemToJson(this);

  final   int itemNumber;
  final   int itemTypeId;
  final   bool isReadable;
  final   bool isCondiment;
  final   bool isInstructions;
  final   bool isScale;
  final   String description;
  final   double exTaxTotal;
  final   double total;
  final   double qty;
  final   double unitPrice;
  final   String? sysSitemId;
  final   String? sysSitem;
  final   String plu;

}
