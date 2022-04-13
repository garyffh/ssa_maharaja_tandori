// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverTransaction _$DriverTransactionFromJson(Map<String, dynamic> json) =>
    DriverTransaction(
      documentId: json['documentId'] as String,
      documentDT: DateTime.parse(json['documentDT'] as String),
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentType:
          $enumDecode(_$DriverDocumentTypeEnumMap, json['documentType']),
      documentReference: json['documentReference'] as String,
      total: (json['total'] as num).toDouble(),
      openingBalance: (json['openingBalance'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$DriverTransactionToJson(DriverTransaction instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'documentDT': instance.documentDT.toIso8601String(),
      'documentDate': instance.documentDate.toIso8601String(),
      'documentType': _$DriverDocumentTypeEnumMap[instance.documentType],
      'documentReference': instance.documentReference,
      'total': instance.total,
      'openingBalance': instance.openingBalance,
      'closingBalance': instance.closingBalance,
    };

const _$DriverDocumentTypeEnumMap = {
  DriverDocumentType.invoice: 0,
  DriverDocumentType.credit: 1,
  DriverDocumentType.payment: 2,
};
