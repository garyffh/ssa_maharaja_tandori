import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/models/driver/driver_transaction_read_option.dart';

import 'driver_transactions_event.dart';
import 'driver_transactions_state.dart';

class DriverTransactionsBloc
    extends Bloc<DriverTransactionsEvent, DriverTransactionsState> {
  DriverTransactionsBloc({required this.driverRepo})
      : super(const DriverTransactionsStateInitial()) {
    on<DriverTransactionsEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverTransactionsStateLoadingError());

        emit(DriverTransactionsStateViewModel(
            driverTransactions: await driverRepo.readDriverTransactions(
          driverTransactionReadOption: DriverTransactionReadOption(),
        )));
      } catch (e) {
        emit(DriverTransactionsStateLoadingError(error: e));
      }
    });
  }

  final DriverRepo driverRepo;
}
