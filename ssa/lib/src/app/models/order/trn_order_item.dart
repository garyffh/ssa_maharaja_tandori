import 'package:json_annotation/json_annotation.dart';

part 'trn_order_item.g.dart';

@JsonSerializable()
class TrnOrderItem {
  TrnOrderItem({
    required this.itemNumber,
    required this.itemTypeId,
    required this.isReadable,
    required this.isCondiment,
    required this.isInstructions,
    required this.isScale,
    required this.description,
    required this.exTaxTotal,
    required this.total,
    required this.productPoints,
    required this.spendPoints,
    required this.qty,
    required this.unitPrice,
    required this.sysSitemId,
    required this.sysSitem,
    required this.plu,
  });

  factory TrnOrderItem.fromJson(Map<String, dynamic> json) => _$TrnOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$TrnOrderItemToJson(this);

  final   int itemNumber;
  final   int itemTypeId;
  final   bool isReadable;
  final   bool isCondiment;
  final   bool isInstructions;
  final   bool isScale;
  final   String description;
  final   double exTaxTotal;
  final   double total;
  final   int productPoints;
  final   int spendPoints;
  final   double qty;
  final   double unitPrice;
  final   String? sysSitemId;
  final   String? sysSitem;
  final   String plu;

}
