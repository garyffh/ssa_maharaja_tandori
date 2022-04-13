import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_error.dart';
import 'package:single_store_app/src/app/models/user/address_result.dart';
import 'package:single_store_app/src/app/models/user/suggest_address.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';

enum AddressProgressStateType {
  initial,
  queryCommenced,
  progressError,
  result,
  validated,
  submitProgress,
  submitted,
}

@immutable
abstract class AddressState extends ProgressViewError
    implements ProgressFormView {
  const AddressState({
    required this.type,
    dynamic error,
    required this.suggestAddresses,
  }) : super(error: error);

  final AddressProgressStateType type;
  final List<SuggestAddress> suggestAddresses;

  @override
  ProgressErrorStateType get viewType {
    switch (type) {
      case AddressProgressStateType.initial:
      case AddressProgressStateType.result:
      case AddressProgressStateType.validated:
        return ProgressErrorStateType.idle;

      case AddressProgressStateType.queryCommenced:
      case AddressProgressStateType.progressError:
      case AddressProgressStateType.submitProgress:

        return ProgressErrorStateType.progressError;

      case AddressProgressStateType.submitted:
        return ProgressErrorStateType.submitted;
    }
  }

  @override
  bool get hasError => error != null;

  @override
  bool get inProgress =>
      type == AddressProgressStateType.progressError && error == null;

  @override
  bool get formIsReadOnly => inProgress || hasError;
}

class AddressStateInitial extends AddressState {
  AddressStateInitial()
      : super(
          type: AddressProgressStateType.initial,
          suggestAddresses: List.empty(),
        );
}

class AddressStateQueryCommenced extends AddressState {
  AddressStateQueryCommenced()
      : super(
          type: AddressProgressStateType.queryCommenced,
          suggestAddresses: List.empty(),
        );
}

class AddressStateProgressError extends AddressState {
  AddressStateProgressError({
    dynamic error,
  }) : super(
          type: AddressProgressStateType.progressError,
          error: error,
          suggestAddresses: List.empty(),
        );
}

class AddressStateResult extends AddressState {
  const AddressStateResult({
    required List<SuggestAddress> suggestAddresses,
  }) : super(
          type: AddressProgressStateType.result,
          suggestAddresses: suggestAddresses,
        );
}

abstract class AddressStateSelected extends AddressState {
  AddressStateSelected({
    required this.address,
    required AddressProgressStateType type,
    dynamic error,
  }) : super(
          type: type,
          error: error,
          suggestAddresses: List.empty(),
        );
  final AddressResult address;
}

class AddressStateValidated extends AddressStateSelected {
  AddressStateValidated({
    required AddressResult address,
  }) : super(
          address: address,
          type: AddressProgressStateType.validated,
        );
}

class AddressStateSubmitProgress extends AddressStateSelected {
  AddressStateSubmitProgress({
    required AddressResult address,
    dynamic error,
  }) : super(
          address: address,
          type: AddressProgressStateType.submitProgress,
          error: error,
        );
}

class AddressStateSubmitted extends AddressState {
  AddressStateSubmitted({
    required this.address,
  }) : super(
          type: AddressProgressStateType.submitted,
          suggestAddresses: List.empty(),
        );
  final UserAddress address;
}
