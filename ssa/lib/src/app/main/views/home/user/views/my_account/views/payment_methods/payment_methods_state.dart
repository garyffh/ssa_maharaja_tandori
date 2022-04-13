import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method.dart';

@immutable
abstract class PaymentMethodsState extends ProgressErrorState {
  const PaymentMethodsState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PaymentMethodsStateInitial extends PaymentMethodsState {
  const PaymentMethodsStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class PaymentMethodsStateLoadingError extends PaymentMethodsState {
  const PaymentMethodsStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class PaymentMethodsStateProgressError extends PaymentMethodsState {
  const PaymentMethodsStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

class PaymentMethodsStateViewModel extends PaymentMethodsState {
  const PaymentMethodsStateViewModel({
    required this.paymentMethods,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final List<UserPaymentMethod> paymentMethods;
}
