import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_event.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/models/order/trn_order_driver.dart';
import 'package:single_store_app/src/app/models/order/trn_order_user_allocate_driver.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_state.dart';

import 'checkout_complete_event.dart';
import 'checkout_complete_state.dart';

class CheckoutCompleteBloc
    extends Bloc<CheckoutCompleteEvent, CheckoutCompleteState> {
  CheckoutCompleteBloc({
    required TrnOrderMessagingBloc trnOrderMessagingBloc,
    required AppMessagingCubit appMessagingCubit,
    required this.cartBloc,
  }) : super(const CheckoutCompleteStateInitial()) {
    on<CheckoutCompleteEventGetViewModel>((event, emit) async {

      cartBloc.add(CartEventReset());

      emit(CheckoutCompleteStateViewModel(
        trnOrder: event.trnOrder,
      ));
    });

    on<CheckoutCompleteEventUpdate>((event, emit) async {
      try {
        if (state is CheckoutCompleteStateViewModel) {
          final CheckoutCompleteStateViewModel checkoutCompleteStateViewModel =
              state as CheckoutCompleteStateViewModel;

          if (checkoutCompleteStateViewModel.trnOrder.trnOrderId == event.trnOrderId) {
            emit(CheckoutCompleteStateViewModel(
                trnOrder: TrnOrder.updateStatus(
              storeStatus: event.trnOrderUpdate.orderStoreStatus,
              deliveryMethodStatus:
                  event.trnOrderUpdate.orderDeliveryMethodStatus,
              trnOrder: checkoutCompleteStateViewModel.trnOrder,
            )));
          }
        }
      } catch (_) {}
    });

    on<CheckoutCompleteEventDriverUpdate>((event, emit) async {
      try {
        if (state is CheckoutCompleteEventGetViewModel) {
          final CheckoutCompleteEventGetViewModel checkoutCompleteEventGetViewModel =
              state as CheckoutCompleteEventGetViewModel;

          if (checkoutCompleteEventGetViewModel.trnOrder.trnOrderId == event.trnOrderId) {
            emit(CheckoutCompleteStateViewModel(
              trnOrder: TrnOrder.updateDriver(
                deliveryMethodStatus:
                    event.trnOrderUserAllocateDriver.orderDeliveryMethodStatus,
                driver: TrnOrderDriver(
                  make: event.trnOrderUserAllocateDriver.make,
                  plate: event.trnOrderUserAllocateDriver.plate,
                  model: event.trnOrderUserAllocateDriver.model,
                  colour: event.trnOrderUserAllocateDriver.colour,
                ),
                trnOrder: checkoutCompleteEventGetViewModel.trnOrder,
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
          if (state is CheckoutCompleteStateViewModel) {
            final CheckoutCompleteStateViewModel checkoutOrderStateViewModel =
                state as CheckoutCompleteStateViewModel;
            if (trnOrderMessagingState.trnOrderUpdate!.trnOrderId ==
                checkoutOrderStateViewModel.trnOrder.trnOrderId) {
              add(CheckoutCompleteEventUpdate(
                  trnOrderId: trnOrderMessagingState.trnOrderUpdate!.trnOrderId,
                  trnOrderUpdate: trnOrderMessagingState.trnOrderUpdate!));
            }
          }
        }
      }
    });

    appMessagingCubitSubscription = appMessagingCubit.stream
        .listen((appMessagingTrnOrderUserAllocateDriver) {
      if (state is CheckoutCompleteStateViewModel) {
        final CheckoutCompleteStateViewModel checkoutOrderStateViewModel =
            state as CheckoutCompleteStateViewModel;

        if (appMessagingTrnOrderUserAllocateDriver
            is AppMessagingTrnOrderUserAllocateDriver) {
          try {
            final TrnOrderUserAllocateDriver trnOrderUserAllocateDriver =
                TrnOrderUserAllocateDriver.fromJson(
                    appMessagingTrnOrderUserAllocateDriver.data);

            if (trnOrderUserAllocateDriver.trnOrderId ==
                checkoutOrderStateViewModel.trnOrder.trnOrderId) {
              add(CheckoutCompleteEventDriverUpdate(
                trnOrderId: checkoutOrderStateViewModel.trnOrder.trnOrderId,
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

  final CartBloc cartBloc;

  late StreamSubscription trnOrderMessagingBlocSubscription;
  late StreamSubscription appMessagingCubitSubscription;

  @override
  Future<void> close() {
    trnOrderMessagingBlocSubscription.cancel();
    appMessagingCubitSubscription.cancel();
    return super.close();
  }
}
