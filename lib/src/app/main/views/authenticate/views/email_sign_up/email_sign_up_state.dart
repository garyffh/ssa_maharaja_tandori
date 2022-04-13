import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class EmailSignUpState extends ProgressViewState {
  const EmailSignUpState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

}

class EmailSignUpStateIdle extends EmailSignUpState {
  const EmailSignUpStateIdle() : super(
    type: ProgressErrorStateType.idle,
  );
}

class EmailSignUpStateProgressError extends EmailSignUpState {
  const EmailSignUpStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

