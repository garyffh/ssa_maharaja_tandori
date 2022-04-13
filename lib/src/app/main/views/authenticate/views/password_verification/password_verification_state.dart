import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PasswordVerificationState extends ProgressViewState {
  const PasswordVerificationState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

}

class PasswordVerificationStateIdle extends PasswordVerificationState {
  const PasswordVerificationStateIdle() : super(
    type: ProgressErrorStateType.idle,
  );
}

class PasswordVerificationStateProgressError extends PasswordVerificationState {
  const PasswordVerificationStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

