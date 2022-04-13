
import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';

enum CheckoutView {
  stepper,
  complete,
}

abstract class CheckoutNavState {
  CheckoutNavState({
    required this.view,
    this.floatingActionButton,
  });

  final CheckoutView view;
  final FloatingActionButton? floatingActionButton;

  bool authenticationIsRequired() {
        return true;
  }
}

class CheckoutNavStateStepperView extends CheckoutNavState {
  CheckoutNavStateStepperView() : super(view: CheckoutView.stepper);
}


class CheckoutNavStateCompleteView extends CheckoutNavState {
  CheckoutNavStateCompleteView({
    required this.trnOrder,
}) : super(view: CheckoutView.complete);

  final TrnOrder trnOrder;

}
