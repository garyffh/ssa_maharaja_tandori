import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_event.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/models/checkout/checkout_delivery_method.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';

import 'checkout_delivery_method_event.dart';
import 'checkout_delivery_method_state.dart';

class CheckoutDeliveryMethodBloc
    extends Bloc<CheckoutDeliveryMethodEvent, CheckoutDeliveryMethodState> {
  CheckoutDeliveryMethodBloc({
    required this.homeNavCubit,
    required this.storeStatusBloc,
    required this.appNavigatorCubit,
    required this.checkoutNavCubit,
    required this.checkoutBloc,
    required this.checkoutStepperBloc,
  }) : super(const CheckoutDeliveryMethodStateInitial()) {
    on<CheckoutDeliveryMethodEventGetViewModel>((event, emit) async {
      try {
        emit(const CheckoutDeliveryMethodStateLoadingError());

        /// --------- Load User Billing Client ---------------

        checkoutBloc.add(CheckoutEventLoad());

        final CheckoutState nextCheckoutState = await checkoutBloc.stream
            .firstWhere((element) =>
                element is CheckoutStateIdle ||
                element is CheckoutStateLoadingError);

        if (nextCheckoutState is CheckoutStateLoadingError) {
          throw CheckoutDeliveryMethodStateLoadingError(
              error: nextCheckoutState.error);
        }

        /// --------- Refresh Store Status ---------------

        storeStatusBloc.add(StoreStatusEventImmediateRefresh());

        final StoreStatusState nextStoreStatusState =
            await storeStatusBloc.stream.firstWhere((element) =>
                element is StoreStatusStateLoaded ||
                element is StoreStatusStateImmediateRefreshError ||
                element is StoreStatusStatePendingError);

        if (nextStoreStatusState is StoreStatusStateImmediateRefreshError) {
          throw CheckoutDeliveryMethodStateLoadingError(
              error: nextStoreStatusState.error);
        } else if (nextStoreStatusState is StoreStatusStatePendingError) {
          throw CheckoutDeliveryMethodStateLoadingError(
              error: nextStoreStatusState.error);
        }

        emit(CheckoutDeliveryMethodStateViewLoaded(
          checkoutDeliveryMethod: CheckoutDeliveryMethod.fromStoreStatus(
              (storeStatusBloc.state as StoreStatusStateLoaded).storeStatus),
        ));

        _checkStoreIsOpen();
      } on CheckoutDeliveryMethodStateLoadingError catch (e) {
        emit(e);
      } catch (e) {
        emit(CheckoutDeliveryMethodStateLoadingError(error: e));
      }
    });

    on<CheckoutDeliveryMethodEventRefresh>((event, emit) async {
      try {
        if (!storeStatusBloc.state.loaded) {
          return;
        }

        if (state.type != ProgressErrorStateType.loaded) {
          return;
        }

        emit(CheckoutDeliveryMethodStateViewLoaded(
          checkoutDeliveryMethod: CheckoutDeliveryMethod.fromStoreStatus(
              (storeStatusBloc.state as StoreStatusStateLoaded).storeStatus),
        ));

        if (_checkStoreIsOpen()) {
          appNavigatorCubit.showCheckoutDeliveryMethodRefresh();
        }
      } catch (e) {
        emit(CheckoutDeliveryMethodStateLoadingError(error: e));
      }
    });

    on<CheckoutDeliveryMethodEventSubmit>((event, emit) async {
      if (state is CheckoutDeliveryMethodStateViewModel) {
        final CheckoutDeliveryMethodStateViewModel stateViewModel =
            state as CheckoutDeliveryMethodStateViewModel;
        try {
          emit(CheckoutDeliveryMethodStateProgressError(
              checkoutDeliveryMethod: stateViewModel.checkoutDeliveryMethod));

          checkoutBloc.add(CheckoutEventUpdateDeliveryMethod(
            trnCheckoutDeliveryMethod: event.trnCheckoutDeliveryMethod,
          ));

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateIdle ||
                  element is CheckoutStateLoadingError ||
                  element is CheckoutStateProgressError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutDeliveryMethodStateProgressError(
                checkoutDeliveryMethod: stateViewModel.checkoutDeliveryMethod,
                error: nextCheckoutState.error);
          } else if (nextCheckoutState is CheckoutStateProgressError) {
            throw CheckoutDeliveryMethodStateProgressError(
                checkoutDeliveryMethod: stateViewModel.checkoutDeliveryMethod,
                error: nextCheckoutState.error);
          }

          checkoutStepperBloc.add(CheckoutStepperEventNext());
        } on CheckoutDeliveryMethodStateProgressError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutDeliveryMethodStateProgressError(
            checkoutDeliveryMethod: stateViewModel.checkoutDeliveryMethod,
            error: e,
          ));
        }
      } else {
        emit(CheckoutDeliveryMethodStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    storeStatusBlocSubscription =
        storeStatusBloc.stream.listen((storeStatusState) {
      if (!storeStatusState.closed &&
          state.type == ProgressErrorStateType.loaded) {
        add(CheckoutDeliveryMethodEventRefresh());
      }
    });
  }

  final HomeNavCubit homeNavCubit;
  final StoreStatusBloc storeStatusBloc;
  final AppNavigatorCubit appNavigatorCubit;
  final CheckoutNavCubit checkoutNavCubit;
  final CheckoutBloc checkoutBloc;
  final CheckoutStepperBloc checkoutStepperBloc;

  late StreamSubscription storeStatusBlocSubscription;

  bool _checkStoreIsOpen() {
    if (state is CheckoutDeliveryMethodStateViewLoaded) {
      if ((state as CheckoutDeliveryMethodStateViewModel)
          .checkoutDeliveryMethod
          .isClosed) {
        homeNavCubit.showCategories();
        appNavigatorCubit.showStoreClosed();
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  @override
  Future<void> close() {
    storeStatusBlocSubscription.cancel();
    return super.close();
  }
}
