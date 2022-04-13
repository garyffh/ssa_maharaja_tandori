// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrder _$TrnOrderFromJson(Map<String, dynamic> json) => TrnOrder(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      trnOrderId: json['trnOrderId'] as String,
      orderDT: DateTime.parse(json['orderDT'] as String),
      source: json['source'] as String,
      reference: json['reference'] as String,
      sentFfh: json['sentFfh'] as bool,
      storeStatus:
          $enumDecode(_$TrnOrderStoreStatusEnumMap, json['storeStatus']),
      deliveryMethodStatus: $enumDecode(
          _$TrnOrderDeliveryMethodStatusEnumMap, json['deliveryMethodStatus']),
      currency: json['currency'] as String,
      totalEx: (json['totalEx'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num?)?.toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      orderNumber: json['orderNumber'] as String,
      pagerNumber: json['pagerNumber'] as int?,
      storeTimeZone: json['storeTimeZone'] as String,
      deliveryMethodType:
          $enumDecode(_$DeliveryMethodTypeEnumMap, json['deliveryMethodType']),
      scheduledStoreTime: DateTime.parse(json['scheduledStoreTime'] as String),
      scheduledDeliveryMethodTime:
          DateTime.parse(json['scheduledDeliveryMethodTime'] as String),
      deliveryMethodAsap: json['deliveryMethodAsap'] as bool,
      company: json['company'] as String,
      companyNumber: json['companyNumber'] as String,
      addressNote: json['addressNote'] as String,
      street: json['street'] as String,
      extended: json['extended'] as String,
      locality: json['locality'] as String,
      region: json['region'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      timeZone: json['timeZone'] as String,
      distance: (json['distance'] as num?)?.toDouble(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      orderComment: json['orderComment'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => TrnOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      driver: json['driver'] == null
          ? null
          : TrnOrderDriver.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrnOrderToJson(TrnOrder instance) => <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'trnOrderId': instance.trnOrderId,
      'orderDT': instance.orderDT.toIso8601String(),
      'source': instance.source,
      'reference': instance.reference,
      'sentFfh': instance.sentFfh,
      'storeStatus': _$TrnOrderStoreStatusEnumMap[instance.storeStatus],
      'deliveryMethodStatus':
          _$TrnOrderDeliveryMethodStatusEnumMap[instance.deliveryMethodStatus],
      'currency': instance.currency,
      'totalEx': instance.totalEx,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
      'paidAmount': instance.paidAmount,
      'deliveryCost': instance.deliveryCost,
      'deliveryFee': instance.deliveryFee,
      'orderNumber': instance.orderNumber,
      'pagerNumber': instance.pagerNumber,
      'storeTimeZone': instance.storeTimeZone,
      'deliveryMethodType':
          _$DeliveryMethodTypeEnumMap[instance.deliveryMethodType],
      'scheduledStoreTime': instance.scheduledStoreTime.toIso8601String(),
      'scheduledDeliveryMethodTime':
          instance.scheduledDeliveryMethodTime.toIso8601String(),
      'deliveryMethodAsap': instance.deliveryMethodAsap,
      'company': instance.company,
      'companyNumber': instance.companyNumber,
      'addressNote': instance.addressNote,
      'street': instance.street,
      'extended': instance.extended,
      'locality': instance.locality,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'lat': instance.lat,
      'lng': instance.lng,
      'timeZone': instance.timeZone,
      'distance': instance.distance,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'orderComment': instance.orderComment,
      'items': instance.items,
      'driver': instance.driver,
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

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.store: 0,
  DeliveryMethodType.delivery: 1,
  DeliveryMethodType.table: 2,
  DeliveryMethodType.period: 3,
};
