import 'package:json_annotation/json_annotation.dart';

part 'user_payment_only.g.dart';

@JsonSerializable()
class UserPaymentOnly {
  UserPaymentOnly({
    required this.documentId,
    required this.paymentMethodId,
    required this.paymentToken,
    required this.currency,
    required this.paidAmount,
    required this.cardAmount,
    required this.redeemAmount,
    required this.redeemPoints,
  });

  factory UserPaymentOnly.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentOnlyFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaymentOnlyToJson(this);

  final String? documentId;
  final String? paymentMethodId;
  final String paymentToken;
  final String currency;
  final double paidAmount;
  final double cardAmount;
  final int redeemAmount;
  final int redeemPoints;
}
