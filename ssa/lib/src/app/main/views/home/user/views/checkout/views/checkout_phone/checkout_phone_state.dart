import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_phone.dart';

import 'models/checkout_phone_view_type.dart';

@immutable
abstract class CheckoutPhoneState extends ProgressErrorState {
  const CheckoutPhoneState({
    required this.checkoutPhoneViewType,    
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
  final CheckoutPhoneViewType checkoutPhoneViewType;  
}

class CheckoutPhoneStateInitial extends CheckoutPhoneState {
  const CheckoutPhoneStateInitial()
      : super(
    checkoutPhoneViewType: CheckoutPhoneViewType.view,
    type: ProgressErrorStateType.initial,
  );
}

class CheckoutPhoneStateLoadingError extends CheckoutPhoneState {
  const CheckoutPhoneStateLoadingError({
    required CheckoutPhoneViewType checkoutPhoneViewType,
    dynamic error,
  }) : super(
    checkoutPhoneViewType: checkoutPhoneViewType,
    type: ProgressErrorStateType.loadingError,
    error: error,
  );

  CheckoutPhoneStateLoadingError.fromState({
    required CheckoutPhoneState checkoutPhoneState,
    dynamic error,
  }) : super(
    checkoutPhoneViewType: checkoutPhoneState.checkoutPhoneViewType,
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
  
}

abstract class CheckoutPhoneStateViewModel extends CheckoutPhoneState {
  const CheckoutPhoneStateViewModel({
    required this.trnCheckoutPhone,
    required CheckoutPhoneViewType checkoutPhoneViewType,
    this.showCodeMobileNumber,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
    checkoutPhoneViewType: checkoutPhoneViewType,
    error: error,
    type: type,
  );

  final TrnCheckoutPhone? trnCheckoutPhone;
  final String? showCodeMobileNumber;

}

class CheckoutPhoneStateLoaded extends CheckoutPhoneStateViewModel {
  const CheckoutPhoneStateLoaded({
    required TrnCheckoutPhone? trnCheckoutPhone,
    required CheckoutPhoneViewType checkoutPhoneViewType,
    String? showCodeMobileNumber,
  }) : super(
    trnCheckoutPhone: trnCheckoutPhone,
    showCodeMobileNumber: showCodeMobileNumber,
    checkoutPhoneViewType: checkoutPhoneViewType,
    type: ProgressErrorStateType.loaded,
  );

  CheckoutPhoneStateLoaded.fromTrnCheckout({
    required TrnCheckout trnCheckout,
  }) : super(
    trnCheckoutPhone: trnCheckout.trnCheckoutPhone,
    checkoutPhoneViewType: trnCheckout.hasPhone
        ? CheckoutPhoneViewType.view
        : CheckoutPhoneViewType.update,
    type: ProgressErrorStateType.loaded,
  );
}

class CheckoutPhoneStateProgressError extends CheckoutPhoneStateViewModel {
  const CheckoutPhoneStateProgressError({
    required TrnCheckoutPhone? trnCheckoutPhone,
    required CheckoutPhoneViewType checkoutPhoneViewType,
    dynamic error,
  }) : super(
    trnCheckoutPhone: trnCheckoutPhone,
    checkoutPhoneViewType: checkoutPhoneViewType,
    type: ProgressErrorStateType.progressError,
    error: error,
  );

  CheckoutPhoneStateProgressError.fromViewModel({
    required CheckoutPhoneStateViewModel viewModel,
    dynamic error,
  }) : super(
    trnCheckoutPhone: viewModel.trnCheckoutPhone,
    checkoutPhoneViewType: viewModel.checkoutPhoneViewType,
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}
