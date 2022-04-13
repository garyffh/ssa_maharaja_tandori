import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';

import 'driver_deliveries_event.dart';
import 'driver_deliveries_state.dart';

class DriverDeliveriesBloc
    extends Bloc<DriverDeliveriesEvent, DriverDeliveriesState> {
  DriverDeliveriesBloc({
    required this.driverRepo,
    required AppMessagingCubit appMessagingCubit,
    required TrnOrderMessagingBloc trnOrderMessagingBloc,
  }) : super(const DriverDeliveriesStateInitial()) {
    on<DriverDeliveriesEventGetViewModel>((event, emit) async {

      try {
        emit(const DriverDeliveriesStateLoadingError());

        emit(DriverDeliveriesStateViewModel(
          driverDeliveries: await driverRepo.getDriverDeliveries(),
        ));
      } catch (e) {
        emit(DriverDeliveriesStateLoadingError(error: e));
      }
    });

    on<DriverDeliveriesEventDisableDeliveries>((event, emit) async {

      try {

        emit(const DriverDeliveriesStateProgressError());

        await driverRepo.disableDeliveries();

        emit(DriverDeliveriesStateViewModel(
          driverDeliveries: await driverRepo.getDriverDeliveries(),
        ));
      } catch (e) {
        emit(DriverDeliveriesStateProgressError(error: e));
      }
    });

    appMessagingCubitSubscription =
        appMessagingCubit.stream.listen((appMessagingState) {
      if (appMessagingState.method == 'TrnOrderAllocateDriverDriver') {
        // new delivery allocated
        add(DriverDeliveriesEventGetViewModel());
      }
    });

    trnOrderMessagingBlocSubscription =
        trnOrderMessagingBloc.stream.listen((trnOrderMessagingState) {
      if (trnOrderMessagingState.trnOrderUpdate != null) {
        if (trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderPrepareUpdateDriver' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderDispatchUpdateDriver' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderCancelUpdateDriver') {
          // could be more refined at updating the view
          add(DriverDeliveriesEventGetViewModel());
        }
      }
    });
  }

  final DriverRepo driverRepo;
  late StreamSubscription appMessagingCubitSubscription;
  late StreamSubscription trnOrderMessagingBlocSubscription;

  @override
  Future<void> close() {
    appMessagingCubitSubscription.cancel();
    trnOrderMessagingBlocSubscription.cancel();
    return super.close();
  }
}
