import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/strings/user_payment_method_type.constants.dart';

enum UserPaymentMethodType {
@JsonValue(0)
card,
}

extension UserPaymentMethodTypeExtension on UserPaymentMethodType {

  String get text {
    switch(this) {

      case UserPaymentMethodType.card:
        return userPaymentMethodTypeCardText;


    }
  }
}
