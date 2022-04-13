
import 'package:single_store_app/src/app/models/user/user_payment_method.dart';

abstract class PaymentMethodsEvent {}

class PaymentMethodsEventGetViewModel extends PaymentMethodsEvent {
  PaymentMethodsEventGetViewModel();

}

class PaymentMethodsEventDelete extends PaymentMethodsEvent {
  PaymentMethodsEventDelete({
    required this.userPaymentMethod,
});

  final UserPaymentMethod userPaymentMethod;
}

class PaymentMethodsEventDefault extends PaymentMethodsEvent {
  PaymentMethodsEventDefault({
    required this.userPaymentMethod,
  });

  final UserPaymentMethod userPaymentMethod;
}
