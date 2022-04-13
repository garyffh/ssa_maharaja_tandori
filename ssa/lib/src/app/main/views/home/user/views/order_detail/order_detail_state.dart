import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';

@immutable
abstract class OrderDetailState extends ProgressErrorState {
  const OrderDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class OrderDetailStateInitial extends OrderDetailState {
  const OrderDetailStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class OrderDetailStateLoadingError extends OrderDetailState {
  const OrderDetailStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class OrderDetailStateViewModel extends OrderDetailState {
  const OrderDetailStateViewModel({
    required this.trnOrder,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final TrnOrder trnOrder;
}
