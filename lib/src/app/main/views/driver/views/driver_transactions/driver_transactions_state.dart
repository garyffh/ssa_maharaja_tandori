import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/driver_transaction.dart';

@immutable
abstract class DriverTransactionsState extends ProgressErrorState {
  const DriverTransactionsState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverTransactionsStateInitial extends DriverTransactionsState {
  const DriverTransactionsStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverTransactionsStateLoadingError extends DriverTransactionsState {
  const DriverTransactionsStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

class DriverTransactionsStateViewModel extends DriverTransactionsState {
  const DriverTransactionsStateViewModel({
    required this.driverTransactions,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  final List<DriverTransaction> driverTransactions;
}
