import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class DriverVehicleAddState extends ProgressViewState {
  const DriverVehicleAddState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverVehicleAddStateIdle extends DriverVehicleAddState {
  const DriverVehicleAddStateIdle()
      : super(
          type: ProgressErrorStateType.idle,
        );
}

class DriverVehicleAddStateProgressError extends DriverVehicleAddState {
  const DriverVehicleAddStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

class DriverVehicleAddStateSubmitted extends DriverVehicleAddState {
  const DriverVehicleAddStateSubmitted()
      : super(
          type: ProgressErrorStateType.submitted,
        );
}
