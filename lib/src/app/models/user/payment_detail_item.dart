import 'package:json_annotation/json_annotation.dart';

part 'payment_detail_item.g.dart';

@JsonSerializable()
class PaymentDetailItem {
  PaymentDetailItem({
    required this.itemNumber,
    required this.documentId,
    required this.documentDate,
    required this.documentType,
    required this.documentReference,
    required this.total,
    required this.cardAmount,
    required this.redeemAmount,
    required this.redeemedPoints,
  });

  factory PaymentDetailItem.fromJson(Map<String, dynamic> json) => _$PaymentDetailItemFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailItemToJson(this);

  final   int itemNumber;
  final   String documentId;
  final   DateTime documentDate;
  final   int documentType;
  final   String documentReference;
  final   double total;
  final   double cardAmount;
  final   double redeemAmount;
  final   int redeemedPoints;

}
