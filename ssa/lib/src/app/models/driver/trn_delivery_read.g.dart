// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_delivery_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnDeliveryRead _$TrnDeliveryReadFromJson(Map<String, dynamic> json) =>
    TrnDeliveryRead(
      updateId:
          const Uint8ListNullConverter().fromJson(json['updateId'] as String?),
      trnOrderId: json['trnOrderId'] as String,
      reference: json['reference'] as String,
      storeStatus:
          $enumDecode(_$TrnOrderStoreStatusEnumMap, json['storeStatus']),
      deliveryMethodStatus: $enumDecode(
          _$TrnOrderDeliveryMethodStatusEnumMap, json['deliveryMethodStatus']),
      scheduledStoreTime: DateTime.parse(json['scheduledStoreTime'] as String),
      scheduledDeliveryMethodTime:
          DateTime.parse(json['scheduledDeliveryMethodTime'] as String),
      deliveryMethodAsap: json['deliveryMethodAsap'] as bool,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$TrnDeliveryReadToJson(TrnDeliveryRead instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListNullConverter().toJson(instance.updateId),
      'trnOrderId': instance.trnOrderId,
      'reference': instance.reference,
      'storeStatus': _$TrnOrderStoreStatusEnumMap[instance.storeStatus],
      'deliveryMethodStatus':
          _$TrnOrderDeliveryMethodStatusEnumMap[instance.deliveryMethodStatus],
      'scheduledStoreTime': instance.scheduledStoreTime.toIso8601String(),
      'scheduledDeliveryMethodTime':
          instance.scheduledDeliveryMethodTime.toIso8601String(),
      'deliveryMethodAsap': instance.deliveryMethodAsap,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
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
