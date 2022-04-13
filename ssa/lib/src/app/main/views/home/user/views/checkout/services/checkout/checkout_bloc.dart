import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_state.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/models/business/open_status.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_payment_method.dart';
import 'package:single_store_app/src/app/models/infrastructure/dialog_message.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required this.checkoutRepo,
    required this.storeStatusBloc,
    required this.cartBloc,
    required this.homeNavCubit,
    required this.checkoutNavCubit,
    required this.appNavigatorCubit,
    required this.businessSettingsBloc,
  }) : super(CheckoutStateInitial()) {
    on<CheckoutEventLoad>((event, emit) async {
      try {
        if (businessSettingsBloc.state.type !=
            BusinessSettingStateType.loaded) {
          throw CheckoutStateLoadingError.fromUnexpectedState(
            checkoutState: state,
          );
        }

        final BusinessSettingsStateLoaded businessSettingsStateLoaded =
            businessSettingsBloc.state as BusinessSettingsStateLoaded;

        if (cartBloc.state.type != ProgressErrorStateType.loaded) {
          throw CheckoutStateLoadingError.fromUnexpectedState(
            checkoutState: state,
          );
        }
        final CartStateViewModel cartStateViewModel =
            cartBloc.state as CartStateViewModel;

        emit(CheckoutStateIdle.fromCheckoutState(
          cart: cartStateViewModel.cart,
          userBillingClient: await checkoutRepo.getUserBillingClient(),
          businessSettingsStateLoaded: businessSettingsStateLoaded,
          checkoutState: state,
        ));
      } on CheckoutStateLoadingError catch (e) {
        emit(e);
      } catch (e) {
        emit(CheckoutStateLoadingError.fromCheckoutState(
            checkoutState: state, error: e));
      }
    });

    on<CheckoutEventUpdateDeliveryMethod>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;

        try {
          if (businessSettingsBloc.state.type !=
              BusinessSettingStateType.loaded) {
            throw CheckoutStateLoadingError.fromUnexpectedState(
              checkoutState: state,
            );
          }

          final BusinessSettingsStateLoaded businessSettingsStateLoaded =
              businessSettingsBloc.state as BusinessSettingsStateLoaded;

          if (cartBloc.state.type != ProgressErrorStateType.loaded) {
            throw CheckoutStateLoadingError.fromUnexpectedState(
              checkoutState: state,
            );
          }
          final CartStateViewModel cartStateViewModel =
              cartBloc.state as CartStateViewModel;

          emit(CheckoutStateIdle(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: TrnCheckout.updateTrnCheckoutDeliveryMethod(
              state.trnCheckout,
              cartStateViewModel.cart,
              checkoutStateViewModel.userBillingClient,
              businessSettingsStateLoaded,
              event.trnCheckoutDeliveryMethod,
            ),
          ));
        } on CheckoutStateLoadingError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutStateProgressError.fromCheckoutViewModel(
            checkoutStateViewModel: checkoutStateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    on<CheckoutEventUpdateAddress>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;

        try {
          if (businessSettingsBloc.state.type !=
              BusinessSettingStateType.loaded) {
            throw CheckoutStateLoadingError.fromUnexpectedState(
              checkoutState: state,
            );
          }

          final BusinessSettingsStateLoaded businessSettingsStateLoaded =
              businessSettingsBloc.state as BusinessSettingsStateLoaded;

          if (cartBloc.state.type != ProgressErrorStateType.loaded) {
            throw CheckoutStateLoadingError.fromUnexpectedState(
              checkoutState: state,
            );
          }
          final CartStateViewModel cartStateViewModel =
              cartBloc.state as CartStateViewModel;

          emit(CheckoutStateIdle(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: TrnCheckout.updateTrnCheckoutAddress(
              state.trnCheckout,
              cartStateViewModel.cart,
              checkoutStateViewModel.userBillingClient,
              businessSettingsStateLoaded,
              event.trnCheckoutAddress,
            ),
          ));
        } on CheckoutStateLoadingError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutStateProgressError.fromCheckoutViewModel(
            checkoutStateViewModel: checkoutStateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    on<CheckoutEventUpdatePhone>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;

        try {
          emit(CheckoutStateIdle(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: TrnCheckout.updateTrnCheckoutPhone(
              state.trnCheckout,
              event.trnCheckoutPhone,
            ),
          ));
        } catch (e) {
          emit(CheckoutStateProgressError.fromCheckoutViewModel(
            checkoutStateViewModel: checkoutStateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    on<CheckoutEventUpdatePaymentMethod>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;

        try {
          emit(CheckoutStateIdle(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: TrnCheckout.updateTrnCheckoutPaymentMethod(
              state.trnCheckout,
              event.trnCheckoutPaymentMethod,
            ),
          ));
        } catch (e) {
          emit(CheckoutStateProgressError.fromCheckoutViewModel(
            checkoutStateViewModel: checkoutStateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    on<CheckoutEventRefreshPaymentMethod>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;

        try {
          emit(CheckoutStateIdle(
            userBillingClient: checkoutStateViewModel.userBillingClient,
            trnCheckout: TrnCheckout.updateTrnCheckoutPaymentMethod(
              state.trnCheckout,
              TrnCheckoutPaymentMethod.selectPaymentMethod(
                paymentMethods: await checkoutRepo.readUserPaymentMethods(),
                creditTransaction: checkoutStateViewModel
                    .userBillingClient.allowCreditTransaction,
              ),
            ),
          ));
        } catch (e) {
          emit(CheckoutStateProgressError.fromCheckoutViewModel(
            checkoutStateViewModel: checkoutStateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    on<CheckoutEventSubmit>((event, emit) async {
      if (state is CheckoutStateViewModel) {
        final CheckoutStateViewModel checkoutStateViewModel =
            state as CheckoutStateViewModel;
        emit(CheckoutStateSubmitted.fromCheckoutViewModel(
          checkoutStateViewModel: checkoutStateViewModel,
        ));
      } else {
        emit(CheckoutStateLoadingError.fromUnexpectedState(
          checkoutState: state,
        ));
      }
    });

    storeStatusBlocSubscription =
        storeStatusBloc.stream.listen((storeStatusState) {
      if (state.type != ProgressErrorStateType.submitted) {
        _checkStoreIsOpen(storeStatusState);
      }
    });
    cartBlocSubscription = cartBloc.stream.listen((cartState) {
      if (state.type != ProgressErrorStateType.submitted) {
        _checkCartIsValid(cartState);
      }
    });
  }

  final CheckoutRepo checkoutRepo;
  final StoreStatusBloc storeStatusBloc;
  final CartBloc cartBloc;
  final HomeNavCubit homeNavCubit;
  final CheckoutNavCubit checkoutNavCubit;
  final AppNavigatorCubit appNavigatorCubit;
  final BusinessSettingsBloc businessSettingsBloc;

  late StreamSubscription storeStatusBlocSubscription;
  late StreamSubscription cartBlocSubscription;

  bool _checkStoreIsOpen(StoreStatusState storeStatusState) {
    if (storeStatusState is StoreStatusStateLoaded && storeStatusState.closed) {
      homeNavCubit.showCategories();
      appNavigatorCubit.showMessageDialog(
          storeStatusState.storeStatus.openStatus.dialogMessage);
      return false;
    } else {
      return true;
    }
  }

  bool _checkCartIsValid(CartState cartState) {
    if (cartState is CartStateViewModel) {
      if (cartState.cart.cartActive.items.isEmpty) {
        homeNavCubit.showCategories();
        appNavigatorCubit.showMessageDialog(DialogMessage(
            title: 'Cart Empty', content: 'Your shopping cart has no items!'));
      }
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> close() {
    storeStatusBlocSubscription.cancel();
    cartBlocSubscription.cancel();
    return super.close();
  }
}
