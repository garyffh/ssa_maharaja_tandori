import 'package:reactive_forms/reactive_forms.dart';

import 'app_validation_message.dart';

class NumberRequiredValidator extends Validator<dynamic> {
  static final RegExp regex = RegExp(r'[0-9]+');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {

    return (control.isNull ||
        control.value.toString().isEmpty ||
        regex.hasMatch(control.value.toString().trim()))
        ? null
        : <String, dynamic>{AppValidationMessage.numberRequired: control.value};
  }
}
