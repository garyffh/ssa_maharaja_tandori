import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_payment_method.dart';

import 'models/checkout_payment_method_view_type.dart';

@immutable
abstract class CheckoutPaymentMethodState extends ProgressErrorState {
  const CheckoutPaymentMethodState({
    required this.checkoutPaymentMethodViewType,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
  final CheckoutPaymentMethodViewType checkoutPaymentMethodViewType;
}

class CheckoutPaymentMethodStateInitial extends CheckoutPaymentMethodState {
  const CheckoutPaymentMethodStateInitial()
      : super(
    checkoutPaymentMethodViewType: CheckoutPaymentMethodViewType.view,
    type: ProgressErrorStateType.initial,
  );
}

class CheckoutPaymentMethodStateLoadingError extends CheckoutPaymentMethodState {
  const CheckoutPaymentMethodStateLoadingError({
    required CheckoutPaymentMethodViewType checkoutPaymentMethodViewType,
    dynamic error,
  }) : super(
    checkoutPaymentMethodViewType: checkoutPaymentMethodViewType,
    type: ProgressErrorStateType.loadingError,
    error: error,
  );

  CheckoutPaymentMethodStateLoadingError.fromState({
    required CheckoutPaymentMethodState checkoutPaymentMethodState,
    dynamic error,
  }) : super(
    checkoutPaymentMethodViewType: checkoutPaymentMethodState.checkoutPaymentMethodViewType,
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

abstract class CheckoutPaymentMethodStateViewModel extends CheckoutPaymentMethodState {
  const CheckoutPaymentMethodStateViewModel({
    required this.trnCheckoutPaymentMethod,
    required CheckoutPaymentMethodViewType checkoutPaymentMethodViewType,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(
    checkoutPaymentMethodViewType: checkoutPaymentMethodViewType,
    type: type,
    error: error,
  );

  final TrnCheckoutPaymentMethod trnCheckoutPaymentMethod;
}

class CheckoutPaymentMethodStateLoaded extends CheckoutPaymentMethodStateViewModel {
  const CheckoutPaymentMethodStateLoaded({
    required TrnCheckoutPaymentMethod trnCheckoutPaymentMethod,
    required CheckoutPaymentMethodViewType checkoutPaymentMethodViewType,
  }) : super(
    trnCheckoutPaymentMethod: trnCheckoutPaymentMethod,
    checkoutPaymentMethodViewType: checkoutPaymentMethodViewType,
    type: ProgressErrorStateType.loaded,
  );

  CheckoutPaymentMethodStateLoaded.fromTrnCheckout({
    required TrnCheckout trnCheckout,
  }) : super(
    trnCheckoutPaymentMethod: trnCheckout.trnCheckoutPaymentMethod,
    checkoutPaymentMethodViewType: trnCheckout.hasPaymentMethod || trnCheckout.trnCheckoutPaymentMethod.creditTransaction
        ? CheckoutPaymentMethodViewType.view
        : CheckoutPaymentMethodViewType.add,
    type: ProgressErrorStateType.loaded,
  );



}

class CheckoutPaymentMethodStateProgressError extends CheckoutPaymentMethodStateViewModel {
  const CheckoutPaymentMethodStateProgressError({
    required TrnCheckoutPaymentMethod trnCheckoutPaymentMethod,
    required CheckoutPaymentMethodViewType checkoutPaymentMethodViewType,
    dynamic error,
  }) : super(
    trnCheckoutPaymentMethod: trnCheckoutPaymentMethod,
    checkoutPaymentMethodViewType: checkoutPaymentMethodViewType,
    type: ProgressErrorStateType.progressError,
    error: error,
  );

  CheckoutPaymentMethodStateProgressError.fromViewModel({
    required CheckoutPaymentMethodStateViewModel viewModel,
    dynamic error,
  }) : super(
    trnCheckoutPaymentMethod: viewModel.trnCheckoutPaymentMethod,
    checkoutPaymentMethodViewType: viewModel.checkoutPaymentMethodViewType,
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}
