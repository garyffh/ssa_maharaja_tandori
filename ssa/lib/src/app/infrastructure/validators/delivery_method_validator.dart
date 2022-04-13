import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

class DeliveryMethodValidator extends Validator<dynamic> {
  DeliveryMethodValidator(
    this.controlName,
    this.markAsDirty,
  );

  final String controlName;
  final bool markAsDirty;

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessage.required: true};

    if (control is! FormGroup) {
      return error;
    }

    for (final DeliveryMethodType deliveryMethodType
        in DeliveryMethodType.values) {
      final infoControl = control.control(_controlName(deliveryMethodType));
      infoControl.removeError(ValidationMessage.required);
      infoControl.markAsUntouched();
    }

    final formControl = control.control(controlName);
    if (formControl.value != null) {
      final informationControl = control
          .control(_controlName(formControl.value as DeliveryMethodType));

      if (informationControl.value == null) {
        informationControl.setErrors(error, markAsDirty: markAsDirty);
        informationControl.markAsUntouched();
      } else if (informationControl.value is String) {
        if ((informationControl.value as String).trim().isEmpty) {
          informationControl.setErrors(error, markAsDirty: markAsDirty);
          informationControl.markAsUntouched();
        }
      }
    }
    return null;
  }

  String _controlName(DeliveryMethodType deliveryMethodType) {
    switch (deliveryMethodType) {
      case DeliveryMethodType.store:
        return 'storeTime';

      case DeliveryMethodType.delivery:
        return 'deliveryTime';

      case DeliveryMethodType.table:
        return 'tableNumber';

      case DeliveryMethodType.period:
        return 'periodTime';
    }
  }
}
