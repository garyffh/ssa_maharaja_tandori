// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_only.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPaymentOnly _$UserPaymentOnlyFromJson(Map<String, dynamic> json) =>
    UserPaymentOnly(
      documentId: json['documentId'] as String?,
      paymentMethodId: json['paymentMethodId'] as String?,
      paymentToken: json['paymentToken'] as String,
      currency: json['currency'] as String,
      paidAmount: (json['paidAmount'] as num).toDouble(),
      cardAmount: (json['cardAmount'] as num).toDouble(),
      redeemAmount: json['redeemAmount'] as int,
      redeemPoints: json['redeemPoints'] as int,
    );

Map<String, dynamic> _$UserPaymentOnlyToJson(UserPaymentOnly instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'paymentMethodId': instance.paymentMethodId,
      'paymentToken': instance.paymentToken,
      'currency': instance.currency,
      'paidAmount': instance.paidAmount,
      'cardAmount': instance.cardAmount,
      'redeemAmount': instance.redeemAmount,
      'redeemPoints': instance.redeemPoints,
    };
