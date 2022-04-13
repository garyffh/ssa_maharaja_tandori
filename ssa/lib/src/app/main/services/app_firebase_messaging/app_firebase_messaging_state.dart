import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

@immutable
abstract class AppFirebaseMessagingState extends ProgressErrorState {
  const AppFirebaseMessagingState({
    required ProgressErrorStateType type,
    dynamic error,
    required this.enabled,
  }) : super(type: type, error: error);

  final bool enabled;
}

class AppFirebaseMessagingStateInitial extends AppFirebaseMessagingState {
  const AppFirebaseMessagingStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
          enabled: false,
        );
}

class AppFirebaseMessagingStateProgressError extends AppFirebaseMessagingState {
  const AppFirebaseMessagingStateProgressError({dynamic error})
      : super(
          type: ProgressErrorStateType.progressError,
          error: error,
          enabled: false,
        );
}

class AppAppFirebaseMessagingStateDisabled extends AppFirebaseMessagingState {
  const AppAppFirebaseMessagingStateDisabled()
      : super(
          type: ProgressErrorStateType.loaded,
          enabled: false,
        );
}

class AppFirebaseMessagingStateEnabled extends AppFirebaseMessagingState {
  const AppFirebaseMessagingStateEnabled({
    required this.token,
    required this.deviceUpdateSent,
  }) : super(
          type: ProgressErrorStateType.loaded,
          enabled: true,
        );

  final String token;
  final bool deviceUpdateSent;
}
