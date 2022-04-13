import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PaymentMethodWidgetState extends ProgressViewState {
  const PaymentMethodWidgetState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PaymentMethodWidgetStateIdle extends PaymentMethodWidgetState {
  const PaymentMethodWidgetStateIdle()
      : super(
          type: ProgressErrorStateType.idle,
        );
}

class PaymentMethodWidgetStateProgressError extends PaymentMethodWidgetState {
  const PaymentMethodWidgetStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

class PaymentMethodWidgetStateSubmitted extends PaymentMethodWidgetState {
  const PaymentMethodWidgetStateSubmitted() : super(
    type: ProgressErrorStateType.submitted,
  );

}
