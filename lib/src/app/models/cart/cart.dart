import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/cart/cart_totals.dart';

import 'cart_active.dart';

@immutable
class Cart {
  const Cart({
    required this.cartActive,
    required this.cartTotals,
  });

  Cart.update({required this.cartActive})
      : cartTotals = cartActive.calculateCartTotals();

  final CartActive cartActive;
  final CartTotals cartTotals;
}
