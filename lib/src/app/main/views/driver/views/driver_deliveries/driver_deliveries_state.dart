import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/driver_deliveries.dart';

@immutable
abstract class DriverDeliveriesState extends ProgressErrorState {
  const DriverDeliveriesState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverDeliveriesStateInitial extends DriverDeliveriesState {
  const DriverDeliveriesStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverDeliveriesStateLoadingError extends DriverDeliveriesState {
  const DriverDeliveriesStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

class DriverDeliveriesStateProgressError extends DriverDeliveriesState {
  const DriverDeliveriesStateProgressError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.progressError,
    error: error,
  );
}

class DriverDeliveriesStateViewModel extends DriverDeliveriesState {
  const DriverDeliveriesStateViewModel({
    required this.driverDeliveries,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final DriverDeliveries driverDeliveries;
}
