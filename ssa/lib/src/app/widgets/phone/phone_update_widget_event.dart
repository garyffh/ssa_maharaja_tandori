abstract class PhoneUpdateWidgetEvent {}

class PhoneUpdateWidgetEventSubmit extends PhoneUpdateWidgetEvent {
  PhoneUpdateWidgetEventSubmit({
    required this.mobile,
  });

  final String mobile;
}

class PhoneUpdateWidgetEventResetError extends PhoneUpdateWidgetEvent {
  PhoneUpdateWidgetEventResetError();
}
