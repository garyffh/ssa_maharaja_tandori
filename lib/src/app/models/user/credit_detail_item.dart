import 'package:json_annotation/json_annotation.dart';

part 'credit_detail_item.g.dart';

@JsonSerializable()
class CreditDetailItem {
  CreditDetailItem({
    required this.itemNumber,
    required this.itemTypeId,
    required this.isReadable,
    required this.isCondiment,
    required this.isInstructions,
    required this.isScale,
    required this.name,
    required this.productId,
    required this.productCode,
    required this.description,
    required this.taxable,
    required this.quantity,
    required this.discount,
    required this.currency,
    required this.totalExTax,
    required this.taxAmount,
    required this.total,
    required this.productPoints,
    required this.spendPoints,
  });

  factory CreditDetailItem.fromJson(Map<String, dynamic> json) =>
      _$CreditDetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$CreditDetailItemToJson(this);

  final int itemNumber;
  final int itemTypeId;
  final bool isReadable;
  final bool isCondiment;
  final bool isInstructions;
  final bool isScale;
  final String name;
  final String? productId;
  final String productCode;
  final String description;
  final bool taxable;
  final double quantity;
  final double discount;
  final String currency;
  final double totalExTax;
  final double taxAmount;
  final double total;
  final int productPoints;
  final int spendPoints;
}
