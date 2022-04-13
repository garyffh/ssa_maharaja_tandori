import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_submit.dart';

@immutable
abstract class CheckoutSubmitState extends ProgressErrorState {
  const CheckoutSubmitState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(
          type: type,
          error: error,
        );
}

class CheckoutSubmitStateInitial extends CheckoutSubmitState {
  const CheckoutSubmitStateInitial()
      : super(type: ProgressErrorStateType.initial);
}

class CheckoutSubmitLoadingError extends CheckoutSubmitState {
  const CheckoutSubmitLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  CheckoutSubmitLoadingError.fromUnexpectedState() : super(
    type: ProgressErrorStateType.loadingError,
    error: AppException.fromString(unexpectedBlocState),
  );

}

abstract class CheckoutSubmitStateViewModel extends CheckoutSubmitState {
  const CheckoutSubmitStateViewModel({
    required this.trnCheckoutSubmit,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(
          type: type,
          error: error,
        );

  final TrnCheckoutSubmit trnCheckoutSubmit;

}

class CheckoutSubmitStateLoaded extends CheckoutSubmitStateViewModel {
  const CheckoutSubmitStateLoaded({
    required TrnCheckoutSubmit trnCheckoutSubmit,
  }) : super(
          trnCheckoutSubmit: trnCheckoutSubmit,
          type: ProgressErrorStateType.loaded,
        );

  CheckoutSubmitStateLoaded.fromTrnCheckout({
    required TrnCheckout trnCheckout,
  }) : super(
    trnCheckoutSubmit: trnCheckout.trnCheckoutSubmit,
    type: ProgressErrorStateType.loaded,
  );


}

class CheckoutSubmitStateProcessError extends CheckoutSubmitStateViewModel {
  const CheckoutSubmitStateProcessError({
    required TrnCheckoutSubmit trnCheckoutSubmit,
    dynamic error,
  }) : super(
          trnCheckoutSubmit: trnCheckoutSubmit,
          type: ProgressErrorStateType.progressError,
          error: error,
        );

  CheckoutSubmitStateProcessError.fromViewModel({
    required CheckoutSubmitStateViewModel viewModel,
    dynamic error,
  }) : super(
          trnCheckoutSubmit: viewModel.trnCheckoutSubmit,
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

class CheckoutSubmitSubmitted extends CheckoutSubmitStateViewModel {
  const CheckoutSubmitSubmitted({
    required TrnCheckoutSubmit trnCheckoutSubmit,
  }) : super(
          trnCheckoutSubmit: trnCheckoutSubmit,
          type: ProgressErrorStateType.submitted,
        );

  CheckoutSubmitSubmitted.fromViewModel({
    required CheckoutSubmitStateViewModel viewModel,
  }) : super(
          trnCheckoutSubmit: viewModel.trnCheckoutSubmit,
          type: ProgressErrorStateType.submitted,
        );
}
