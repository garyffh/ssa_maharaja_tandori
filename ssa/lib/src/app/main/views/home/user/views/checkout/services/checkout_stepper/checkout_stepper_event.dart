abstract class CheckoutStepperEvent {}

class CheckoutStepperEventGetViewModel extends CheckoutStepperEvent {
  CheckoutStepperEventGetViewModel();

}

class CheckoutStepperEventNext extends CheckoutStepperEvent {
  CheckoutStepperEventNext();

}

class CheckoutStepperEventBack extends CheckoutStepperEvent {
  CheckoutStepperEventBack();

}

class CheckoutStepperEventShowDeliveryMethod extends CheckoutStepperEvent {
  CheckoutStepperEventShowDeliveryMethod();

}
