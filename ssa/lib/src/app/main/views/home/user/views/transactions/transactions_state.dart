import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/user/user_transaction.dart';

@immutable
abstract class TransactionsState extends ProgressErrorState {
  const TransactionsState({
    required ProgressErrorStateType type,
    dynamic error,
    required this.showPayments,
  }) : super(type: type, error: error);
  final bool showPayments;
}

class TransactionsStateInitial extends TransactionsState {
  const TransactionsStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
    showPayments: false,
        );
}

class TransactionsStateLoadingError extends TransactionsState {
  const TransactionsStateLoadingError({
    dynamic error,
    required bool showPayments,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
    showPayments: showPayments,
        );
}

class TransactionsStateViewModel extends TransactionsState {
  const TransactionsStateViewModel({
    required this.userTransactions,
    required bool showPayments,
  }) : super(
    type: ProgressErrorStateType.loaded,
    showPayments: showPayments,
  );

  final List<UserTransaction> userTransactions;

}
