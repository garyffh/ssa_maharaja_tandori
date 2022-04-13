import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_phone.dart';

import 'checkout_phone_event.dart';
import 'checkout_phone_state.dart';
import 'models/checkout_phone_view_type.dart';

class CheckoutPhoneBloc extends Bloc<CheckoutPhoneEvent, CheckoutPhoneState> {
  CheckoutPhoneBloc({
    required this.checkoutNavCubit,
    required this.checkoutBloc,
    required this.checkoutStepperBloc,
  }) : super(const CheckoutPhoneStateInitial()) {
    on<CheckoutPhoneEventGetViewModel>((event, emit) async {
      try {
        emit(CheckoutPhoneStateLoadingError.fromState(
            checkoutPhoneState: state));

        emit(CheckoutPhoneStateLoaded.fromTrnCheckout(
          trnCheckout: checkoutBloc.state.trnCheckout,
        ));
      } catch (e) {
        emit(CheckoutPhoneStateLoadingError.fromState(
            checkoutPhoneState: state, error: e));
      }
    });

    on<CheckoutPhoneEventShowUpdate>((event, emit) async {
      if (state is CheckoutPhoneStateViewModel) {
        final CheckoutPhoneStateViewModel stateViewModel =
            state as CheckoutPhoneStateViewModel;
        try {
          emit(CheckoutPhoneStateLoaded(
            checkoutPhoneViewType: CheckoutPhoneViewType.update,
            trnCheckoutPhone: stateViewModel.trnCheckoutPhone,
          ));
        } catch (e) {
          emit(CheckoutPhoneStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPhoneStateLoadingError.fromState(
          checkoutPhoneState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPhoneEventShowCode>((event, emit) async {
      if (state is CheckoutPhoneStateViewModel) {
        final CheckoutPhoneStateViewModel stateViewModel =
            state as CheckoutPhoneStateViewModel;
        try {
          emit(CheckoutPhoneStateLoaded(
            checkoutPhoneViewType: CheckoutPhoneViewType.code,
            trnCheckoutPhone: stateViewModel.trnCheckoutPhone,
            showCodeMobileNumber: event.mobileNumber,
          ));
        } catch (e) {
          emit(CheckoutPhoneStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPhoneStateLoadingError.fromState(
          checkoutPhoneState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPhoneEventShowView>((event, emit) async {
      if (state is CheckoutPhoneStateViewModel) {
        final CheckoutPhoneStateViewModel stateViewModel =
            state as CheckoutPhoneStateViewModel;
        try {
          emit(CheckoutPhoneStateLoaded(
            checkoutPhoneViewType: CheckoutPhoneViewType.view,
            trnCheckoutPhone: stateViewModel.trnCheckoutPhone,
          ));
        } catch (e) {
          emit(CheckoutPhoneStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPhoneStateLoadingError.fromState(
          checkoutPhoneState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutPhoneEventSubmit>((event, emit) async {
      if (state is CheckoutPhoneStateViewModel) {
        final CheckoutPhoneStateViewModel stateViewModel =
            state as CheckoutPhoneStateViewModel;
        try {
          emit(CheckoutPhoneStateProgressError.fromViewModel(
            viewModel: stateViewModel,
          ));

          checkoutBloc.add(CheckoutEventUpdatePhone(
            trnCheckoutPhone: TrnCheckoutPhone(
              phoneNumber: event.phone,
              phoneNumberConfirmed: true,
            ),
          ));

          final CheckoutState nextCheckoutState = await checkoutBloc.stream
              .firstWhere((element) =>
                  element is CheckoutStateIdle ||
                  element is CheckoutStateLoadingError ||
                  element is CheckoutStateProgressError);

          if (nextCheckoutState is CheckoutStateLoadingError) {
            throw CheckoutPhoneStateProgressError(
                trnCheckoutPhone: stateViewModel.trnCheckoutPhone,
                checkoutPhoneViewType: stateViewModel.checkoutPhoneViewType,
                error: nextCheckoutState.error);
          } else if (nextCheckoutState is CheckoutStateProgressError) {
            throw CheckoutPhoneStateProgressError(
                trnCheckoutPhone: stateViewModel.trnCheckoutPhone,
                checkoutPhoneViewType: stateViewModel.checkoutPhoneViewType,
                error: nextCheckoutState.error);
          }

          checkoutStepperBloc.add(CheckoutStepperEventNext());
        } on CheckoutPhoneStateProgressError catch (e) {
          emit(e);
        } catch (e) {
          emit(CheckoutPhoneStateProgressError.fromViewModel(
            viewModel: stateViewModel,
            error: e,
          ));
        }
      } else {
        emit(CheckoutPhoneStateLoadingError.fromState(
          checkoutPhoneState: state,
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final CheckoutNavCubit checkoutNavCubit;
  final CheckoutBloc checkoutBloc;
  final CheckoutStepperBloc checkoutStepperBloc;
}
