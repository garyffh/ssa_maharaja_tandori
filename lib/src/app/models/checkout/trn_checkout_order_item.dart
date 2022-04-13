import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table_item.dart';

part 'trn_checkout_order_item.g.dart';

@JsonSerializable()
@immutable
class TrnCheckoutOrderItem {
  const TrnCheckoutOrderItem({
    required this.itemNumber,
    required this.itemTypeId,
    required this.isReadable,
    required this.isCondiment,
    required this.isInstructions,
    required this.isScale,
    required this.name,
    required this.productId,
    required this.productCode,
    required this.description,
    required this.taxable,
    required this.quantity,
    required this.discount,
    required this.totalExTax,
    required this.taxAmount,
    required this.total,
    required this.spendPoints,
    required this.productPoints,
    required this.currency,
  });

  TrnCheckoutOrderItem.fromCartActiveItem({
    required this.itemNumber,
    required this.totalExTax,
    required CartActiveItem cartActiveItem,
  })  : itemTypeId = 3,
        isReadable = true,
        isCondiment = false,
        isInstructions = false,
        isScale = cartActiveItem.scale,
        name = cartActiveItem.name,
        productId = cartActiveItem.sysSitemId,
        productCode = null,
        description = cartActiveItem.name,
        taxable = cartActiveItem.tax != 0,
        quantity = cartActiveItem.qty,
        discount = 0.0,
        taxAmount = cartActiveItem.total - totalExTax,
        total = cartActiveItem.total,
        spendPoints = 0,
        productPoints = 0,
        currency = 'AUD';

  TrnCheckoutOrderItem.fromCartCondimentTableItem({
    required this.itemNumber,
    required this.totalExTax,
    required CartCondimentTableItem cartCondimentTableItem,
  })  : itemTypeId = 10,
        isReadable = true,
        isCondiment = true,
        isInstructions = false,
        isScale = false,
        name = cartCondimentTableItem.name,
        productId = cartCondimentTableItem.sysSitemId,
        productCode = null,
        description = cartCondimentTableItem.name,
        taxable = cartCondimentTableItem.tax != 0,
        quantity = cartCondimentTableItem.qty,
        discount = 0.0,
        taxAmount = cartCondimentTableItem.total - totalExTax,
        total = cartCondimentTableItem.total,
        spendPoints = 0,
        productPoints = 0,
        currency = 'AUD';

  const TrnCheckoutOrderItem.fromInstructions({
    required this.itemNumber,
    required String instructions,
  })  : itemTypeId = 10,
        isReadable = true,
        isCondiment = true,
        isInstructions = true,
        isScale = false,
        name = instructions,
        productId = null,
        productCode = null,
        description = instructions,
        taxable = false,
        quantity = 1.0,
        discount = 0.0,
        taxAmount = 0.0,
        totalExTax = 0.0,
        total = 0.0,
        spendPoints = 0,
        productPoints = 0,
        currency = 'AUD';


  factory TrnCheckoutOrderItem.fromJson(Map<String, dynamic> json) =>
      _$TrnCheckoutOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$TrnCheckoutOrderItemToJson(this);

  final int itemNumber;
  final int itemTypeId;
  final bool isReadable;
  final bool isCondiment;
  final bool isInstructions;
  final bool isScale;
  final String name;
  final String? productId;
  final String? productCode;
  final String description;
  final bool taxable;
  final double quantity;
  final double discount;
  final double totalExTax;
  final double taxAmount;
  final double total;
  final int spendPoints;
  final int productPoints;
  final String currency;
}
