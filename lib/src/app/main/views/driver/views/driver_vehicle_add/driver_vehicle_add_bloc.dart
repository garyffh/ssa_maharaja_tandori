import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';

import 'driver_vehicle_add_event.dart';
import 'driver_vehicle_add_state.dart';

class DriverVehicleAddBloc
    extends Bloc<DriverVehicleAddEvent, DriverVehicleAddState> {
  DriverVehicleAddBloc({
    required this.driverRepo,
    required this.driverNavCubit,
  }) : super(const DriverVehicleAddStateIdle()) {
    on<DriverVehicleAddEventSubmit>((event, emit) async {
      try {
        emit(const DriverVehicleAddStateProgressError());

        await driverRepo.addDriverVehicle(content: event.driverVehicle);

        emit(const DriverVehicleAddStateSubmitted());

        driverNavCubit.showVehicles();
      } catch (e) {
        emit(DriverVehicleAddStateProgressError(error: e));
      }
    });

    on<DriverVehicleAddEventResetError>((event, emit) async {
      emit(const DriverVehicleAddStateIdle());
    });
  }

  final DriverRepo driverRepo;
  final DriverNavCubit driverNavCubit;
}
