import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

@immutable
abstract class AppFirebaseState extends ProgressErrorState {
  const AppFirebaseState({
    required ProgressErrorStateType type,
    dynamic error,
    required this.enabled,
    required this.initialised,
  }) : super(type: type, error: error);

  final bool enabled;
  final bool initialised;
}

class AppFirebaseStateInitial extends AppFirebaseState {
  const AppFirebaseStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
          enabled: false,
          initialised: false,
        );
}

class AppFirebaseStateProgressError extends AppFirebaseState {
  const AppFirebaseStateProgressError({dynamic error})
      : super(
          type: ProgressErrorStateType.progressError,
          error: error,
          enabled: false,
          initialised: false,
        );
}

class AppAppFirebaseStateDisabled extends AppFirebaseState {
  const AppAppFirebaseStateDisabled()
      : super(
          type: ProgressErrorStateType.loaded,
          enabled: false,
          initialised: true,
        );
}

class AppFirebaseStateEnabled extends AppFirebaseState {
  const AppFirebaseStateEnabled()
      : super(
          type: ProgressErrorStateType.loaded,
          enabled: true,
          initialised: true,
        );
}
