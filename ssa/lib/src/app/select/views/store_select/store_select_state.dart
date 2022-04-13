import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/multi_store/multi_store_settings.dart';


@immutable
abstract class StoreSelectState extends ProgressErrorState {
  const StoreSelectState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class StoreSelectStateInitial extends StoreSelectState {
  const StoreSelectStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class StoreSelectStateLoadingError extends StoreSelectState {
  const StoreSelectStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );

  StoreSelectStateLoadingError.fromUnexpectedState() : super(
    type: ProgressErrorStateType.loadingError,
    error: AppException.fromString(unexpectedBlocState),
  );

}

class StoreSelectStateProgressError extends StoreSelectState {
  const StoreSelectStateProgressError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

class StoreSelectStateViewModel extends StoreSelectState {
  const StoreSelectStateViewModel({
    required this.multiStoreSettings,
}) : super(
    type: ProgressErrorStateType.loaded,
  );

  final MultiStoreSettings multiStoreSettings;
}
