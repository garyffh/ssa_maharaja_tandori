import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_delivery_method.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_payment_method.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_phone.dart';

abstract class CheckoutEvent {}


class CheckoutEventLoad extends CheckoutEvent {
  CheckoutEventLoad();

}

class CheckoutEventUpdateDeliveryMethod extends CheckoutEvent {
  CheckoutEventUpdateDeliveryMethod({
    required this.trnCheckoutDeliveryMethod,
});
  final TrnCheckoutDeliveryMethod trnCheckoutDeliveryMethod;

}

class CheckoutEventUpdateAddress extends CheckoutEvent {
  CheckoutEventUpdateAddress({
    required this.trnCheckoutAddress,
  });
  final TrnCheckoutAddress trnCheckoutAddress;

}

class CheckoutEventUpdatePhone extends CheckoutEvent {
  CheckoutEventUpdatePhone({
    required this.trnCheckoutPhone,
  });
  final TrnCheckoutPhone trnCheckoutPhone;

}

class CheckoutEventUpdatePaymentMethod extends CheckoutEvent {
  CheckoutEventUpdatePaymentMethod({
    required this.trnCheckoutPaymentMethod,
  });
  final TrnCheckoutPaymentMethod trnCheckoutPaymentMethod;

}

class CheckoutEventRefreshPaymentMethod extends CheckoutEvent {
  CheckoutEventRefreshPaymentMethod({
    required this.trnCheckoutPaymentMethod,
});
  final TrnCheckoutPaymentMethod trnCheckoutPaymentMethod;
}

class CheckoutEventSubmit extends CheckoutEvent {
  CheckoutEventSubmit();
}

