import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PhoneCodeWidgetState extends ProgressViewState {
  const PhoneCodeWidgetState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PhoneCodeWidgetStateIdle extends PhoneCodeWidgetState {
  const PhoneCodeWidgetStateIdle()
      : super(
    type: ProgressErrorStateType.idle,
  );
}

class PhoneCodeWidgetStateProgressError extends PhoneCodeWidgetState {
  const PhoneCodeWidgetStateProgressError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

class PhoneCodeWidgetStateSubmitted extends PhoneCodeWidgetState {
  const PhoneCodeWidgetStateSubmitted({
    required this.mobileNumber,
}) : super(
    type: ProgressErrorStateType.submitted,
  );
  final String mobileNumber;
}
