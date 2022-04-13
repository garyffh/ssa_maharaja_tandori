import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order_read.dart';

@immutable
abstract class OrdersState extends ProgressErrorState {
  const OrdersState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class OrdersStateInitial extends OrdersState {
  const OrdersStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class OrdersStateLoadingError extends OrdersState {
  const OrdersStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class OrdersStateViewModel extends OrdersState {
  const OrdersStateViewModel({
    required this.trnOrders,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final List<TrnOrderRead> trnOrders;
}
