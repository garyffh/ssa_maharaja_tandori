// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrderRead _$TrnOrderReadFromJson(Map<String, dynamic> json) => TrnOrderRead(
      trnOrderId: json['trnOrderId'] as String,
      reference: json['reference'] as String,
      deliveryMethodType:
          $enumDecode(_$DeliveryMethodTypeEnumMap, json['deliveryMethodType']),
      storeStatus:
          $enumDecode(_$TrnOrderStoreStatusEnumMap, json['storeStatus']),
      deliveryMethodStatus: $enumDecode(
          _$TrnOrderDeliveryMethodStatusEnumMap, json['deliveryMethodStatus']),
      orderDT: DateTime.parse(json['orderDT'] as String),
      scheduledStoreTime: DateTime.parse(json['scheduledStoreTime'] as String),
      scheduledDeliveryMethodTime:
          DateTime.parse(json['scheduledDeliveryMethodTime'] as String),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$TrnOrderReadToJson(TrnOrderRead instance) =>
    <String, dynamic>{
      'trnOrderId': instance.trnOrderId,
      'reference': instance.reference,
      'deliveryMethodType':
          _$DeliveryMethodTypeEnumMap[instance.deliveryMethodType],
      'storeStatus': _$TrnOrderStoreStatusEnumMap[instance.storeStatus],
      'deliveryMethodStatus':
          _$TrnOrderDeliveryMethodStatusEnumMap[instance.deliveryMethodStatus],
      'orderDT': instance.orderDT.toIso8601String(),
      'scheduledStoreTime': instance.scheduledStoreTime.toIso8601String(),
      'scheduledDeliveryMethodTime':
          instance.scheduledDeliveryMethodTime.toIso8601String(),
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.store: 0,
  DeliveryMethodType.delivery: 1,
  DeliveryMethodType.table: 2,
  DeliveryMethodType.period: 3,
};

const _$TrnOrderStoreStatusEnumMap = {
  TrnOrderStoreStatus.scheduled: 0,
  TrnOrderStoreStatus.noDriver: 1,
  TrnOrderStoreStatus.queued: 2,
  TrnOrderStoreStatus.preparing: 3,
  TrnOrderStoreStatus.waitingForPickup: 4,
  TrnOrderStoreStatus.waitingForDelivery: 5,
  TrnOrderStoreStatus.delivering: 6,
  TrnOrderStoreStatus.completed: 7,
  TrnOrderStoreStatus.cancelled: 8,
};

const _$TrnOrderDeliveryMethodStatusEnumMap = {
  TrnOrderDeliveryMethodStatus.scheduled: 0,
  TrnOrderDeliveryMethodStatus.preparing: 1,
  TrnOrderDeliveryMethodStatus.readyForPickup: 2,
  TrnOrderDeliveryMethodStatus.delivering: 3,
  TrnOrderDeliveryMethodStatus.completed: 4,
  TrnOrderDeliveryMethodStatus.cancelled: 5,
};
