import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'cart_active.dart';
import 'cart_store_item.dart';

part 'cart_store.g.dart';

@JsonSerializable()
@immutable
class CartStore {
  const CartStore({
    this.deliveryMethodType,
    required this.items,
  });

  CartStore.fromCartActive(CartActive cartActive)
      : deliveryMethodType = cartActive.deliveryMethodType,
        items = CartStoreItem.listFromCartActiveItems(cartActive.items);

  CartStore.empty()
      : deliveryMethodType = null,
        items = List.empty(growable: false);

  factory CartStore.fromJson(Map<String, dynamic> json) =>
      _$CartStoreFromJson(json);

  Map<String, dynamic> toJson() => _$CartStoreToJson(this);

  final DeliveryMethodType? deliveryMethodType;
  final List<CartStoreItem> items;
}
