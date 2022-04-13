import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';

import 'payment_detail_event.dart';
import 'payment_detail_state.dart';

class PaymentDetailBloc extends Bloc<PaymentDetailEvent, PaymentDetailState> {
  PaymentDetailBloc({
    required this.transactionsRepo,
  }) : super(const PaymentDetailStateInitial()) {
    on<PaymentDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const PaymentDetailStateLoadingError());

        emit(PaymentDetailStateViewModel(
          paymentDetail: await transactionsRepo.findPaymentDetail(
            event.documentId,
          ),
        ));
      } catch (e) {
        emit(PaymentDetailStateLoadingError(error: e));
      }
    });
  }

  final TransactionsRepo transactionsRepo;

}
