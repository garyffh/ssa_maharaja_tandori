// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverInvoice _$DriverInvoiceFromJson(Map<String, dynamic> json) =>
    DriverInvoice(
      documentId: json['documentId'] as String,
      createdDT: json['createdDT'] as String,
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentDT: DateTime.parse(json['documentDT'] as String),
      documentReference: json['documentReference'] as String,
      totalEx: (json['totalEx'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$DriverInvoiceToJson(DriverInvoice instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'createdDT': instance.createdDT,
      'documentDate': instance.documentDate.toIso8601String(),
      'documentDT': instance.documentDT.toIso8601String(),
      'documentReference': instance.documentReference,
      'totalEx': instance.totalEx,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
      'balance': instance.balance,
    };
