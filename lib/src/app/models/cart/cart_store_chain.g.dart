// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartStoreChain _$CartStoreChainFromJson(Map<String, dynamic> json) =>
    CartStoreChain(
      source: $enumDecode(_$CartCondimentChainSourceEnumMap, json['source']),
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CartStoreCondimentTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartStoreChainToJson(CartStoreChain instance) =>
    <String, dynamic>{
      'source': _$CartCondimentChainSourceEnumMap[instance.source],
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };

const _$CartCondimentChainSourceEnumMap = {
  CartCondimentChainSource.condimentTable: 0,
  CartCondimentChainSource.condimentChain: 1,
};
