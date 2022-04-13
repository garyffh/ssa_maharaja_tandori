abstract class PhoneCodeWidgetEvent {}

class PhoneCodeWidgetEventSubmit extends PhoneCodeWidgetEvent {
  PhoneCodeWidgetEventSubmit({
    required this.mobileNumber,
    required this.mobileCode,
});
  final String mobileNumber;
  final String mobileCode;
}

class PhoneCodeWidgetEventResetError extends PhoneCodeWidgetEvent {
  PhoneCodeWidgetEventResetError();

}
