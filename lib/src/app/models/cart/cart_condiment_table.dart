import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/products/condiment_table.dart';
import 'package:single_store_app/src/app/models/products/condiment_table_item.dart';

import 'cart_condiment_table_item.dart';

@immutable
class CartCondimentTable {
  const CartCondimentTable({
    required this.index,
    required this.priceLevel,
    required this.sysCondimentTableId,
    required this.number,
    required this.name,
    required this.multiple,
    required this.tQty,
    required this.defaultItem,
    required this.items,
    required this.selectedItems,
  });

  CartCondimentTable.fromCondimentTable({
    required this.index,
    required double qty,
    required this.priceLevel,
    required CondimentTable condimentTable,
  })  : sysCondimentTableId = condimentTable.sysCondimentTableId,
        number = condimentTable.number,
        name = condimentTable.name,
        multiple = condimentTable.multiple,
        tQty = condimentTable.tQty,
        defaultItem = condimentTable.defaultItem,
        items = itemsFromCondimentTable(
          qty: qty,
          priceLevel: priceLevel,
          condimentTableItems: condimentTable.items,
        ),
        selectedItems = List.empty(growable: true);

  CartCondimentTable.update({
    required this.index,
    required double qty,
    required this.priceLevel,
    required CartCondimentTable cartCondimentTable,
  })  : sysCondimentTableId = cartCondimentTable.sysCondimentTableId,
        number = cartCondimentTable.number,
        name = cartCondimentTable.name,
        multiple = cartCondimentTable.multiple,
        tQty = cartCondimentTable.tQty,
        defaultItem = cartCondimentTable.defaultItem,
        items = updateItems(
          qty: qty,
          priceLevel: priceLevel,
          cartCondimentTableItems: cartCondimentTable.items,
        ),
        selectedItems = updateSelectedItems(
          qty: qty,
          priceLevel: priceLevel,
          selectedItems: cartCondimentTable.selectedItems,
        );

  final int index;
  final int priceLevel;
  final String sysCondimentTableId;
  final int number;
  final String name;
  final bool multiple;
  final double tQty;
  final bool defaultItem;
  final List<CartCondimentTableItem> items;
  final List<CartCondimentTableItem> selectedItems;

  static List<CartCondimentTableItem> itemsFromCondimentTable({
    required double qty,
    required int priceLevel,
    required List<CondimentTableItem> condimentTableItems,
  }) {
    return List<CartCondimentTableItem>.generate(
      condimentTableItems.length,
      (index) => CartCondimentTableItem.fromCondimentTableItem(
          qty: qty, priceLevel: priceLevel, item: condimentTableItems[index]),
    );
  }

  static List<CartCondimentTableItem> updateItems({
    required double qty,
    required int priceLevel,
    required List<CartCondimentTableItem> cartCondimentTableItems,
  }) {
    return List<CartCondimentTableItem>.generate(
      cartCondimentTableItems.length,
      (index) => CartCondimentTableItem.fromCartCondimentTableItem(
          qty: qty,
          priceLevel: priceLevel,
          item: cartCondimentTableItems[index]),
    );
  }

  static List<CartCondimentTableItem> updateSelectedItems({
    required double qty,
    required int priceLevel,
    required List<CartCondimentTableItem> selectedItems,
  }) {
    return List<CartCondimentTableItem>.generate(
      selectedItems.length,
      (index) => CartCondimentTableItem.fromCartCondimentTableItem(
          qty: qty, priceLevel: priceLevel, item: selectedItems[index]),
      growable: true,
    );
  }

  String? get selectedItemsText {
    return selectedItems.isEmpty ? null : selectedItems.map<String>((val) => val.name.trim()).join(', ');
  }

  String get id {
    return '$sysCondimentTableId${index.toString()}';
  }

  String get selectText {
    if (tQty == 0) {
      return 'Select Any';
    } else {
      return 'Select ${Formats.qty(tQty)}';
    }
  }

  bool get isSingleSelection {
    return tQty == 1.0;
  }

  void updateQty(double qty) {}
}
