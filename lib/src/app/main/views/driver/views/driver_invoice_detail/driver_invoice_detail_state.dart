import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/driver_invoice.dart';

@immutable
abstract class DriverInvoiceDetailState extends ProgressErrorState {
  const DriverInvoiceDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverInvoiceDetailStateInitial extends DriverInvoiceDetailState {
  const DriverInvoiceDetailStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverInvoiceDetailStateLoadingError extends DriverInvoiceDetailState {
  const DriverInvoiceDetailStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

class DriverInvoiceDetailStateViewModel extends DriverInvoiceDetailState {
  const DriverInvoiceDetailStateViewModel({
    required this.driverInvoice,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final DriverInvoice driverInvoice;
}
