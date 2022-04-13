import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';

import 'credit_detail_event.dart';
import 'credit_detail_state.dart';

class CreditDetailBloc extends Bloc<CreditDetailEvent, CreditDetailState> {
  CreditDetailBloc({
    required this.transactionsRepo,
  }) : super(const CreditDetailStateInitial()) {
    on<CreditDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const CreditDetailStateLoadingError());

        emit(CreditDetailStateViewModel(
          creditDetail: await transactionsRepo.findCreditDetail(
            event.documentId,
          ),
        ));
      } catch (e) {
        emit(CreditDetailStateLoadingError(error: e));
      }
    });
  }

  final TransactionsRepo transactionsRepo;

}
