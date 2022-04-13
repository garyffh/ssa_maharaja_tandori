abstract class CheckoutPhoneEvent {}

class CheckoutPhoneEventGetViewModel extends CheckoutPhoneEvent {
  CheckoutPhoneEventGetViewModel();

}

class CheckoutPhoneEventShowUpdate extends CheckoutPhoneEvent {
  CheckoutPhoneEventShowUpdate();
}

class CheckoutPhoneEventShowCode extends CheckoutPhoneEvent {
  CheckoutPhoneEventShowCode({
    required this.mobileNumber,
});
  final String mobileNumber;
}

class CheckoutPhoneEventShowView extends CheckoutPhoneEvent {
  CheckoutPhoneEventShowView();
}

class CheckoutPhoneEventSubmit extends CheckoutPhoneEvent {
  CheckoutPhoneEventSubmit({
    required this.phone,
});
  final String phone;
}
