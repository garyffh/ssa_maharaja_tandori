import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_order.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_totals.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'checkout_submit_event.dart';
import 'checkout_submit_state.dart';

class CheckoutSubmitBloc
    extends Bloc<CheckoutSubmitEvent, CheckoutSubmitState> {
  CheckoutSubmitBloc({
    required this.checkoutNavCubit,
    required this.checkoutBloc,
    required this.cartBloc,
    required this.userBusinessBloc,
    required this.storeStatusBloc,
    required this.businessSettingsBloc,
    required this.checkoutRepo,
  }) : super(const CheckoutSubmitStateInitial()) {
    on<CheckoutSubmitEventGetViewModel>((event, emit) async {
      try {
        emit(const CheckoutSubmitLoadingError());

        emit(CheckoutSubmitStateLoaded.fromTrnCheckout(
          trnCheckout: checkoutBloc.state.trnCheckout,
        ));
      } catch (e) {
        emit(CheckoutSubmitLoadingError(error: e));
      }
    });

    on<CheckoutSubmitEventSubmit>((event, emit) async {
      if (state is CheckoutSubmitStateViewModel) {
        final CheckoutSubmitStateViewModel stateViewModel =
            state as CheckoutSubmitStateViewModel;

        try {
          emit(CheckoutSubmitStateProcessError.fromViewModel(
              viewModel: stateViewModel));

          if (businessSettingsBloc.state is! BusinessSettingsStateLoaded) {
            throw CheckoutSubmitLoadingError.fromUnexpectedState();
          }
          final BusinessSettingsStateLoaded businessSettingsState =
              businessSettingsBloc.state as BusinessSettingsStateLoaded;

          if (storeStatusBloc.state is! StoreStatusStateLoaded) {
            throw CheckoutSubmitLoadingError.fromUnexpectedState();
          }
          final StoreStatusStateLoaded storeStatusStateLoaded =
              storeStatusBloc.state as StoreStatusStateLoaded;

          if (cartBloc.state is! CartStateViewModel) {
            throw CheckoutSubmitLoadingError.fromUnexpectedState();
          }
          final CartStateViewModel cartStateViewModel =
              cartBloc.state as CartStateViewModel;

          if (checkoutBloc.state is! CheckoutStateViewModel) {
            throw CheckoutSubmitLoadingError.fromUnexpectedState();
          }
          final CheckoutStateViewModel checkoutStateViewModel =
              checkoutBloc.state as CheckoutStateViewModel;

          if (checkoutBloc.state.trnCheckout.trnCheckoutDeliveryMethod ==
              null) {
            throw AppException.fromString(
                'The delivery method has not been selected!');
          }
          if (checkoutBloc.state.trnCheckout.trnCheckoutAddress == null) {
            throw AppException.fromString('The address has not been selected!');
          }
          if (checkoutBloc.state.trnCheckout.trnCheckoutPhone == null) {
            throw AppException.fromString(
                'The mobile number has not been entered!');
          }


          late TrnOrder trnOrder;

          if (event.checkoutSubmitMethod.paymentOptionType ==
              PaymentOptionType.account) {
            trnOrder = await checkoutRepo.sendOrderNoPayment(
              content: TrnCheckoutOrder.fromCheckoutSubmit(
                identity: businessSettingsBloc.state.identity,
                userBillingClient: checkoutStateViewModel.userBillingClient,
                storeStatusState: storeStatusStateLoaded,
                trnCheckout: checkoutStateViewModel.trnCheckout,
                trnCheckoutTotals: TrnCheckoutTotals.fromCheckoutSubmit(
                  businessSettings: businessSettingsState,
                  cart: cartStateViewModel.cart,
                  trnCheckoutSubmit: stateViewModel.trnCheckoutSubmit,
                  checkoutSubmitMethod: event.checkoutSubmitMethod,
                ),
                priceLevel: userBusinessBloc.state.priceLevel,
                storeDeliveryZoneId: businessSettingsState.storeDeliveryZoneId(
                    checkoutBloc
                        .state.trnCheckout.trnCheckoutAddress!.distance),
              ),
            );
          } else {
            trnOrder = await checkoutRepo.sendOrderWithPayment(
              content: TrnCheckoutOrder.fromCheckoutSubmit(
                identity: businessSettingsBloc.state.identity,
                userBillingClient: checkoutStateViewModel.userBillingClient,
                storeStatusState: storeStatusStateLoaded,
                trnCheckout: checkoutStateViewModel.trnCheckout,
                trnCheckoutTotals: TrnCheckoutTotals.fromCheckoutSubmit(
                  businessSettings: businessSettingsState,
                  cart: cartStateViewModel.cart,
                  trnCheckoutSubmit: stateViewModel.trnCheckoutSubmit,
                  checkoutSubmitMethod: event.checkoutSubmitMethod,
                ),
                priceLevel: userBusinessBloc.state.priceLevel,
                storeDeliveryZoneId: businessSettingsState.storeDeliveryZoneId(
                    checkoutBloc
                        .state.trnCheckout.trnCheckoutAddress!.distance),
              ),
            );
          }

          emit(CheckoutSubmitSubmitted.fromViewModel(
            viewModel: stateViewModel,
          ));

          checkoutBloc.add(CheckoutEventSubmit());

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateSubmitted ||
                  element is CheckoutStateLoadingError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutSubmitStateProcessError.fromViewModel(
                viewModel: stateViewModel, error: nextCheckoutState.error);
          }

          checkoutNavCubit.showComplete(trnOrder);
        } on CheckoutSubmitLoadingError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutSubmitStateProcessError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutSubmitLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final CheckoutNavCubit checkoutNavCubit;
  final CheckoutBloc checkoutBloc;
  final CartBloc cartBloc;
  final UserBusinessBloc userBusinessBloc;
  final StoreStatusBloc storeStatusBloc;
  final BusinessSettingsBloc businessSettingsBloc;
  final CheckoutRepo checkoutRepo;
}
