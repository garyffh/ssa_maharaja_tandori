import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/checkout/checkout_delivery_method.dart';

@immutable
abstract class CheckoutDeliveryMethodState extends ProgressErrorState {
  const CheckoutDeliveryMethodState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class CheckoutDeliveryMethodStateInitial extends CheckoutDeliveryMethodState {
  const CheckoutDeliveryMethodStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class CheckoutDeliveryMethodStateLoadingError
    extends CheckoutDeliveryMethodState {
  const CheckoutDeliveryMethodStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

abstract class CheckoutDeliveryMethodStateViewModel
    extends CheckoutDeliveryMethodState {
  const CheckoutDeliveryMethodStateViewModel({
    required this.checkoutDeliveryMethod,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
          error: error,
          type: type,
        );

  final CheckoutDeliveryMethod checkoutDeliveryMethod;
}

class CheckoutDeliveryMethodStateViewLoaded
    extends CheckoutDeliveryMethodStateViewModel {
  const CheckoutDeliveryMethodStateViewLoaded({
    required CheckoutDeliveryMethod checkoutDeliveryMethod,
  }) : super(
          checkoutDeliveryMethod: checkoutDeliveryMethod,
          type: ProgressErrorStateType.loaded,
        );
}

class CheckoutDeliveryMethodStateProgressError
    extends CheckoutDeliveryMethodStateViewModel {
  const CheckoutDeliveryMethodStateProgressError({
    required CheckoutDeliveryMethod checkoutDeliveryMethod,
    dynamic error,
  }) : super(
          checkoutDeliveryMethod: checkoutDeliveryMethod,
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}
