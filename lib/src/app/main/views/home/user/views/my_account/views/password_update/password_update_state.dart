import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PasswordUpdateState extends ProgressViewState {
  const PasswordUpdateState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PasswordUpdateStateIdle extends PasswordUpdateState {
  const PasswordUpdateStateIdle()
      : super(
    type: ProgressErrorStateType.idle,
  );
}

class PasswordUpdateStateProgressError extends PasswordUpdateState {
  const PasswordUpdateStateProgressError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

