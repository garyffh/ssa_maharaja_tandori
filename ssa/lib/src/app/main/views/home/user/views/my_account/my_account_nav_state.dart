
import 'package:flutter/material.dart';

enum MyAccountView {
  dashboard,
  paymentMethods,
  paymentMethodAdd,
  addressUpdate,
  passwordUpdate,
  passwordUpdateConfirmation,
  phoneUpdate,
  phoneCode,
}

abstract class MyAccountNavState {
  MyAccountNavState({
    required this.view,
    this.floatingActionButton,
  });

  final MyAccountView view;
  final FloatingActionButton? floatingActionButton;

  bool authenticationIsRequired() {
        return true;
  }
}

class MyAccountNavStateDashboardView extends MyAccountNavState {
  MyAccountNavStateDashboardView() : super(view: MyAccountView.dashboard);
}

class MyAccountNavStatePaymentMethodsView extends MyAccountNavState {
  MyAccountNavStatePaymentMethodsView() : super(view: MyAccountView.paymentMethods);
}

class MyAccountNavStatePaymentMethodAddView extends MyAccountNavState {
  MyAccountNavStatePaymentMethodAddView() : super(view: MyAccountView.paymentMethodAdd);
}

class MyAccountNavStateAddressUpdateView extends MyAccountNavState {
  MyAccountNavStateAddressUpdateView() : super(view: MyAccountView.addressUpdate);
}

class MyAccountNavStatePasswordUpdateView extends MyAccountNavState {
  MyAccountNavStatePasswordUpdateView() : super(view: MyAccountView.passwordUpdate);
}

class MyAccountNavStatePasswordUpdateConfirmationView extends MyAccountNavState {
  MyAccountNavStatePasswordUpdateConfirmationView() : super(view: MyAccountView.passwordUpdateConfirmation);
}

class MyAccountNavStatePhoneUpdateView extends MyAccountNavState {
  MyAccountNavStatePhoneUpdateView() : super(view: MyAccountView.phoneUpdate);
}

class MyAccountNavStatePhoneCodeView extends MyAccountNavState {
  MyAccountNavStatePhoneCodeView({
    required this.mobileNumber,
}) : super(view: MyAccountView.phoneCode);

  final String mobileNumber;

}
