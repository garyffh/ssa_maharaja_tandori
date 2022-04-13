import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class PhoneUpdateWidgetState extends ProgressViewState {
  const PhoneUpdateWidgetState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PhoneUpdateWidgetStateIdle extends PhoneUpdateWidgetState {
  const PhoneUpdateWidgetStateIdle()
      : super(
    type: ProgressErrorStateType.idle,
  );
}

class PhoneUpdateWidgetStateProgressError extends PhoneUpdateWidgetState {
  const PhoneUpdateWidgetStateProgressError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

class PhoneUpdateWidgetStateSubmitted extends PhoneUpdateWidgetState {
  const PhoneUpdateWidgetStateSubmitted({
    required this.mobileNumber,
}) : super(
    type: ProgressErrorStateType.submitted,
  );
  final String mobileNumber;
}

