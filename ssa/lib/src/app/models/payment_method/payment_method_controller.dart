import 'package:flutter/material.dart';

class PaymentMethodController {

  PaymentMethodController({
    required this.complete,
    required this.onClear,
  });

  final bool complete;
  final VoidCallback? onClear;

  void clear() {
    if(onClear != null) {
         onClear!();
    }
  }
}