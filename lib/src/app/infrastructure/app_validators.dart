import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/validators/lower_required_validator.dart';
import 'package:single_store_app/src/app/infrastructure/validators/number_required_validator.dart';
import 'package:single_store_app/src/app/infrastructure/validators/upper_required_validator.dart';

import 'validators/delivery_method_validator.dart';
import 'validators/email_trim_validator.dart';

class AppValidators {
  AppValidators._();

  static ValidatorFunction get numberRequired =>
      NumberRequiredValidator().validate;

  static ValidatorFunction get upperRequired =>
      UpperRequiredValidator().validate;

  static ValidatorFunction get lowerRequired =>
      LowerRequiredValidator().validate;

  static ValidatorFunction get emailTrim => EmailTrimValidator().validate;

  static ValidatorFunction deliveryMethod(String controlName,
      {bool markAsDirty = true}) {
    return DeliveryMethodValidator(controlName, markAsDirty).validate;
  }

  static List<ValidatorFunction> get passwordValidators => [
        Validators.required,
        Validators.minLength(8),
        Validators.maxLength(20),
        numberRequired,
        upperRequired,
        lowerRequired,
      ];
}
