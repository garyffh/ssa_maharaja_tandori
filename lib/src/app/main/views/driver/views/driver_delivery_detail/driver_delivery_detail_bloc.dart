import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery_action.dart';

import 'driver_delivery_detail_event.dart';
import 'driver_delivery_detail_state.dart';

class DriverDeliveryDetailBloc
    extends Bloc<DriverDeliveryDetailEvent, DriverDeliveryDetailState> {
  DriverDeliveryDetailBloc({
    required this.driverRepo,
    required this.driverNavCubit,
    required TrnOrderMessagingBloc trnOrderMessagingBloc,
  }) : super(const DriverDeliveryDetailStateInitial()) {
    on<DriverDeliveryDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverDeliveryDetailStateLoadingError());

        final TrnDelivery trnDelivery =
            await driverRepo.findDriverDelivery(event.trnOrderId);

        emit(DriverDeliveryDetailStateViewLoaded(trnDelivery: trnDelivery));
      } catch (e) {
        emit(DriverDeliveryDetailStateLoadingError(error: e));
      }
    });

    on<DriverDeliveryDetailEventPickedUp>((event, emit) async {
      if (state is DriverDeliveryDetailStateViewModel) {
        final TrnDelivery trnDelivery =
            (state as DriverDeliveryDetailStateViewModel).trnDelivery;

        try {
          emit(DriverDeliveryDetailStateProgressError(
            trnDelivery: trnDelivery,
          ));

          final TrnDeliveryAction trnDeliveryAction =
              await driverRepo.deliveryPickedUp(event.trnOrderId);

          emit(DriverDeliveryDetailStateViewLoaded(
            trnDelivery: TrnDelivery.updateStatus(
              storeStatus: trnDeliveryAction.storeStatus,
              deliveryMethodStatus: trnDeliveryAction.deliveryMethodStatus,
              trnDelivery: trnDelivery,
            ),
          ));
        } catch (e) {
          emit(DriverDeliveryDetailStateProgressError(
              trnDelivery: trnDelivery, error: e));
        }
      } else {
        emit(DriverDeliveryDetailStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<DriverDeliveryDetailEventDelivered>((event, emit) async {
      if (state is DriverDeliveryDetailStateViewModel) {
        final TrnDelivery trnDelivery =
            (state as DriverDeliveryDetailStateViewModel).trnDelivery;

        try {
          emit(DriverDeliveryDetailStateProgressError(
            trnDelivery: trnDelivery,
          ));

          final TrnDeliveryAction trnDeliveryAction =
              await driverRepo.deliveryDelivered(event.trnOrderId);

          driverNavCubit.showDeliveries();

          emit(DriverDeliveryDetailStateViewLoaded(
            trnDelivery: TrnDelivery.updateStatus(
              storeStatus: trnDeliveryAction.storeStatus,
              deliveryMethodStatus: trnDeliveryAction.deliveryMethodStatus,
              trnDelivery: trnDelivery,
            ),
          ));
        } catch (e) {
          emit(DriverDeliveryDetailStateProgressError(
              trnDelivery: trnDelivery, error: e));
        }
      } else {
        emit(DriverDeliveryDetailStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<DriverDeliveryDetailEventOrderUpdate>((event, emit) async {
      try {
        if (state is DriverDeliveryDetailStateViewModel) {
          final TrnDelivery trnDelivery =
              (state as DriverDeliveryDetailStateViewModel).trnDelivery;

          if (trnDelivery.trnOrderId == event.trnOrderId) {
            emit(DriverDeliveryDetailStateViewLoaded(
              trnDelivery: TrnDelivery.updateStatus(
                storeStatus: event.trnOrderUpdate.orderStoreStatus,
                deliveryMethodStatus:
                    event.trnOrderUpdate.orderDeliveryMethodStatus,
                trnDelivery: trnDelivery,
              ),
            ));
          }
        }
      } catch (_) {}
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
          if (state is DriverDeliveryDetailStateViewLoaded) {
            final DriverDeliveryDetailStateViewLoaded
                driverDeliveryDetailStateViewLoaded =
                state as DriverDeliveryDetailStateViewLoaded;
            if (trnOrderMessagingState.trnOrderUpdate!.trnOrderId ==
                driverDeliveryDetailStateViewLoaded.trnDelivery.trnOrderId) {
              add(DriverDeliveryDetailEventOrderUpdate(
                  trnOrderId: trnOrderMessagingState.trnOrderUpdate!.trnOrderId,
                  trnOrderUpdate: trnOrderMessagingState.trnOrderUpdate!));
            }
          }
        }
      }
    });
  }

  final DriverRepo driverRepo;
  final DriverNavCubit driverNavCubit;
  late StreamSubscription trnOrderMessagingBlocSubscription;

  @override
  Future<void> close() {
    trnOrderMessagingBlocSubscription.cancel();
    return super.close();
  }
}
