
import 'package:single_store_app/src/app/models/user/suggest_address.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';

abstract class AddressEvent {}

class AddressEventInitialise extends AddressEvent {
  AddressEventInitialise();

}

class AddressEventQuery extends AddressEvent {
  AddressEventQuery({
    required this.query,
  });

  final String query;
}

class AddressEventValidate extends AddressEvent {
  AddressEventValidate({
    required this.suggestAddress,
    this.saveAddress = true,
  });

  final SuggestAddress suggestAddress;
  final bool saveAddress;
}

class AddressEventResetError extends AddressEvent {
  AddressEventResetError();

}

class AddressEventSubmit extends AddressEvent {
  AddressEventSubmit({
    required this.address,
    this.saveAddress = true,
  });

  final UserAddress address;
  final bool saveAddress;
}
