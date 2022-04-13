import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/products/condiment_chain.dart';
import 'package:single_store_app/src/app/models/products/condiment_table.dart';

import 'cart_condiment_chain_source.dart';
import 'cart_condiment_table.dart';
import 'cart_condiment_table_item.dart';

@immutable
class CartActiveChain {
  const CartActiveChain({
    required this.priceLevel,
    required this.source,
    required this.id,
    required this.number,
    required this.name,
    required this.items,
  });

  CartActiveChain.fromCondimentChain({
    required double qty,
    required this.priceLevel,
    required CondimentChain condimentChain,
  })  : source = CartCondimentChainSource.condimentChain,
        id = condimentChain.sysCondimentChainId,
        number = condimentChain.number,
        name = condimentChain.name,
        items = itemsFromCondimentChain(
          qty: qty,
          priceLevel: priceLevel,
          condimentTables: condimentChain.condimentTables,
        );

  CartActiveChain.fromCondimentTable({
    required double qty,
    required this.priceLevel,
    required CondimentTable condimentTable,
  })  : source = CartCondimentChainSource.condimentTable,
        id = condimentTable.sysCondimentTableId,
        number = condimentTable.number,
        name = condimentTable.name,
        items = itemsFromCondimentTable(
          qty: qty,
          priceLevel: priceLevel,
          condimentTable: condimentTable,
        );

  CartActiveChain.update({
    required double qty,
    required this.priceLevel,
    required CartActiveChain cartActiveChain,
  })  : source = cartActiveChain.source,
        id = cartActiveChain.id,
        number = cartActiveChain.number,
        name = cartActiveChain.name,
        items = updateItems(
          qty: qty,
          priceLevel: priceLevel,
          cartCondimentTables: cartActiveChain.items,
        );

  final int priceLevel;
  final CartCondimentChainSource source;
  final String id;
  final int number;
  final String name;
  final List<CartCondimentTable> items;

  static List<CartCondimentTable> itemsFromCondimentChain({
    required double qty,
    required int priceLevel,
    required List<CondimentTable> condimentTables,
  }) {
    return List<CartCondimentTable>.generate(
      condimentTables.length,
      (index) => CartCondimentTable.fromCondimentTable(
        index: index,
        qty: qty,
        priceLevel: priceLevel,
        condimentTable: condimentTables[index],
      ),
    );
  }

  static List<CartCondimentTable> itemsFromCondimentTable({
    required double qty,
    required int priceLevel,
    required CondimentTable condimentTable,
  }) {
    return [
      CartCondimentTable.fromCondimentTable(
        index: 0,
        qty: qty,
        priceLevel: priceLevel,
        condimentTable: condimentTable,
      ),
    ];
  }

  static List<CartCondimentTable> updateItems({
    required double qty,
    required int priceLevel,
    required List<CartCondimentTable> cartCondimentTables,
  }) {
    return List<CartCondimentTable>.generate(
      cartCondimentTables.length,
          (index) => CartCondimentTable.update(
            index: index,
        qty: qty,
        priceLevel: priceLevel,
        cartCondimentTable: cartCondimentTables[index],
      ),
    );
  }

  List<CartCondimentTableItem> get selectedItems {
    final List<CartCondimentTableItem> rtn = List.empty(growable: true);
    for(final CartCondimentTable cartCondimentTable in items) {
      rtn.addAll([...cartCondimentTable.selectedItems]);
    }
    return rtn;
  }
}
