// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) =>
    UserTransaction(
      documentId: json['documentId'] as String,
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentType:
          $enumDecode(_$UserDocumentTypeEnumMap, json['documentType']),
      documentSource: json['documentSource'] as String,
      documentReference: json['documentReference'] as String,
      total: (json['total'] as num).toDouble(),
      points: json['points'] as int,
      paid: (json['paid'] as num).toDouble(),
      redeemPoints: json['redeemPoints'] as int,
      openingBalance: (json['openingBalance'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      pointBalance: json['pointBalance'] as int,
      bonusBalance: json['bonusBalance'] as int,
      allocated: json['allocated'] as bool,
    );

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'documentDate': instance.documentDate.toIso8601String(),
      'documentType': _$UserDocumentTypeEnumMap[instance.documentType],
      'documentSource': instance.documentSource,
      'documentReference': instance.documentReference,
      'total': instance.total,
      'points': instance.points,
      'paid': instance.paid,
      'redeemPoints': instance.redeemPoints,
      'openingBalance': instance.openingBalance,
      'closingBalance': instance.closingBalance,
      'pointBalance': instance.pointBalance,
      'bonusBalance': instance.bonusBalance,
      'allocated': instance.allocated,
    };

const _$UserDocumentTypeEnumMap = {
  UserDocumentType.invoice: 0,
  UserDocumentType.credit: 1,
  UserDocumentType.payment: 2,
};
