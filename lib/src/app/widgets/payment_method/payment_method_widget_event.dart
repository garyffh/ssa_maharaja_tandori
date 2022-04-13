
abstract class PaymentMethodWidgetEvent {}


class PaymentMethodWidgetEventSubmit extends PaymentMethodWidgetEvent {
  PaymentMethodWidgetEventSubmit({
    required this.cardName,
});

  final String cardName;
}

class PaymentMethodWidgetEventResetError extends PaymentMethodWidgetEvent {
  PaymentMethodWidgetEventResetError();
}
