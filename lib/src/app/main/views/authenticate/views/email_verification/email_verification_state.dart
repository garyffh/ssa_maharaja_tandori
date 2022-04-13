import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class EmailVerificationState extends ProgressViewState {
  const EmailVerificationState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

}

class EmailVerificationStateIdle extends EmailVerificationState {
  const EmailVerificationStateIdle() : super(
    type: ProgressErrorStateType.idle,
  );
}

class EmailVerificationStateProgressError extends EmailVerificationState {
  const EmailVerificationStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

