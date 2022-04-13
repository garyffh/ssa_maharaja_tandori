import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_update.dart';
import 'package:single_store_app/src/app/services/app_audio/app_audio_state.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_state.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

import 'trn_order_messaging_event.dart';
import 'trn_order_messaging_state.dart';

class TrnOrderMessagingBloc
    extends Bloc<TrnOrderMessagingStateEvent, TrnOrderMessagingState> {
  TrnOrderMessagingBloc({
    required AppMessagingCubit appMessagingCubit,
    required this.businessSettingsBloc,
    required this.appSnackBarCubit,
  }) : super(const TrnOrderMessagingState()) {
    on<TrnOrderMessagingStateEvent>((event, emit) async {
      try {
        switch (event.trnOrderUpdate.method) {
          case 'TrnOrderPrepareUpdateDriver': //
          case 'TrnOrderDispatchUpdateDriver':
          case 'TrnOrderCancelUpdateDriver':
            {
              await appSnackBarCubit.showSnackBar(
                  snackBar: SnackBar(
                      content: Text(
                _driverStateMessage(event.trnOrderUpdate),
              )));

              break;
            }

          case 'TrnOrderDispatchUpdateUser':
          case 'TrnOrderCancelUpdateUser':
          case 'TrnOrderDriveUpdateUser':
          case 'TrnOrderDeliveryUpdateUser':
            {
              await appSnackBarCubit.showSnackBar(
                  snackBar: SnackBar(
                      content: Text(
                _userStateMessage(event.trnOrderUpdate),
              )));

              break;
            }

          case 'TrnOrderQueueUpdateUser':
            {
              break;
            }

          case 'TrnOrderPickupUpdateUser':
            {
              await appSnackBarCubit.showSnackBar(
                  appSound: AppSound.userPickup,
                  snackBar: SnackBar(
                      content: Text(
                    _userStateMessage(event.trnOrderUpdate),
                  )));

              break;
            }
        }

        emit(TrnOrderMessagingState(
          trnOrderUpdate: event.trnOrderUpdate,
        ));
      } catch (_) {
        // ignore error
      }
    });

    appMessagingCubitSubscription =
        appMessagingCubit.stream.listen((trnOrderMessagingState) {
      if (trnOrderMessagingState is AppMessagingTrnOrderUpdate) {
        try {
          final TrnOrderUpdate trnOrderUpdate =
              TrnOrderUpdate.fromJson(trnOrderMessagingState.data);

          add(TrnOrderMessagingStateEvent(
            trnOrderUpdate: trnOrderUpdate,
          ));
        } catch (_) {
          //ignore error
        }
      }
    });
  }

  late StreamSubscription appMessagingCubitSubscription;
  final BusinessSettingsBloc businessSettingsBloc;
  final AppSnackBarCubit appSnackBarCubit;

  String get businessName =>
      (businessSettingsBloc.state as BusinessSettingsStateLoaded).businessName;

  String _userStateMessage(TrnOrderUpdate trnOrderUpdate) {
    switch (trnOrderUpdate.orderDeliveryMethodStatus) {
      case TrnOrderDeliveryMethodStatus.scheduled:
        return 'Your order has been scheduled';

      case TrnOrderDeliveryMethodStatus.preparing:
        return 'Your order is being prepared';

      case TrnOrderDeliveryMethodStatus.readyForPickup:
        return 'Your order is ready to be picked up';

      case TrnOrderDeliveryMethodStatus.delivering:
        return 'Your order is being delivered';

      case TrnOrderDeliveryMethodStatus.completed:
        return 'Your order is complete';

      case TrnOrderDeliveryMethodStatus.cancelled:
        return 'Your order has been cancelled';
    }
  }

  String _driverStateMessage(TrnOrderUpdate trnOrderUpdate) {
    switch (trnOrderUpdate.orderStoreStatus) {
      case TrnOrderStoreStatus.scheduled:
        return '$businessName delivery has been scheduled';

      case TrnOrderStoreStatus.noDriver:
        return '$businessName delivery has no driver';

      case TrnOrderStoreStatus.queued:
        return '$businessName delivery has been queued';

      case TrnOrderStoreStatus.preparing:
        return '$businessName delivery is being prepared';

      case TrnOrderStoreStatus.waitingForPickup:
        return '$businessName order is ready for pickup';

      case TrnOrderStoreStatus.waitingForDelivery:
        return '$businessName delivery is ready for pickup';

      case TrnOrderStoreStatus.delivering:
        return 'Delivering $businessName order';

      case TrnOrderStoreStatus.completed:
        return '$businessName delivery has been completed';

      case TrnOrderStoreStatus.cancelled:
        return '$businessName delivery has been cancelled';
    }
  }

  @override
  Future<void> close() {
    appMessagingCubitSubscription.cancel();
    return super.close();
  }
}
