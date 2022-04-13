// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      documentId: json['documentId'] as String,
      createdDT: json['createdDT'] as String,
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentDT: DateTime.parse(json['documentDT'] as String),
      documentSource: json['documentSource'] as String,
      documentReference: json['documentReference'] as String,
      total: (json['total'] as num).toDouble(),
      cardAmount: (json['cardAmount'] as num).toDouble(),
      redeemAmount: (json['redeemAmount'] as num).toDouble(),
      redeemPoints: json['redeemPoints'] as int,
      identityBalance: (json['identityBalance'] as num?)?.toDouble(),
      identityPointBalance: json['identityPointBalance'] as int?,
      identityBonusBalance: json['identityBonusBalance'] as int?,
      balance: (json['balance'] as num).toDouble(),
      pointBalance: json['pointBalance'] as int,
      bonusBalance: json['bonusBalance'] as int,
      allocated: json['allocated'] as bool,
      successful: json['successful'] as bool,
      userPaymentMethodId: json['userPaymentMethodId'] as String?,
      userPaymentTypeId: $enumDecode(
          _$UserPaymentMethodTypeEnumMap, json['userPaymentTypeId']),
      userPaymentName: json['userPaymentName'] as String,
      paymentReference: json['paymentReference'] as String,
      paymentResponseCode: json['paymentResponseCode'] as int,
      paymentResponseMessage: json['paymentResponseMessage'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => PaymentDetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'createdDT': instance.createdDT,
      'documentDate': instance.documentDate.toIso8601String(),
      'documentDT': instance.documentDT.toIso8601String(),
      'documentSource': instance.documentSource,
      'documentReference': instance.documentReference,
      'redeemPoints': instance.redeemPoints,
      'total': instance.total,
      'cardAmount': instance.cardAmount,
      'redeemAmount': instance.redeemAmount,
      'identityBalance': instance.identityBalance,
      'identityPointBalance': instance.identityPointBalance,
      'identityBonusBalance': instance.identityBonusBalance,
      'balance': instance.balance,
      'pointBalance': instance.pointBalance,
      'bonusBalance': instance.bonusBalance,
      'allocated': instance.allocated,
      'successful': instance.successful,
      'userPaymentMethodId': instance.userPaymentMethodId,
      'userPaymentTypeId':
          _$UserPaymentMethodTypeEnumMap[instance.userPaymentTypeId],
      'userPaymentName': instance.userPaymentName,
      'paymentReference': instance.paymentReference,
      'paymentResponseCode': instance.paymentResponseCode,
      'paymentResponseMessage': instance.paymentResponseMessage,
      'items': instance.items,
    };

const _$UserPaymentMethodTypeEnumMap = {
  UserPaymentMethodType.card: 0,
};
