import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';

abstract class DriverVehicleAddEvent {}

class DriverVehicleAddEventSubmit extends DriverVehicleAddEvent {
  DriverVehicleAddEventSubmit({
    required this.driverVehicle,
  });

  final DriverVehicle driverVehicle;
}

class DriverVehicleAddEventResetError extends DriverVehicleAddEvent {
  DriverVehicleAddEventResetError();
}
