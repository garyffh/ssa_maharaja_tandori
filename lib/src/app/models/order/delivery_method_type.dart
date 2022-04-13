import 'package:json_annotation/json_annotation.dart';

enum DeliveryMethodType {
  @JsonValue(0)
  store,
  @JsonValue(1)
  delivery,
  @JsonValue(2)
  table,
  @JsonValue(3)
  period
}

extension DeliveryMethodTypeExtension on DeliveryMethodType {

  String get text {
    switch(this) {

      case DeliveryMethodType.store:
        return 'PICK-UP';

      case DeliveryMethodType.delivery:
        return 'DELIVERY';

      case DeliveryMethodType.table:
        return 'DINE-IN';

      case DeliveryMethodType.period:
        return 'DELIVERY';


    }
  }

  String get addressText {
    switch(this) {

      case DeliveryMethodType.store:
        return 'Billing';

      case DeliveryMethodType.delivery:
        return 'Delivery';

      case DeliveryMethodType.table:
        return 'Billing';

      case DeliveryMethodType.period:
        return 'Delivery';


    }
  }

  String get checkoutAddressText {
    switch(this) {

      case DeliveryMethodType.store:
        return 'Billing Address';

      case DeliveryMethodType.delivery:
        return 'Delivery Address';

      case DeliveryMethodType.table:
        return 'Billing Address';

      case DeliveryMethodType.period:
        return 'Delivery Address';


    }
  }

}
