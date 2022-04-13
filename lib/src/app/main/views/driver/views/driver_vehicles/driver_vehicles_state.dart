import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';

@immutable
abstract class DriverVehiclesState extends ProgressErrorState {
  const DriverVehiclesState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverVehiclesStateInitial extends DriverVehiclesState {
  const DriverVehiclesStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverVehiclesStateLoadingError extends DriverVehiclesState {
  const DriverVehiclesStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class DriverVehiclesStateProgressError extends DriverVehiclesState {
  const DriverVehiclesStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

class DriverVehiclesStateViewModel extends DriverVehiclesState {
  const DriverVehiclesStateViewModel({
    required this.driverVehicles,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final List<DriverVehicle> driverVehicles;
}
