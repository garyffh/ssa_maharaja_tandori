import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/models/products/condiment_table_item.dart';

@immutable
class CartCondimentTableItem extends Equatable {
  const CartCondimentTableItem({
    required this.qty,
    required this.priceLevel,
    required this.number,
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
    required this.currencyCode,
  });

  CartCondimentTableItem.fromCondimentTableItem({
    required this.qty,
    required this.priceLevel,
    required CondimentTableItem item,
  })  : number = item.number,
        sysSitemId = item.sysSitemId,
        name = item.name,
        shortDescription = item.shortDescription,
        description = item.description,
        tax = item.tax,
        price1 = item.price1,
        price2 = item.price2,
        price3 = item.price3,
        price4 = item.price4,
        price5 = item.price5,
        specialPrice1 = item.specialPrice1,
        specialPrice2 = item.specialPrice2,
        specialPrice3 = item.specialPrice3,
        specialPrice4 = item.specialPrice4,
        specialPrice5 = item.specialPrice5,
        currencyCode = AppConstants.currencyCode;

  CartCondimentTableItem.fromCartCondimentTableItem({
    required this.qty,
    required this.priceLevel,
    required CartCondimentTableItem item,
  })  : number = item.number,
        sysSitemId = item.sysSitemId,
        name = item.name,
        shortDescription = item.shortDescription,
        description = item.description,
        tax = item.tax,
        price1 = item.price1,
        price2 = item.price2,
        price3 = item.price3,
        price4 = item.price4,
        price5 = item.price5,
        specialPrice1 = item.specialPrice1,
        specialPrice2 = item.specialPrice2,
        specialPrice3 = item.specialPrice3,
        specialPrice4 = item.specialPrice4,
        specialPrice5 = item.specialPrice5,
        currencyCode = AppConstants.currencyCode;

  CartCondimentTableItem.copy(CartCondimentTableItem item)
      : qty = item.qty,
        priceLevel = item.priceLevel,
        number = item.number,
        sysSitemId = item.sysSitemId,
        name = item.name,
        shortDescription = item.shortDescription,
        description = item.description,
        tax = item.tax,
        price1 = item.price1,
        price2 = item.price2,
        price3 = item.price3,
        price4 = item.price4,
        price5 = item.price5,
        specialPrice1 = item.specialPrice1,
        specialPrice2 = item.specialPrice2,
        specialPrice3 = item.specialPrice3,
        specialPrice4 = item.specialPrice4,
        specialPrice5 = item.specialPrice5,
        currencyCode = AppConstants.currencyCode;

  final double qty;
  final int priceLevel;
  final int number;
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
  final String currencyCode;

  @override
  List<Object> get props => [sysSitemId];

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

  double get total => qty * price;
}
