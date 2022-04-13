import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/transactions/transactions_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/transactions/transactions_state.dart';
import 'package:single_store_app/src/app/models/user/user_document_type.dart';
import 'package:single_store_app/src/app/models/user/user_transaction.dart';
import 'package:single_store_app/src/app/models/user/user_transaction_read_option.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required this.transactionsRepo,
  }) : super(const TransactionsStateInitial()) {
    on<TransactionsEventGetViewModel>((event, emit) async {
      emit(TransactionsStateLoadingError(showPayments: state.showPayments));

      try {
        final List<UserTransaction> userTransactions =
            await transactionsRepo.readUserTransactions(
          UserTransactionReadOption(searchTypeId: 0),
        );

        emit(TransactionsStateViewModel(
          userTransactions: state.showPayments
              ? userTransactions
              : userTransactions
                  .where((element) =>
                      element.documentType != UserDocumentType.payment)
                  .toList(),
          showPayments: state.showPayments,
        ));
      } catch (e) {
        emit(TransactionsStateLoadingError(
          error: e,
          showPayments: state.showPayments,
        ));
      }
    });

    on<TransactionsEventUpdatePaymentFilter>((event, emit) async {
      emit(TransactionsStateLoadingError(showPayments: event.showPayments));

      try {
        final List<UserTransaction> userTransactions =
            await transactionsRepo.readUserTransactions(
          UserTransactionReadOption(searchTypeId: 0),
        );

        emit(TransactionsStateViewModel(
          userTransactions: state.showPayments
              ? userTransactions
              : userTransactions
                  .where((element) =>
                      element.documentType != UserDocumentType.payment)
                  .toList(),
          showPayments: state.showPayments,
        ));
      } catch (e) {
        emit(TransactionsStateLoadingError(
          error: e,
          showPayments: state.showPayments,
        ));
      }
    });
  }

  final TransactionsRepo transactionsRepo;

}
