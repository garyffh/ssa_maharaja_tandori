import 'package:single_store_app/src/app/models/user/user_address.dart';

abstract class CheckoutAddressEvent {}

class CheckoutAddressEventGetViewModel extends CheckoutAddressEvent {
  CheckoutAddressEventGetViewModel();
}

class CheckoutAddressEventShowUpdate extends CheckoutAddressEvent {
  CheckoutAddressEventShowUpdate();
}

class CheckoutAddressEventShowView extends CheckoutAddressEvent {
  CheckoutAddressEventShowView();
}

class CheckoutAddressEventUpdate extends CheckoutAddressEvent {
  CheckoutAddressEventUpdate({
    required this.address,
  });

  final UserAddress address;
}

class CheckoutAddressEventSubmit extends CheckoutAddressEvent {
  CheckoutAddressEventSubmit();
}
