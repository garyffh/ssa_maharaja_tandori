// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_detail_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetailItem _$PaymentDetailItemFromJson(Map<String, dynamic> json) =>
    PaymentDetailItem(
      itemNumber: json['itemNumber'] as int,
      documentId: json['documentId'] as String,
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentType: json['documentType'] as int,
      documentReference: json['documentReference'] as String,
      total: (json['total'] as num).toDouble(),
      cardAmount: (json['cardAmount'] as num).toDouble(),
      redeemAmount: (json['redeemAmount'] as num).toDouble(),
      redeemedPoints: json['redeemedPoints'] as int,
    );

Map<String, dynamic> _$PaymentDetailItemToJson(PaymentDetailItem instance) =>
    <String, dynamic>{
      'itemNumber': instance.itemNumber,
      'documentId': instance.documentId,
      'documentDate': instance.documentDate.toIso8601String(),
      'documentType': instance.documentType,
      'documentReference': instance.documentReference,
      'total': instance.total,
      'cardAmount': instance.cardAmount,
      'redeemAmount': instance.redeemAmount,
      'redeemedPoints': instance.redeemedPoints,
    };
