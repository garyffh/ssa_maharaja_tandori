import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PasswordCodeState extends ProgressViewState {
  const PasswordCodeState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

}

class PasswordCodeStateIdle extends PasswordCodeState {
  const PasswordCodeStateIdle() : super(
    type: ProgressErrorStateType.idle,
  );
}

class PasswordCodeStateProgressError extends PasswordCodeState {
  const PasswordCodeStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

