import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/orders_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';

import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required this.ordersRepo,
    required TrnOrderMessagingBloc trnOrderMessagingBloc,
  }) : super(const OrdersStateInitial()) {
    on<OrdersEventGetViewModel>((event, emit) async {
      try {
        emit(const OrdersStateLoadingError());

        emit(OrdersStateViewModel(
          trnOrders: await ordersRepo.readTrnOrders(),
        ));
      } catch (e) {
        emit(OrdersStateLoadingError(error: e));
      }
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
          // could be more refined at updating the view
          add(OrdersEventGetViewModel());
        }
      }
    });
  }

  final OrdersRepo ordersRepo;
  late StreamSubscription trnOrderMessagingBlocSubscription;

  @override
  Future<void> close() {
    trnOrderMessagingBlocSubscription.cancel();
    return super.close();
  }
}
