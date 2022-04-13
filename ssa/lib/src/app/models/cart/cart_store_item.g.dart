// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartStoreItem _$CartStoreItemFromJson(Map<String, dynamic> json) =>
    CartStoreItem(
      qty: (json['qty'] as num).toDouble(),
      priceLevel: json['priceLevel'] as int,
      instructions: json['instructions'] as String?,
      sysSitemId: json['sysSitemId'] as String,
      name: json['name'] as String,
      cartStoreChain: json['cartStoreChain'] == null
          ? null
          : CartStoreChain.fromJson(
              json['cartStoreChain'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartStoreItemToJson(CartStoreItem instance) =>
    <String, dynamic>{
      'qty': instance.qty,
      'priceLevel': instance.priceLevel,
      'instructions': instance.instructions,
      'sysSitemId': instance.sysSitemId,
      'name': instance.name,
      'cartStoreChain': instance.cartStoreChain,
    };
