import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_active_chain.dart';
import 'cart_condiment_chain_source.dart';
import 'cart_store_condiment_table.dart';

part 'cart_store_chain.g.dart';

@JsonSerializable()
@immutable
class CartStoreChain {
  const CartStoreChain({
    required this.source,
    required this.id,
    required this.name,
    required this.items,
  });

  CartStoreChain.fromCartActiveChain(CartActiveChain cartActiveChain)
      : source = cartActiveChain.source,
        id = cartActiveChain.id,
        name = cartActiveChain.name,
        items = CartStoreCondimentTable.listFromCartCondimentTables(
            cartActiveChain.items);

  factory CartStoreChain.fromJson(Map<String, dynamic> json) =>
      _$CartStoreChainFromJson(json);

  Map<String, dynamic> toJson() => _$CartStoreChainToJson(this);

  final CartCondimentChainSource source;
  final String id;
  final String name;
  final List<CartStoreCondimentTable> items;
}
