import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_active_item.dart';
import 'cart_store_chain.dart';

part 'cart_store_item.g.dart';

@JsonSerializable()
@immutable
class CartStoreItem {
  const CartStoreItem({
    required this.qty,
    required this.priceLevel,
    this.instructions,
    required this.sysSitemId,
    required this.name,
    this.cartStoreChain,
  });

  CartStoreItem.fromCartActiveItem(CartActiveItem cartActiveItem)
      : qty = cartActiveItem.qty,
        priceLevel = cartActiveItem.priceLevel,
        instructions = cartActiveItem.instructions,
        sysSitemId = cartActiveItem.sysSitemId,
        name = cartActiveItem.name,
        cartStoreChain = cartActiveItem.cartActiveChain == null
            ? null
            : CartStoreChain.fromCartActiveChain(
                cartActiveItem.cartActiveChain!);

  factory CartStoreItem.fromJson(Map<String, dynamic> json) =>
      _$CartStoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartStoreItemToJson(this);

  static List<CartStoreItem> listFromCartActiveItems(
      List<CartActiveItem> cartActiveItems) {
    return List<CartStoreItem>.generate(
      cartActiveItems.length,
      (int index) => CartStoreItem.fromCartActiveItem(cartActiveItems[index]),
      growable: false,
    );
  }

  final double qty;
  final int priceLevel;
  final String? instructions;
  final String sysSitemId;
  final String name;
  final CartStoreChain? cartStoreChain;
}
