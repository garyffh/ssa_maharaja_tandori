import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'cart_active_item.dart';
import 'cart_condiment_table.dart';
import 'cart_condiment_table_item.dart';
import 'cart_totals.dart';

@immutable
class CartActive {
  const CartActive({
    required this.priceLevel,
    this.deliveryMethodType,
    required this.items,
  });

  /// For price level change when all items require an update
  CartActive.priceLevelUpdate({
    required this.priceLevel,
    this.deliveryMethodType,
    required CartActive cartActive,
  }) : items = updateItems(priceLevel: priceLevel, items: cartActive.items);

  static List<CartActiveItem> updateItems({
    required int priceLevel,
    required List<CartActiveItem> items,
  }) {
    return List<CartActiveItem>.generate(
      items.length,
      (index) => CartActiveItem.update(
        priceLevel: priceLevel,
        cartActiveItem: items[index],
      ),
    );
  }

  final int priceLevel;
  final DeliveryMethodType? deliveryMethodType;
  final List<CartActiveItem> items;

  CartTotals calculateCartTotals() {
    double qty = 0;
    double total = 0;

    for (final CartActiveItem cartActiveItem in items) {
      qty += cartActiveItem.qty;
      total += cartActiveItem.total;

      if (cartActiveItem.cartActiveChain != null) {
        for (final CartCondimentTable cartCondimentTable
            in cartActiveItem.cartActiveChain!.items) {
          for (final CartCondimentTableItem cartCondimentTableItem
              in cartCondimentTable.selectedItems) {
            total += cartCondimentTableItem.total;
          }
        }
      }
    }

    return CartTotals(qty: qty, total: total);
  }
}
