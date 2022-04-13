import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

import 'models/checkout_stepper_step.dart';

@immutable
abstract class CheckoutStepperState extends ProgressErrorState {
  const CheckoutStepperState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

  CheckoutStepperStep get viewStep => CheckoutStepperStep.deliveryMethod;
}

class CheckoutStepperStateInitial extends CheckoutStepperState {
  const CheckoutStepperStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class CheckoutStepperStateLoadingError extends CheckoutStepperState {
  const CheckoutStepperStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

abstract class CheckoutStepperStateViewModel extends CheckoutStepperState {
  const CheckoutStepperStateViewModel({
    required this.currentStep,
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(
    type: type,
    error: error,
  );

  final CheckoutStepperStep currentStep;

  @override
  CheckoutStepperStep get viewStep => currentStep;

}

class CheckoutStepperStateProgressError extends CheckoutStepperStateViewModel {
  const CheckoutStepperStateProgressError({
    required CheckoutStepperStep currentStep,
    dynamic error,
  }) : super(
    currentStep: currentStep,
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

class CheckoutStepperStateLoaded extends CheckoutStepperStateViewModel {
  const CheckoutStepperStateLoaded({
    required CheckoutStepperStep currentStep,
    this.resetStep = false,
  }) : super(
    currentStep: currentStep,
    type: ProgressErrorStateType.loaded,
  );

  final bool resetStep;
}
