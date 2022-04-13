// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverPayment _$DriverPaymentFromJson(Map<String, dynamic> json) =>
    DriverPayment(
      documentId: json['documentId'] as String,
      createdDT: json['createdDT'] as String,
      documentDate: DateTime.parse(json['documentDate'] as String),
      documentDT: DateTime.parse(json['documentDT'] as String),
      documentReference: json['documentReference'] as String,
      comment: json['comment'] as String,
      total: (json['total'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$DriverPaymentToJson(DriverPayment instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'createdDT': instance.createdDT,
      'documentDate': instance.documentDate.toIso8601String(),
      'documentDT': instance.documentDT.toIso8601String(),
      'documentReference': instance.documentReference,
      'comment': instance.comment,
      'total': instance.total,
      'balance': instance.balance,
    };
