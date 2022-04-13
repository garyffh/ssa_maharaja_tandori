import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'cart_condiment_table.dart';
import 'cart_store_condiment_table_item.dart';

part 'cart_store_condiment_table.g.dart';

@JsonSerializable()
@immutable
class CartStoreCondimentTable {
  const CartStoreCondimentTable({
    required this.index,
    required this.sysCondimentTableId,
    required this.name,
    required this.selectedItems,
  });

  CartStoreCondimentTable.fromCartCondimentTable(
      CartCondimentTable cartCondimentTable)
      : index = cartCondimentTable.index,
        sysCondimentTableId = cartCondimentTable.sysCondimentTableId,
        name = cartCondimentTable.name,
        selectedItems =
            CartStoreCondimentTableItem.listFromCartCondimentTableItems(
                cartCondimentTable.selectedItems);

  factory CartStoreCondimentTable.fromJson(Map<String, dynamic> json) =>
      _$CartStoreCondimentTableFromJson(json);

  Map<String, dynamic> toJson() => _$CartStoreCondimentTableToJson(this);

  static List<CartStoreCondimentTable> listFromCartCondimentTables(
      List<CartCondimentTable> cartCondimentTables) {
    return List<CartStoreCondimentTable>.generate(
      cartCondimentTables.length,
      (int index) => CartStoreCondimentTable.fromCartCondimentTable(
          cartCondimentTables[index]),
      growable: false,
    );
  }

  final int index;
  final String sysCondimentTableId;
  final String name;
  final List<CartStoreCondimentTableItem> selectedItems;

  String get id {
    return '$sysCondimentTableId${index.toString()}';
  }

}
