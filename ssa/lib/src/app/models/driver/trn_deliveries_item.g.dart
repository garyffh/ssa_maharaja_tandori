// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_deliveries_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnDeliveriesItem _$TrnDeliveriesItemFromJson(Map<String, dynamic> json) =>
    TrnDeliveriesItem(
      itemNumber: json['itemNumber'] as int,
      itemTypeId: json['itemTypeId'] as int,
      isReadable: json['isReadable'] as bool,
      isCondiment: json['isCondiment'] as bool,
      isInstructions: json['isInstructions'] as bool,
      isScale: json['isScale'] as bool,
      description: json['description'] as String,
      exTaxTotal: (json['exTaxTotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      qty: (json['qty'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      sysSitemId: json['sysSitemId'] as String?,
      sysSitem: json['sysSitem'] as String?,
      plu: json['plu'] as String,
    );

Map<String, dynamic> _$TrnDeliveriesItemToJson(TrnDeliveriesItem instance) =>
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
      'qty': instance.qty,
      'unitPrice': instance.unitPrice,
      'sysSitemId': instance.sysSitemId,
      'sysSitem': instance.sysSitem,
      'plu': instance.plu,
    };
