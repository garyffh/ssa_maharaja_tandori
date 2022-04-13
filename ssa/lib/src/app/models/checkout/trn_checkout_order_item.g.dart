// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_checkout_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnCheckoutOrderItem _$TrnCheckoutOrderItemFromJson(
        Map<String, dynamic> json) =>
    TrnCheckoutOrderItem(
      itemNumber: json['itemNumber'] as int,
      itemTypeId: json['itemTypeId'] as int,
      isReadable: json['isReadable'] as bool,
      isCondiment: json['isCondiment'] as bool,
      isInstructions: json['isInstructions'] as bool,
      isScale: json['isScale'] as bool,
      name: json['name'] as String,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      description: json['description'] as String,
      taxable: json['taxable'] as bool,
      quantity: (json['quantity'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      totalExTax: (json['totalExTax'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      spendPoints: json['spendPoints'] as int,
      productPoints: json['productPoints'] as int,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$TrnCheckoutOrderItemToJson(
        TrnCheckoutOrderItem instance) =>
    <String, dynamic>{
      'itemNumber': instance.itemNumber,
      'itemTypeId': instance.itemTypeId,
      'isReadable': instance.isReadable,
      'isCondiment': instance.isCondiment,
      'isInstructions': instance.isInstructions,
      'isScale': instance.isScale,
      'name': instance.name,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'description': instance.description,
      'taxable': instance.taxable,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'totalExTax': instance.totalExTax,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
      'spendPoints': instance.spendPoints,
      'productPoints': instance.productPoints,
      'currency': instance.currency,
    };
