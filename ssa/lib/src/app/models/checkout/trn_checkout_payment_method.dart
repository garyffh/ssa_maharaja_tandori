import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';

@immutable
class TrnCheckoutPaymentMethod {
  const TrnCheckoutPaymentMethod({
    required this.paymentMethods,
    this.selectedPaymentMethod,
    this.paymentToken,
    required this.creditTransaction,
  });

  TrnCheckoutPaymentMethod.initial()
      : paymentMethods = List.empty(growable: false),
        selectedPaymentMethod = null,
        paymentToken = null,
  creditTransaction = false;

  TrnCheckoutPaymentMethod.selectPaymentMethod({required this.paymentMethods, required this.creditTransaction,})
      : selectedPaymentMethod =
            paymentMethods.firstWhereOrNull((element) => element.defaultMethod),
        paymentToken = null;

  final List<UserPaymentMethodRead> paymentMethods;
  final UserPaymentMethodRead? selectedPaymentMethod;
  final String? paymentToken;
  final bool creditTransaction;
}
