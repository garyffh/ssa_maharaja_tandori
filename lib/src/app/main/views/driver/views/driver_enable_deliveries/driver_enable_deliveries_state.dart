import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';
import 'package:single_store_app/src/app/models/driver/driver_enable_deliveries.dart';

@immutable
abstract class DriverEnableDeliveriesState extends ProgressViewState {
  const DriverEnableDeliveriesState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);

  @override
  bool get inProgress =>
      (type == ProgressErrorStateType.progressError ||
          type == ProgressErrorStateType.loadingError ||
          type == ProgressErrorStateType.submitted ||
          type == ProgressErrorStateType.initial) &&
      error == null;
}

class DriverEnableDeliveriesStateInitial extends DriverEnableDeliveriesState {
  const DriverEnableDeliveriesStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverEnableDeliveriesStateLoadingError
    extends DriverEnableDeliveriesState {
  const DriverEnableDeliveriesStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

abstract class DriverEnableDeliveriesStateViewModel extends DriverEnableDeliveriesState {
  const DriverEnableDeliveriesStateViewModel({
    required this.driverEnableDeliveries,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
          error: error,
          type: type,
        );

  final DriverEnableDeliveries driverEnableDeliveries;
}

class DriverEnableDeliveriesStateProgressError
    extends DriverEnableDeliveriesStateViewModel {
  const DriverEnableDeliveriesStateProgressError({
    required DriverEnableDeliveries driverEnableDeliveries,
    dynamic error,
  }) : super(
          driverEnableDeliveries: driverEnableDeliveries,
          error: error,
          type: ProgressErrorStateType.progressError,
        );
}

class DriverEnableDeliveriesStateViewLoaded
    extends DriverEnableDeliveriesStateViewModel {
  const DriverEnableDeliveriesStateViewLoaded({
    required DriverEnableDeliveries driverEnableDeliveries,
  }) : super(
          driverEnableDeliveries: driverEnableDeliveries,
          type: ProgressErrorStateType.loaded,
        );
}

class DriverEnableDeliveriesStateViewSubmitted
    extends DriverEnableDeliveriesStateViewModel {
  const DriverEnableDeliveriesStateViewSubmitted({
    required DriverEnableDeliveries driverEnableDeliveries,
  }) : super(
          driverEnableDeliveries: driverEnableDeliveries,
          type: ProgressErrorStateType.submitted,
        );
}
