import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/orders_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/models/order/trn_order_driver.dart';
import 'package:single_store_app/src/app/models/order/trn_order_user_allocate_driver.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_state.dart';

import 'order_detail_event.dart';
import 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({
    required this.ordersRepo,
    required TrnOrderMessagingBloc trnOrderMessagingBloc,
    required AppMessagingCubit appMessagingCubit,
  }) : super(const OrderDetailStateInitial()) {
    on<OrderDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const OrderDetailStateLoadingError());

        emit(OrderDetailStateViewModel(
          trnOrder: await ordersRepo.findTrnOrder(
            event.trnOrderId,
          ),
        ));
      } catch (e) {
        emit(OrderDetailStateLoadingError(error: e));
      }
    });

    on<OrderDetailEventOrderUpdate>((event, emit) async {
      try {
        if (state is OrderDetailStateViewModel) {
          final TrnOrder trnOrder =
              (state as OrderDetailStateViewModel).trnOrder;

          if (trnOrder.trnOrderId == event.trnOrderId) {
            emit(OrderDetailStateViewModel(
                trnOrder: TrnOrder.updateStatus(
              storeStatus: event.trnOrderUpdate.orderStoreStatus,
              deliveryMethodStatus:
                  event.trnOrderUpdate.orderDeliveryMethodStatus,
              trnOrder: trnOrder,
            )));
          }
        }
      } catch (_) {}
    });

    on<OrderDetailEventOrderDriverUpdate>((event, emit) async {
      try {
        if (state is OrderDetailStateViewModel) {
          final TrnOrder trnOrder =
              (state as OrderDetailStateViewModel).trnOrder;

          if (trnOrder.trnOrderId == event.trnOrderId) {
            emit(OrderDetailStateViewModel(
              trnOrder: TrnOrder.updateDriver(
                deliveryMethodStatus:
                    event.trnOrderUserAllocateDriver.orderDeliveryMethodStatus,
                driver: TrnOrderDriver(
                  make: event.trnOrderUserAllocateDriver.make,
                  plate: event.trnOrderUserAllocateDriver.plate,
                  model: event.trnOrderUserAllocateDriver.model,
                  colour: event.trnOrderUserAllocateDriver.colour,
                ),
                trnOrder: trnOrder,
              ),
            ));
          }
        }
      } catch (_) {}
    });

    trnOrderMessagingBlocSubscription =
        trnOrderMessagingBloc.stream.listen((trnOrderMessagingState) {
      if (trnOrderMessagingState.trnOrderUpdate != null) {
        if (trnOrderMessagingState.trnOrderUpdate!.method == 'TrnOrderDispatchUpdateUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderPickupUpdateUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderCancelUpdateUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderAllocateDriverUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderDriveUpdateUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderDeliveryUpdateUser' ||
            trnOrderMessagingState.trnOrderUpdate!.method ==
                'TrnOrderQueueUpdateUser') {
          if (state is OrderDetailStateViewModel) {
            final OrderDetailStateViewModel orderDetailStateViewModel =
                state as OrderDetailStateViewModel;
            if (trnOrderMessagingState.trnOrderUpdate!.trnOrderId ==
                orderDetailStateViewModel.trnOrder.trnOrderId) {
              add(OrderDetailEventOrderUpdate(
                  trnOrderId: trnOrderMessagingState.trnOrderUpdate!.trnOrderId,
                  trnOrderUpdate: trnOrderMessagingState.trnOrderUpdate!));
            }
          }
        }
      }
    });

    appMessagingCubitSubscription = appMessagingCubit.stream
        .listen((appMessagingTrnOrderUserAllocateDriver) {
      if (state is OrderDetailStateViewModel) {
        final OrderDetailStateViewModel orderDetailStateViewModel =
            state as OrderDetailStateViewModel;

        if (appMessagingTrnOrderUserAllocateDriver
            is AppMessagingTrnOrderUserAllocateDriver) {
          try {
            final TrnOrderUserAllocateDriver trnOrderUserAllocateDriver =
                TrnOrderUserAllocateDriver.fromJson(
                    appMessagingTrnOrderUserAllocateDriver.data);

            if (trnOrderUserAllocateDriver.trnOrderId ==
                orderDetailStateViewModel.trnOrder.trnOrderId) {
              add(OrderDetailEventOrderDriverUpdate(
                trnOrderId: orderDetailStateViewModel.trnOrder.trnOrderId,
                trnOrderUserAllocateDriver: trnOrderUserAllocateDriver,
              ));
            }
          } catch (_) {
            //ignore error
          }
        }
      }
    });
  }

  final OrdersRepo ordersRepo;
  late StreamSubscription trnOrderMessagingBlocSubscription;
  late StreamSubscription appMessagingCubitSubscription;

  @override
  Future<void> close() {
    trnOrderMessagingBlocSubscription.cancel();
    appMessagingCubitSubscription.cancel();
    return super.close();
  }
}
