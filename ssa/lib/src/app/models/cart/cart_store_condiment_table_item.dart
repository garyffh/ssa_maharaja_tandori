import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_condiment_table_item.dart';

part 'cart_store_condiment_table_item.g.dart';

@JsonSerializable()
@immutable
class CartStoreCondimentTableItem {
  const CartStoreCondimentTableItem({
    required this.sysSitemId,
    required this.name,
  });

  CartStoreCondimentTableItem.fromCartCondimentTableItem(
      CartCondimentTableItem cartCondimentTableItem)
      : sysSitemId = cartCondimentTableItem.sysSitemId,
        name = cartCondimentTableItem.name;

  factory CartStoreCondimentTableItem.fromJson(Map<String, dynamic> json) =>
      _$CartStoreCondimentTableItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartStoreCondimentTableItemToJson(this);

  static List<CartStoreCondimentTableItem> listFromCartCondimentTableItems(
      List<CartCondimentTableItem> cartCondimentTableItems) {
    return List<CartStoreCondimentTableItem>.generate(
      cartCondimentTableItems.length,
      (int index) => CartStoreCondimentTableItem.fromCartCondimentTableItem(
          cartCondimentTableItems[index]),
      growable: false,
    );
  }

  final String sysSitemId;
  final String name;
}
