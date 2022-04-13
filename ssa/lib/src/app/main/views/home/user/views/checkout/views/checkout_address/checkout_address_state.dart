import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/string_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'models/checkout_address_view_type.dart';

@immutable
abstract class CheckoutAddressState extends ProgressErrorState {
  const CheckoutAddressState({
    required this.checkoutAddressViewType,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
  final CheckoutAddressViewType checkoutAddressViewType;
}

class CheckoutAddressStateInitial extends CheckoutAddressState {
  const CheckoutAddressStateInitial()
      : super(
          checkoutAddressViewType: CheckoutAddressViewType.view,
          type: ProgressErrorStateType.initial,
        );
}

class CheckoutAddressStateLoadingError extends CheckoutAddressState {
  const CheckoutAddressStateLoadingError({
    required CheckoutAddressViewType checkoutAddressViewType,
    dynamic error,
  }) : super(
          checkoutAddressViewType: checkoutAddressViewType,
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  CheckoutAddressStateLoadingError.fromState({
    required CheckoutAddressState checkoutAddressState,
    dynamic error,
  }) : super(
          checkoutAddressViewType: checkoutAddressState.checkoutAddressViewType,
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  CheckoutAddressStateLoadingError.fromUnexpectedState({
    required CheckoutAddressState checkoutAddressState,
  }) : super(
          checkoutAddressViewType: checkoutAddressState.checkoutAddressViewType,
          type: ProgressErrorStateType.loadingError,
          error: AppException.fromString(unexpectedBlocState),
        );
}

class CheckoutAddressStateViewModel extends CheckoutAddressState {
  const CheckoutAddressStateViewModel({
    required this.trnCheckoutAddress,
    required this.validAddressDistance,
    required CheckoutAddressViewType checkoutAddressViewType,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
          checkoutAddressViewType: checkoutAddressViewType,
          error: error,
          type: type,
        );

  final TrnCheckoutAddress? trnCheckoutAddress;
  final bool validAddressDistance;

  static bool updateValidAddressDistance(
    TrnCheckout trnCheckout,
    TrnCheckoutAddress? trnCheckoutAddress,
    double maxDeliveryDistance,
  ) {
    if (trnCheckoutAddress != null &&
        trnCheckout.trnCheckoutDeliveryMethod != null) {
      if (trnCheckoutAddress.distance != null &&
          trnCheckout.trnCheckoutDeliveryMethod!.deliveryMethodType != null) {
        if (trnCheckout.trnCheckoutDeliveryMethod!.deliveryMethodType ==
                DeliveryMethodType.delivery ||
            trnCheckout.trnCheckoutDeliveryMethod!.deliveryMethodType ==
                DeliveryMethodType.period) {
          return trnCheckoutAddress.distance! <= maxDeliveryDistance;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}

class CheckoutAddressStateLoaded extends CheckoutAddressStateViewModel {
  const CheckoutAddressStateLoaded({
    required TrnCheckoutAddress? trnCheckoutAddress,
    required bool validAddressDistance,
    required CheckoutAddressViewType checkoutAddressViewType,
  }) : super(
          trnCheckoutAddress: trnCheckoutAddress,
          validAddressDistance: validAddressDistance,
          checkoutAddressViewType: checkoutAddressViewType,
          type: ProgressErrorStateType.loaded,
        );

  CheckoutAddressStateLoaded.fromTrnCheckout({
    required TrnCheckout trnCheckout,
    required double maxDeliveryDistance,
  }) : super(
          trnCheckoutAddress: trnCheckout.trnCheckoutAddress,
          validAddressDistance:
              CheckoutAddressStateViewModel.updateValidAddressDistance(
            trnCheckout,
            trnCheckout.trnCheckoutAddress,
            maxDeliveryDistance,
          ),
          checkoutAddressViewType: trnCheckout.hasAddress
              ? CheckoutAddressViewType.view
              : CheckoutAddressViewType.update,
          type: ProgressErrorStateType.loaded,
        );

  CheckoutAddressStateLoaded.updateTrnCheckoutAddress({
    required TrnCheckout trnCheckout,
    required double maxDeliveryDistance,
    required TrnCheckoutAddress trnCheckoutAddress,
  }) : super(
          trnCheckoutAddress: trnCheckoutAddress,
          validAddressDistance:
              CheckoutAddressStateViewModel.updateValidAddressDistance(
            trnCheckout,
            trnCheckoutAddress,
            maxDeliveryDistance,
          ),
          checkoutAddressViewType: hasAddress(trnCheckoutAddress)
              ? CheckoutAddressViewType.view
              : CheckoutAddressViewType.update,
          type: ProgressErrorStateType.loaded,
        );


  static bool hasAddress(TrnCheckoutAddress? trnCheckoutAddress) {
    if (trnCheckoutAddress == null) {
      return false;
    } else {
      if (trnCheckoutAddress.street.isNullOrEmpty ||
          trnCheckoutAddress.locality.isNullOrEmpty ||
          trnCheckoutAddress.region.isNullOrEmpty ||
          trnCheckoutAddress.postalCode.isNullOrEmpty ||
          trnCheckoutAddress.country.isNullOrEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

}

class CheckoutAddressStateProgressError extends CheckoutAddressStateViewModel {
  const CheckoutAddressStateProgressError({
    required TrnCheckoutAddress? trnCheckoutAddress,
    required bool validAddressDistance,
    required CheckoutAddressViewType checkoutAddressViewType,
    dynamic error,
  }) : super(
          trnCheckoutAddress: trnCheckoutAddress,
          validAddressDistance: validAddressDistance,
          checkoutAddressViewType: checkoutAddressViewType,
          type: ProgressErrorStateType.progressError,
          error: error,
        );

  CheckoutAddressStateProgressError.fromViewModel({
    required CheckoutAddressStateViewModel viewModel,
    dynamic error,
  }) : super(
          trnCheckoutAddress: viewModel.trnCheckoutAddress,
          validAddressDistance: viewModel.validAddressDistance,
          checkoutAddressViewType: viewModel.checkoutAddressViewType,
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}
