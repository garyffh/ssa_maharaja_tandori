import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';

abstract class CheckoutPaymentMethodEvent {}

class CheckoutPaymentMethodEventGetViewModel
    extends CheckoutPaymentMethodEvent {
  CheckoutPaymentMethodEventGetViewModel();
}

class CheckoutPaymentMethodEventShowAdd extends CheckoutPaymentMethodEvent {
  CheckoutPaymentMethodEventShowAdd();
}

class CheckoutPaymentMethodEventShowView extends CheckoutPaymentMethodEvent {
  CheckoutPaymentMethodEventShowView();
}

class CheckoutPaymentMethodEventRefresh extends CheckoutPaymentMethodEvent {
  CheckoutPaymentMethodEventRefresh();
}

class CheckoutPaymentMethodEventSubmit extends CheckoutPaymentMethodEvent {
  CheckoutPaymentMethodEventSubmit({
    required this.selectedPaymentMethod,
    required this.creditTransaction,
  });

  final UserPaymentMethodRead? selectedPaymentMethod;
  final bool creditTransaction;
}
