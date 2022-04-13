import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/user/payment_detail.dart';

@immutable
abstract class PaymentDetailState extends ProgressErrorState {
  const PaymentDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PaymentDetailStateInitial extends PaymentDetailState {
  const PaymentDetailStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class PaymentDetailStateLoadingError extends PaymentDetailState {
  const PaymentDetailStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class PaymentDetailStateViewModel extends PaymentDetailState {
  const PaymentDetailStateViewModel({
    required this.paymentDetail,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final PaymentDetail paymentDetail;
}
