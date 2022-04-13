import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/driver_payment.dart';

@immutable
abstract class DriverPaymentDetailState extends ProgressErrorState {
  const DriverPaymentDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverPaymentDetailStateInitial extends DriverPaymentDetailState {
  const DriverPaymentDetailStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverPaymentDetailStateLoadingError extends DriverPaymentDetailState {
  const DriverPaymentDetailStateLoadingError({dynamic error})
      : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

class DriverPaymentDetailStateViewModel extends DriverPaymentDetailState {
  const DriverPaymentDetailStateViewModel({
    required this.driverPayment,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final DriverPayment driverPayment;
}
