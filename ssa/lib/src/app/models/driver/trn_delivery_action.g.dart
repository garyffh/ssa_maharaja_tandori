// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_delivery_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnDeliveryAction _$TrnDeliveryActionFromJson(Map<String, dynamic> json) =>
    TrnDeliveryAction(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      trnOrderId: json['trnOrderId'] as String,
      deliveryMethodStatus: $enumDecode(
          _$TrnOrderDeliveryMethodStatusEnumMap, json['deliveryMethodStatus']),
      storeStatus:
          $enumDecode(_$TrnOrderStoreStatusEnumMap, json['storeStatus']),
      deliveryMethodStatusDT:
          DateTime.parse(json['deliveryMethodStatusDT'] as String),
      storeStatusDT: DateTime.parse(json['storeStatusDT'] as String),
    );

Map<String, dynamic> _$TrnDeliveryActionToJson(TrnDeliveryAction instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'trnOrderId': instance.trnOrderId,
      'deliveryMethodStatus':
          _$TrnOrderDeliveryMethodStatusEnumMap[instance.deliveryMethodStatus],
      'storeStatus': _$TrnOrderStoreStatusEnumMap[instance.storeStatus],
      'deliveryMethodStatusDT':
          instance.deliveryMethodStatusDT.toIso8601String(),
      'storeStatusDT': instance.storeStatusDT.toIso8601String(),
    };

const _$TrnOrderDeliveryMethodStatusEnumMap = {
  TrnOrderDeliveryMethodStatus.scheduled: 0,
  TrnOrderDeliveryMethodStatus.preparing: 1,
  TrnOrderDeliveryMethodStatus.readyForPickup: 2,
  TrnOrderDeliveryMethodStatus.delivering: 3,
  TrnOrderDeliveryMethodStatus.completed: 4,
  TrnOrderDeliveryMethodStatus.cancelled: 5,
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
