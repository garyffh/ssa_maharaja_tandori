import 'models/checkout_submit_method.dart';

abstract class CheckoutSubmitEvent {}

class CheckoutSubmitEventGetViewModel extends CheckoutSubmitEvent {
  CheckoutSubmitEventGetViewModel();

}

class CheckoutSubmitEventSubmit extends CheckoutSubmitEvent {
  CheckoutSubmitEventSubmit({required this.checkoutSubmitMethod});
  final CheckoutSubmitMethod checkoutSubmitMethod;
}

