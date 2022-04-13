import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';

import 'driver_vehicles_event.dart';
import 'driver_vehicles_state.dart';

class DriverVehiclesBloc
    extends Bloc<DriverVehiclesEvent, DriverVehiclesState> {
  DriverVehiclesBloc({
    required this.driverRepo,
  }) : super(const DriverVehiclesStateInitial()) {
    on<DriverVehiclesEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverVehiclesStateLoadingError());

        emit(DriverVehiclesStateViewModel(
          driverVehicles: await driverRepo.readDriverVehicles(),
        ));
      } catch (e) {
        emit(DriverVehiclesStateLoadingError(error: e));
      }
    });

    on<DriverVehiclesEventSetDefault>((event, emit) async {
      try {
        emit(const DriverVehiclesStateProgressError());

        await driverRepo.currentDriverVehicle(
            content: DriverVehicle.updateCurrentCar(
                currentCar: true, driverVehicle: event.driverVehicle));

        emit(DriverVehiclesStateViewModel(
          driverVehicles: await driverRepo.readDriverVehicles(),
        ));
      } catch (e) {
        emit(DriverVehiclesStateProgressError(error: e));
      }
    });

    on<DriverVehiclesEventDelete>((event, emit) async {
      try {
        emit(const DriverVehiclesStateProgressError());

        await driverRepo.deleteDriverVehicle(content: event.driverVehicle);

        emit(DriverVehiclesStateViewModel(
          driverVehicles: await driverRepo.readDriverVehicles(),
        ));
      } catch (e) {
        emit(DriverVehiclesStateProgressError(error: e));
      }
    });
  }

  final DriverRepo driverRepo;
}
