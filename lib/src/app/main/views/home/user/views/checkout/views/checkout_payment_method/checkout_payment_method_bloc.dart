import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_payment_method.dart';

import 'checkout_payment_method_event.dart';
import 'checkout_payment_method_state.dart';
import 'models/checkout_payment_method_view_type.dart';

class CheckoutPaymentMethodBloc
    extends Bloc<CheckoutPaymentMethodEvent, CheckoutPaymentMethodState> {
  CheckoutPaymentMethodBloc({
    required this.checkoutNavCubit,
    required this.checkoutBloc,
    required this.checkoutStepperBloc,
  }) : super(const CheckoutPaymentMethodStateInitial()) {
    on<CheckoutPaymentMethodEventGetViewModel>((event, emit) async {
      try {

        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
        ));

        emit(CheckoutPaymentMethodStateLoaded.fromTrnCheckout(
          trnCheckout: checkoutBloc.state.trnCheckout,
        ));

      } catch (e) {
        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
          error: e,
        ));
      }
    });

    on<CheckoutPaymentMethodEventShowAdd>((event, emit) async {
      if (state is CheckoutPaymentMethodStateViewModel) {
        final CheckoutPaymentMethodStateViewModel stateViewModel =
            state as CheckoutPaymentMethodStateViewModel;
        try {
          emit(CheckoutPaymentMethodStateLoaded(
            checkoutPaymentMethodViewType: CheckoutPaymentMethodViewType.add,
            trnCheckoutPaymentMethod: stateViewModel.trnCheckoutPaymentMethod,
          ));
        } catch (e) {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPaymentMethodEventShowView>((event, emit) async {
      if (state is CheckoutPaymentMethodStateViewModel) {
        final CheckoutPaymentMethodStateViewModel stateViewModel =
            state as CheckoutPaymentMethodStateViewModel;
        try {
          emit(CheckoutPaymentMethodStateLoaded(
            checkoutPaymentMethodViewType: CheckoutPaymentMethodViewType.view,
            trnCheckoutPaymentMethod: stateViewModel.trnCheckoutPaymentMethod,
          ));
        } catch (e) {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPaymentMethodEventRefresh>((event, emit) async {
      if (state is CheckoutPaymentMethodStateViewModel) {
        final CheckoutPaymentMethodStateViewModel stateViewModel =
            state as CheckoutPaymentMethodStateViewModel;
        try {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
          ));

          checkoutBloc.add(CheckoutEventRefreshPaymentMethod(
            trnCheckoutPaymentMethod: stateViewModel.trnCheckoutPaymentMethod,
          ));

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateIdle ||
                  element is CheckoutStateLoadingError ||
                  element is CheckoutStateProgressError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutPaymentMethodStateProgressError.fromViewModel(
                viewModel: stateViewModel, error: nextCheckoutState.error);
          } else if (nextCheckoutState is CheckoutStateProgressError) {
            throw CheckoutPaymentMethodStateProgressError.fromViewModel(
                viewModel: stateViewModel, error: nextCheckoutState.error);
          }

          emit(CheckoutPaymentMethodStateLoaded.fromTrnCheckout(
            trnCheckout: checkoutBloc.state.trnCheckout,
          ));

          if ((state as CheckoutPaymentMethodStateLoaded)
                  .trnCheckoutPaymentMethod
                  .selectedPaymentMethod !=
              null) {
            checkoutStepperBloc.add(CheckoutStepperEventNext());
          }
        } on CheckoutPaymentMethodStateProgressError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPaymentMethodEventSubmit>((event, emit) async {
      if (state is CheckoutPaymentMethodStateViewModel) {
        final CheckoutPaymentMethodStateViewModel stateViewModel =
            state as CheckoutPaymentMethodStateViewModel;
        try {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
          ));

          checkoutBloc.add(CheckoutEventUpdatePaymentMethod(
              trnCheckoutPaymentMethod: TrnCheckoutPaymentMethod(
            paymentMethods:
                stateViewModel.trnCheckoutPaymentMethod.paymentMethods,
            creditTransaction: event.creditTransaction,
            selectedPaymentMethod: event.selectedPaymentMethod,
          )));

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateIdle ||
                  element is CheckoutStateLoadingError ||
                  element is CheckoutStateProgressError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutPaymentMethodStateProgressError.fromViewModel(
                viewModel: stateViewModel, error: nextCheckoutState.error);
          } else if (nextCheckoutState is CheckoutStateProgressError) {
            throw CheckoutPaymentMethodStateProgressError.fromViewModel(
                viewModel: stateViewModel, error: nextCheckoutState.error);
          }

          checkoutStepperBloc.add(CheckoutStepperEventNext());
        } on CheckoutPaymentMethodStateProgressError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutPaymentMethodStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPaymentMethodStateLoadingError.fromState(
          checkoutPaymentMethodState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final CheckoutNavCubit checkoutNavCubit;
  final CheckoutBloc checkoutBloc;
  final CheckoutStepperBloc checkoutStepperBloc;
}
