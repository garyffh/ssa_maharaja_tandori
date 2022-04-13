import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';

abstract class DriverVehiclesEvent {}

class DriverVehiclesEventGetViewModel extends DriverVehiclesEvent {
  DriverVehiclesEventGetViewModel();
}

class DriverVehiclesEventSetDefault extends DriverVehiclesEvent {
  DriverVehiclesEventSetDefault({
    required this.driverVehicle,
  });

  final DriverVehicle driverVehicle;
}

class DriverVehiclesEventDelete extends DriverVehiclesEvent {
  DriverVehiclesEventDelete({
    required this.driverVehicle,
  });

  final DriverVehicle driverVehicle;
}

