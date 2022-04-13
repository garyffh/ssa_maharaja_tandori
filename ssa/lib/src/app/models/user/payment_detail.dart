import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/user/payment_detail_item.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method_type.dart';

part 'payment_detail.g.dart';

@JsonSerializable()
class PaymentDetail {
  PaymentDetail({
    required this.documentId,
    required this.createdDT,
    required this.documentDate,
    required this.documentDT,
    required this.documentSource,
    required this.documentReference,
    required this.total,
    required this.cardAmount,
    required this.redeemAmount,
    required this.redeemPoints,
    this.identityBalance,
    this.identityPointBalance,
    this.identityBonusBalance,
    required this.balance,
    required this.pointBalance,
    required this.bonusBalance,
    required this.allocated,
    required this.successful,
    required this.userPaymentMethodId,
    required this.userPaymentTypeId,
    required this.userPaymentName,
    required this.paymentReference,
    required this.paymentResponseCode,
    required this.paymentResponseMessage,
    required this.items,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => _$PaymentDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);

  final   String documentId;
  final   String createdDT;
  final   DateTime documentDate;
  final   DateTime documentDT;
  final   String documentSource;
  final   String documentReference;
  final   int redeemPoints;
  final   double total;
  final   double cardAmount;
  final   double redeemAmount;
  final   double? identityBalance;
  final   int? identityPointBalance;
  final   int? identityBonusBalance;
  final   double balance;
  final   int pointBalance;
  final   int bonusBalance;
  final   bool allocated;
  final   bool successful;
  final   String? userPaymentMethodId;
  final   UserPaymentMethodType userPaymentTypeId;
  final   String userPaymentName;
  final   String paymentReference;
  final   int paymentResponseCode;
  final   String paymentResponseMessage;
  final   List<PaymentDetailItem> items;

  double displayBalance(bool showForIdentity) {
    if(showForIdentity && identityBalance != null) {
      return identityBalance!;
    } else {
      return balance;
    }
  }

  int displayPointBalance(bool showForIdentity) {
    if(showForIdentity && identityPointBalance != null) {
      return identityPointBalance!;
    } else {
      return pointBalance;
    }
  }

  int displayBonusBalance(bool showForIdentity) {
    if(showForIdentity && identityBonusBalance != null) {
      return identityBonusBalance!;
    } else {
      return bonusBalance;
    }
  }

}
