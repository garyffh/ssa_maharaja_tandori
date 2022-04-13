// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrderItem _$TrnOrderItemFromJson(Map<String, dynamic> json) => TrnOrderItem(
      itemNumber: json['itemNumber'] as int,
      itemTypeId: json['itemTypeId'] as int,
      isReadable: json['isReadable'] as bool,
      isCondiment: json['isCondiment'] as bool,
      isInstructions: json['isInstructions'] as bool,
      isScale: json['isScale'] as bool,
      description: json['description'] as String,
      exTaxTotal: (json['exTaxTotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      productPoints: json['productPoints'] as int,
      spendPoints: json['spendPoints'] as int,
      qty: (json['qty'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      sysSitemId: json['sysSitemId'] as String?,
      sysSitem: json['sysSitem'] as String?,
      plu: json['plu'] as String,
    );

Map<String, dynamic> _$TrnOrderItemToJson(TrnOrderItem instance) =>
    <String, dynamic>{
      'itemNumber': instance.itemNumber,
      'itemTypeId': instance.itemTypeId,
      'isReadable': instance.isReadable,
      'isCondiment': instance.isCondiment,
      'isInstructions': instance.isInstructions,
      'isScale': instance.isScale,
      'description': instance.description,
      'exTaxTotal': instance.exTaxTotal,
      'total': instance.total,
      'productPoints': instance.productPoints,
      'spendPoints': instance.spendPoints,
      'qty': instance.qty,
      'unitPrice': instance.unitPrice,
      'sysSitemId': instance.sysSitemId,
      'sysSitem': instance.sysSitem,
      'plu': instance.plu,
    };
