import 'package:reactive_forms/reactive_forms.dart';

class EmailTrimValidator extends Validator<dynamic> {
  static final RegExp emailTrimRegex = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {

    return (control.isNull ||
        control.value.toString().isEmpty ||
        emailTrimRegex.hasMatch(control.value.toString().trim()))
        ? null
        : <String, dynamic>{ValidationMessage.email: control.value};
  }
}
