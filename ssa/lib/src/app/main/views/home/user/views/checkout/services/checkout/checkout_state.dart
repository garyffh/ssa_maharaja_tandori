import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/cart/cart.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

@immutable
abstract class CheckoutState extends ProgressErrorState {
  const CheckoutState({
    required this.trnCheckout,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

  final TrnCheckout trnCheckout;

}

class CheckoutStateInitial extends CheckoutState {
   CheckoutStateInitial()
      : super(
          trnCheckout: TrnCheckout.initial(),
          type: ProgressErrorStateType.initial,
        );
}

class CheckoutStateLoadingError extends CheckoutState {
  const CheckoutStateLoadingError({
    required TrnCheckout trnCheckout,
    dynamic error,
  }) : super(
          trnCheckout: trnCheckout,
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  CheckoutStateLoadingError.fromCheckoutState({
    required CheckoutState checkoutState,
    dynamic error,
  }) : super(
          trnCheckout: checkoutState.trnCheckout,
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  CheckoutStateLoadingError.fromUnexpectedState({
    required CheckoutState checkoutState,
  }) : super(
          trnCheckout: checkoutState.trnCheckout,
          type: ProgressErrorStateType.loadingError,
          error: AppException.fromString(unexpectedBlocState),
        );
}

abstract class CheckoutStateViewModel extends CheckoutState {
  const CheckoutStateViewModel({
    required this.userBillingClient,
    required TrnCheckout trnCheckout,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(
          trnCheckout: trnCheckout,
          type: type,
          error: error,
        );
  final UserBillingClient userBillingClient;

}

class CheckoutStateIdle extends CheckoutStateViewModel {
  const CheckoutStateIdle({
    required UserBillingClient userBillingClient,
    required TrnCheckout trnCheckout,
  }) : super(
          userBillingClient: userBillingClient,
          trnCheckout: trnCheckout,
          type: ProgressErrorStateType.idle,
        );

  CheckoutStateIdle.fromCheckoutViewModel({
    required CheckoutStateViewModel checkoutStateViewModel,
  }) : super(
          userBillingClient: checkoutStateViewModel.userBillingClient,
          trnCheckout: checkoutStateViewModel.trnCheckout,
          type: ProgressErrorStateType.idle,
        );

  CheckoutStateIdle.fromCheckoutState({
    required Cart cart,
    required UserBillingClient userBillingClient,
    required  BusinessSettingsStateLoaded businessSettingsStateLoaded,
    required CheckoutState checkoutState,
  }) : super(
          userBillingClient: userBillingClient,
          trnCheckout: TrnCheckout.updateFromUserBillingClient(
            checkoutState.trnCheckout,
            cart,
            userBillingClient,
            businessSettingsStateLoaded,
          ),
          type: ProgressErrorStateType.idle,
        );
}

class CheckoutStateProgressError extends CheckoutStateViewModel {
  const CheckoutStateProgressError({
    required UserBillingClient userBillingClient,
    required TrnCheckout trnCheckout,
    dynamic error,
  }) : super(
          userBillingClient: userBillingClient,
          trnCheckout: trnCheckout,
          type: ProgressErrorStateType.progressError,
          error: error,
        );

  CheckoutStateProgressError.fromCheckoutViewModel({
    required CheckoutStateViewModel checkoutStateViewModel,
    dynamic error,
  }) : super(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: checkoutStateViewModel.trnCheckout,
            type: ProgressErrorStateType.progressError,
            error: error);
}

class CheckoutStateSubmitted extends CheckoutStateViewModel {
  const CheckoutStateSubmitted({
    required UserBillingClient userBillingClient,
    required TrnCheckout trnCheckout,
  }) : super(
    userBillingClient: userBillingClient,
    trnCheckout: trnCheckout,
    type: ProgressErrorStateType.submitted,
  );

  CheckoutStateSubmitted.fromCheckoutViewModel({
    required CheckoutStateViewModel checkoutStateViewModel,
  }) : super(
      userBillingClient: checkoutStateViewModel.userBillingClient,
      trnCheckout: checkoutStateViewModel.trnCheckout,
      type: ProgressErrorStateType.submitted,
  );
}
