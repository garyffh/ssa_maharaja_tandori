import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PasswordResetState extends ProgressViewState {
  const PasswordResetState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

}

class PasswordResetStateIdle extends PasswordResetState {
  const PasswordResetStateIdle() : super(
    type: ProgressErrorStateType.idle,
  );
}

class PasswordResetStateProgressError extends PasswordResetState {
  const PasswordResetStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

