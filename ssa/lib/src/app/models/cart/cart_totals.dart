import 'package:flutter/cupertino.dart';

@immutable
class CartTotals {
  const CartTotals({
    required this.qty,
    required this.total,
  });

  final double qty;
  final double total;


}
