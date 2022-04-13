// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrderUpdate _$TrnOrderUpdateFromJson(Map<String, dynamic> json) =>
    TrnOrderUpdate(
      method: json['method'] as String,
      trnOrderId: json['trnOrderId'] as String,
      deliveryMethodType: json['deliveryMethodType'] as String,
      deliveryMethodStatus: json['deliveryMethodStatus'] as String,
      storeStatus: json['storeStatus'] as String,
      deliveryMethodStatusDT:
          DateTime.parse(json['deliveryMethodStatusDT'] as String),
      storeStatusDT: DateTime.parse(json['storeStatusDT'] as String),
    );

Map<String, dynamic> _$TrnOrderUpdateToJson(TrnOrderUpdate instance) =>
    <String, dynamic>{
      'method': instance.method,
      'trnOrderId': instance.trnOrderId,
      'deliveryMethodType': instance.deliveryMethodType,
      'deliveryMethodStatus': instance.deliveryMethodStatus,
      'storeStatus': instance.storeStatus,
      'deliveryMethodStatusDT':
          instance.deliveryMethodStatusDT.toIso8601String(),
      'storeStatusDT': instance.storeStatusDT.toIso8601String(),
    };
