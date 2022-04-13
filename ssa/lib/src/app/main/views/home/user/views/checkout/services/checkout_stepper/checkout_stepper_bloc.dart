import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_state.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';

import 'checkout_stepper_event.dart';
import 'checkout_stepper_state.dart';
import 'models/checkout_stepper_step.dart';

class CheckoutStepperBloc
    extends Bloc<CheckoutStepperEvent, CheckoutStepperState> {
  CheckoutStepperBloc({
    required this.checkoutRepo,
    required this.storeStatusBloc,
    required this.checkoutNavCubit,
    required this.appNavigatorCubit,
  }) : super(const CheckoutStepperStateInitial()) {
    on<CheckoutStepperEventGetViewModel>((event, emit) async {
      try {
        emit(const CheckoutStepperStateLoadingError());

        emit(const CheckoutStepperStateLoaded(
          currentStep: CheckoutStepperStep.deliveryMethod,
        ));
      } catch (e) {
        emit(CheckoutStepperStateLoadingError(error: e));
      }
    });

    on<CheckoutStepperEventNext>((event, emit) async {
      if (state is CheckoutStepperStateViewModel) {
        final CheckoutStepperStateViewModel viewModel =
            state as CheckoutStepperStateViewModel;

        try {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep));

          emit(CheckoutStepperStateLoaded(
            currentStep: viewModel.currentStep.index <
                    CheckoutStepperStep.submit.index
                ? CheckoutStepperStep.values[viewModel.currentStep.index + 1]
                : viewModel.currentStep,
          ));
        } catch (e) {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep, error: e));
        }
      } else {
        emit(CheckoutStepperStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutStepperEventBack>((event, emit) async {
      if (state is CheckoutStepperStateViewModel) {
        final CheckoutStepperStateViewModel viewModel =
            state as CheckoutStepperStateViewModel;

        try {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep));

          emit(CheckoutStepperStateLoaded(
            currentStep: viewModel.currentStep.index >
                    CheckoutStepperStep.deliveryMethod.index
                ? CheckoutStepperStep.values[viewModel.currentStep.index - 1]
                : viewModel.currentStep,
          ));
        } catch (e) {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep, error: e));
        }
      } else {
        emit(CheckoutStepperStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<CheckoutStepperEventShowDeliveryMethod>((event, emit) async {
      if (state is CheckoutStepperStateViewModel) {
        final CheckoutStepperStateViewModel viewModel =
            state as CheckoutStepperStateViewModel;

        try {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep));

          emit(const CheckoutStepperStateLoaded(
            currentStep: CheckoutStepperStep.deliveryMethod,
            resetStep: true,
          ));

          appNavigatorCubit.showCheckoutDeliveryMethodRefresh();
        } catch (e) {
          emit(CheckoutStepperStateProgressError(
              currentStep: viewModel.currentStep, error: e));
        }
      }
    });

    storeStatusBlocSubscription =
        storeStatusBloc.stream.listen((storeStatusState) {
      if (!storeStatusState.closed &&
          state.viewStep != CheckoutStepperStep.deliveryMethod &&
          checkoutNavCubit.state.view == CheckoutView.stepper) {
        add(CheckoutStepperEventShowDeliveryMethod());
      }
    });
  }

  final CheckoutRepo checkoutRepo;
  final StoreStatusBloc storeStatusBloc;
  final CheckoutNavCubit checkoutNavCubit;
  final AppNavigatorCubit appNavigatorCubit;

  late StreamSubscription storeStatusBlocSubscription;

  @override
  Future<void> close() {
    storeStatusBlocSubscription.cancel();
    return super.close();
  }
}
