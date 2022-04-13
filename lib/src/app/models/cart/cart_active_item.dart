import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';

import 'cart_active_chain.dart';
import 'cart_condiment_table.dart';
import 'cart_condiment_table_item.dart';
import 'cart_store_condiment_table.dart';
import 'cart_store_condiment_table_item.dart';

@immutable
class CartActiveItem {
  const CartActiveItem({
    required this.qty,
    required this.priceLevel,
    this.instructions,
    required this.sysSitemId,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.tax,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.specialPrice1,
    required this.specialPrice2,
    required this.specialPrice3,
    required this.specialPrice4,
    required this.specialPrice5,
    required this.scale,
    required this.isCondimentChain,
    required this.condimentEntry,
    required this.hasImage,
    required this.sysStoreCategory,
    required this.sysStoreCategoryId,
    required this.sysCondimentTableId,
    required this.sysCondimentChainId,
    this.stockCount,
    this.cartActiveChain,
  });

  CartActiveItem.fromSitem({
    required this.qty,
    required this.priceLevel,
    this.instructions,
    required Sitem sitem,
    required this.cartActiveChain,
  })  : sysSitemId = sitem.sysSitemId,
        name = sitem.name,
        shortDescription = sitem.shortDescription,
        description = sitem.description,
        tax = sitem.tax,
        price1 = sitem.price1,
        price2 = sitem.price2,
        price3 = sitem.price3,
        price4 = sitem.price4,
        price5 = sitem.price5,
        specialPrice1 = sitem.specialPrice1,
        specialPrice2 = sitem.specialPrice2,
        specialPrice3 = sitem.specialPrice3,
        specialPrice4 = sitem.specialPrice4,
        specialPrice5 = sitem.specialPrice5,
        scale = sitem.scale,
        isCondimentChain = sitem.isCondimentChain,
        condimentEntry = sitem.condimentEntry,
        hasImage = sitem.hasImage,
        sysStoreCategory = sitem.sysStoreCategory,
        sysStoreCategoryId = sitem.sysStoreCategoryId,
        sysCondimentTableId = sitem.sysCondimentTableId,
        sysCondimentChainId = sitem.sysCondimentChainId,
        stockCount = sitem.stockCount;

  CartActiveItem.fromSitemDetail({
    required this.qty,
    required this.priceLevel,
    this.instructions,
    required SitemDetail sitemDetail,
    required this.cartActiveChain,
  })  : sysSitemId = sitemDetail.sysSitemId,
        name = sitemDetail.name,
        shortDescription = sitemDetail.shortDescription,
        description = sitemDetail.description,
        tax = sitemDetail.tax,
        price1 = sitemDetail.price1,
        price2 = sitemDetail.price2,
        price3 = sitemDetail.price3,
        price4 = sitemDetail.price4,
        price5 = sitemDetail.price5,
        specialPrice1 = sitemDetail.specialPrice1,
        specialPrice2 = sitemDetail.specialPrice2,
        specialPrice3 = sitemDetail.specialPrice3,
        specialPrice4 = sitemDetail.specialPrice4,
        specialPrice5 = sitemDetail.specialPrice5,
        scale = sitemDetail.scale,
        isCondimentChain = sitemDetail.isCondimentChain,
        condimentEntry = sitemDetail.condimentEntry,
        hasImage = sitemDetail.hasImage,
        sysStoreCategory = sitemDetail.sysStoreCategory,
        sysStoreCategoryId = sitemDetail.sysStoreCategoryId,
        sysCondimentTableId = sitemDetail.sysCondimentTableId,
        sysCondimentChainId = sitemDetail.sysCondimentChainId,
        stockCount = sitemDetail.stockCount;

  CartActiveItem.update({
    required this.priceLevel,
    required CartActiveItem cartActiveItem,
  })  : qty = cartActiveItem.qty,
        instructions = cartActiveItem.instructions,
        cartActiveChain = cartActiveItem.cartActiveChain == null
            ? null
            : CartActiveChain.update(
                qty: cartActiveItem.qty,
                priceLevel: cartActiveItem.priceLevel,
                cartActiveChain: cartActiveItem.cartActiveChain!),
        sysSitemId = cartActiveItem.sysSitemId,
        name = cartActiveItem.name,
        shortDescription = cartActiveItem.shortDescription,
        description = cartActiveItem.description,
        tax = cartActiveItem.tax,
        price1 = cartActiveItem.price1,
        price2 = cartActiveItem.price2,
        price3 = cartActiveItem.price3,
        price4 = cartActiveItem.price4,
        price5 = cartActiveItem.price5,
        specialPrice1 = cartActiveItem.specialPrice1,
        specialPrice2 = cartActiveItem.specialPrice2,
        specialPrice3 = cartActiveItem.specialPrice3,
        specialPrice4 = cartActiveItem.specialPrice4,
        specialPrice5 = cartActiveItem.specialPrice5,
        scale = cartActiveItem.scale,
        isCondimentChain = cartActiveItem.isCondimentChain,
        condimentEntry = cartActiveItem.condimentEntry,
        hasImage = cartActiveItem.hasImage,
        sysStoreCategory = cartActiveItem.sysStoreCategory,
        sysStoreCategoryId = cartActiveItem.sysStoreCategoryId,
        sysCondimentTableId = cartActiveItem.sysCondimentTableId,
        sysCondimentChainId = cartActiveItem.sysCondimentChainId,
        stockCount = cartActiveItem.stockCount;

  CartActiveItem.userUpdate({
    required this.qty,
    this.instructions,
    required CartActiveItem cartActiveItem,
  })  : priceLevel = cartActiveItem.priceLevel,
        cartActiveChain = cartActiveItem.cartActiveChain == null
            ? null
            : CartActiveChain.update(
                qty: qty,
                priceLevel: cartActiveItem.priceLevel,
                cartActiveChain: cartActiveItem.cartActiveChain!),
        sysSitemId = cartActiveItem.sysSitemId,
        name = cartActiveItem.name,
        shortDescription = cartActiveItem.shortDescription,
        description = cartActiveItem.description,
        tax = cartActiveItem.tax,
        price1 = cartActiveItem.price1,
        price2 = cartActiveItem.price2,
        price3 = cartActiveItem.price3,
        price4 = cartActiveItem.price4,
        price5 = cartActiveItem.price5,
        specialPrice1 = cartActiveItem.specialPrice1,
        specialPrice2 = cartActiveItem.specialPrice2,
        specialPrice3 = cartActiveItem.specialPrice3,
        specialPrice4 = cartActiveItem.specialPrice4,
        specialPrice5 = cartActiveItem.specialPrice5,
        scale = cartActiveItem.scale,
        isCondimentChain = cartActiveItem.isCondimentChain,
        condimentEntry = cartActiveItem.condimentEntry,
        hasImage = cartActiveItem.hasImage,
        sysStoreCategory = cartActiveItem.sysStoreCategory,
        sysStoreCategoryId = cartActiveItem.sysStoreCategoryId,
        sysCondimentTableId = cartActiveItem.sysCondimentTableId,
        sysCondimentChainId = cartActiveItem.sysCondimentChainId,
        stockCount = cartActiveItem.stockCount;

  CartActiveItem.copy(CartActiveItem cartActiveItem)
      : qty = cartActiveItem.qty,
        instructions = cartActiveItem.instructions,
        priceLevel = cartActiveItem.priceLevel,
        cartActiveChain = cartActiveItem.cartActiveChain == null
            ? null
            : CartActiveChain.update(
                qty: cartActiveItem.qty,
                priceLevel: cartActiveItem.priceLevel,
                cartActiveChain: cartActiveItem.cartActiveChain!),
        sysSitemId = cartActiveItem.sysSitemId,
        name = cartActiveItem.name,
        shortDescription = cartActiveItem.shortDescription,
        description = cartActiveItem.description,
        tax = cartActiveItem.tax,
        price1 = cartActiveItem.price1,
        price2 = cartActiveItem.price2,
        price3 = cartActiveItem.price3,
        price4 = cartActiveItem.price4,
        price5 = cartActiveItem.price5,
        specialPrice1 = cartActiveItem.specialPrice1,
        specialPrice2 = cartActiveItem.specialPrice2,
        specialPrice3 = cartActiveItem.specialPrice3,
        specialPrice4 = cartActiveItem.specialPrice4,
        specialPrice5 = cartActiveItem.specialPrice5,
        scale = cartActiveItem.scale,
        isCondimentChain = cartActiveItem.isCondimentChain,
        condimentEntry = cartActiveItem.condimentEntry,
        hasImage = cartActiveItem.hasImage,
        sysStoreCategory = cartActiveItem.sysStoreCategory,
        sysStoreCategoryId = cartActiveItem.sysStoreCategoryId,
        sysCondimentTableId = cartActiveItem.sysCondimentTableId,
        sysCondimentChainId = cartActiveItem.sysCondimentChainId,
        stockCount = cartActiveItem.stockCount;

  final double qty;
  final int priceLevel;
  final String? instructions;
  final String sysSitemId;
  final String name;
  final String shortDescription;
  final String description;
  final int tax;
  final double price1;
  final double price2;
  final double price3;
  final double price4;
  final double price5;
  final double? specialPrice1;
  final double? specialPrice2;
  final double? specialPrice3;
  final double? specialPrice4;
  final double? specialPrice5;
  final bool scale;
  final bool isCondimentChain;
  final bool condimentEntry;
  final bool hasImage;
  final String sysStoreCategory;
  final String sysStoreCategoryId;
  final String? sysCondimentTableId;
  final String? sysCondimentChainId;
  final int? stockCount;
  final CartActiveChain? cartActiveChain;

  bool get available {
    if (stockCount == null) {
      return true;
    } else {
      return stockCount! > 0;
    }
  }

  String get availableDisplay {
    if (stockCount == null) {
      return 'Available';
    } else {
      if (stockCount! > 0) {
        return '$stockCount in stock';
      } else {
        return 'Unavailable';
      }
    }
  }

  bool get isOnSpecial {
    return specialPrice1 != null;
  }

  double get price {
    if (isOnSpecial) {
      switch (priceLevel) {
        case 2:
          {
            return specialPrice2!;
          }

        case 3:
          {
            return specialPrice3!;
          }
        case 4:
          {
            return specialPrice4!;
          }
        case 5:
          {
            return specialPrice5!;
          }

        default:
          {
            return specialPrice1!;
          }
      }
    } else {
      switch (priceLevel) {
        case 2:
          {
            return price2;
          }

        case 3:
          {
            return price3;
          }
        case 4:
          {
            return price4;
          }
        case 5:
          {
            return price5;
          }

        default:
          {
            return price1;
          }
      }
    }
  }

  double get regularPrice {
    switch (priceLevel) {
      case 2:
        {
          return price2;
        }

      case 3:
        {
          return price3;
        }
      case 4:
        {
          return price4;
        }
      case 5:
        {
          return price5;
        }

      default:
        {
          return price1;
        }
    }
  }

  double get total => price * qty;

  void setStoreSelectedItems(
      List<CartStoreCondimentTable> cartStoreCondimentTables) {
    for (final CartStoreCondimentTable cartStoreCondimentTable
        in cartStoreCondimentTables) {
      if (cartActiveChain != null) {
        final CartCondimentTable? cartCondimentTable = cartActiveChain!.items
            .firstWhereOrNull((element) =>
                element.id ==
                cartStoreCondimentTable.id);
        if (cartCondimentTable != null) {
          for (final CartStoreCondimentTableItem cartStoreCondimentTableItem
              in cartStoreCondimentTable.selectedItems) {
            final CartCondimentTableItem? cartCondimentTableItem =
                cartCondimentTable.items.firstWhereOrNull((element) =>
                    element.sysSitemId ==
                    cartStoreCondimentTableItem.sysSitemId);

            if (cartCondimentTableItem != null) {
              cartCondimentTable.selectedItems
                  .add(CartCondimentTableItem.copy(cartCondimentTableItem));
            }
          }
        }
      }
    }
  }
}
