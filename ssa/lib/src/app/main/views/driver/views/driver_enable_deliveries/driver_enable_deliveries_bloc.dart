import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/driver/driver_enable_deliveries.dart';

import 'driver_enable_deliveries_event.dart';
import 'driver_enable_deliveries_state.dart';

class DriverEnableDeliveriesBloc
    extends Bloc<DriverEnableDeliveriesEvent, DriverEnableDeliveriesState> {
  DriverEnableDeliveriesBloc({
    required this.driverRepo,
    required this.driverNavCubit,
  }) : super(const DriverEnableDeliveriesStateInitial()) {
    on<DriverEnableDeliveriesEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverEnableDeliveriesStateLoadingError());

        emit(DriverEnableDeliveriesStateViewLoaded(
          driverEnableDeliveries: await driverRepo.findDriverEnableDeliveries(),
        ));
      } catch (e) {
        emit(DriverEnableDeliveriesStateLoadingError(error: e));
      }
    });

    on<DriverEnableDeliveriesEventResetError>((event, emit) async {
      try {
        emit(const DriverEnableDeliveriesStateLoadingError());

        emit(DriverEnableDeliveriesStateViewLoaded(
          driverEnableDeliveries: await driverRepo.findDriverEnableDeliveries(),
        ));
      } catch (e) {
        emit(DriverEnableDeliveriesStateLoadingError(error: e));
      }
    });

    on<DriverEnableDeliveriesEventSubmit>((event, emit) async {
      if (state is DriverEnableDeliveriesStateViewModel) {
        final DriverEnableDeliveries driverEnableDeliveries =
            (state as DriverEnableDeliveriesStateViewModel)
                .driverEnableDeliveries;

        try {
          emit(DriverEnableDeliveriesStateProgressError(
            driverEnableDeliveries: driverEnableDeliveries,
          ));

          await driverRepo.enableDeliveries();

          emit(DriverEnableDeliveriesStateViewSubmitted(
            driverEnableDeliveries: driverEnableDeliveries,
          ));

          driverNavCubit.showDeliveries();
        } catch (e) {
          emit(DriverEnableDeliveriesStateProgressError(
            driverEnableDeliveries: driverEnableDeliveries,
            error: e,
          ));
        }
      } else {
        emit(DriverEnableDeliveriesStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final DriverRepo driverRepo;
  final DriverNavCubit driverNavCubit;
}
