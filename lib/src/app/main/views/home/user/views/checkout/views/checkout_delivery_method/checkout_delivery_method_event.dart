import 'package:single_store_app/src/app/models/checkout/trn_checkout_delivery_method.dart';

abstract class CheckoutDeliveryMethodEvent {}

class CheckoutDeliveryMethodEventGetViewModel
    extends CheckoutDeliveryMethodEvent {
  CheckoutDeliveryMethodEventGetViewModel();
}

class CheckoutDeliveryMethodEventRefresh extends CheckoutDeliveryMethodEvent {
  CheckoutDeliveryMethodEventRefresh();
}

class CheckoutDeliveryMethodEventSubmit extends CheckoutDeliveryMethodEvent {
  CheckoutDeliveryMethodEventSubmit({
    required this.trnCheckoutDeliveryMethod,
  });

  final TrnCheckoutDeliveryMethod trnCheckoutDeliveryMethod;
}
