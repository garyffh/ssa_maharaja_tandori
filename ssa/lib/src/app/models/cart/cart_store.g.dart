// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartStore _$CartStoreFromJson(Map<String, dynamic> json) => CartStore(
      deliveryMethodType: $enumDecodeNullable(
          _$DeliveryMethodTypeEnumMap, json['deliveryMethodType']),
      items: (json['items'] as List<dynamic>)
          .map((e) => CartStoreItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartStoreToJson(CartStore instance) => <String, dynamic>{
      'deliveryMethodType':
          _$DeliveryMethodTypeEnumMap[instance.deliveryMethodType],
      'items': instance.items,
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.store: 0,
  DeliveryMethodType.delivery: 1,
  DeliveryMethodType.table: 2,
  DeliveryMethodType.period: 3,
};
