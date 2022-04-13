import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';

@immutable
abstract class CheckoutCompleteState extends ProgressErrorState {
  const CheckoutCompleteState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class CheckoutCompleteStateInitial extends CheckoutCompleteState {
  const CheckoutCompleteStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class CheckoutCompleteStateViewModel extends CheckoutCompleteState {
  const CheckoutCompleteStateViewModel({
    required this.trnOrder,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final TrnOrder trnOrder;
}
