// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_checkout_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnCheckoutOrder _$TrnCheckoutOrderFromJson(Map<String, dynamic> json) =>
    TrnCheckoutOrder(
      identity: json['identity'] as String,
      documentId: json['documentId'] as String?,
      documentDate: json['documentDate'] == null
          ? null
          : DateTime.parse(json['documentDate'] as String),
      orderNumber: json['orderNumber'] as String?,
      pagerNumber: json['pagerNumber'] as int?,
      version: json['version'] as int,
      priceLevel: json['priceLevel'] as int,
      adjustmentType: json['adjustmentType'] as int,
      adjustmentAmount: (json['adjustmentAmount'] as num).toDouble(),
      storeDeliveryZoneId: json['storeDeliveryZoneId'] as String?,
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      promotionRate: (json['promotionRate'] as num).toDouble(),
      promotionAmount: (json['promotionAmount'] as num).toDouble(),
      promotionPoints: json['promotionPoints'] as int,
      deliveryPromotion: json['deliveryPromotion'] as bool,
      totalEx: (json['totalEx'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      spendPoints: json['spendPoints'] as int,
      productPoints: json['productPoints'] as int,
      redeemPoints: json['redeemPoints'] as int,
      redeemCurrency: (json['redeemCurrency'] as num).toDouble(),
      storeStatusTime: json['storeStatusTime'] as String,
      deliveryMethodType:
          $enumDecode(_$DeliveryMethodTypeEnumMap, json['deliveryMethodType']),
      deliveryMethodAsap: json['deliveryMethodAsap'] as bool,
      scheduledDeliveryMethodTime:
          json['scheduledDeliveryMethodTime'] as String?,
      storePrepTime: json['storePrepTime'] as int,
      driverDeliveryTime: json['driverDeliveryTime'] as int,
      orderComment: json['orderComment'] as String?,
      billing: TrnCheckoutOrderBilling.fromJson(
          json['billing'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => TrnCheckoutOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrnCheckoutOrderToJson(TrnCheckoutOrder instance) =>
    <String, dynamic>{
      'identity': instance.identity,
      'documentId': instance.documentId,
      'documentDate': instance.documentDate?.toIso8601String(),
      'orderNumber': instance.orderNumber,
      'pagerNumber': instance.pagerNumber,
      'version': instance.version,
      'priceLevel': instance.priceLevel,
      'adjustmentType': instance.adjustmentType,
      'adjustmentAmount': instance.adjustmentAmount,
      'storeDeliveryZoneId': instance.storeDeliveryZoneId,
      'deliveryFee': instance.deliveryFee,
      'promotionRate': instance.promotionRate,
      'promotionAmount': instance.promotionAmount,
      'promotionPoints': instance.promotionPoints,
      'deliveryPromotion': instance.deliveryPromotion,
      'totalEx': instance.totalEx,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
      'spendPoints': instance.spendPoints,
      'productPoints': instance.productPoints,
      'redeemPoints': instance.redeemPoints,
      'redeemCurrency': instance.redeemCurrency,
      'storeStatusTime': instance.storeStatusTime,
      'deliveryMethodType':
          _$DeliveryMethodTypeEnumMap[instance.deliveryMethodType],
      'deliveryMethodAsap': instance.deliveryMethodAsap,
      'scheduledDeliveryMethodTime': instance.scheduledDeliveryMethodTime,
      'storePrepTime': instance.storePrepTime,
      'driverDeliveryTime': instance.driverDeliveryTime,
      'orderComment': instance.orderComment,
      'billing': instance.billing,
      'items': instance.items,
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.store: 0,
  DeliveryMethodType.delivery: 1,
  DeliveryMethodType.table: 2,
  DeliveryMethodType.period: 3,
};
