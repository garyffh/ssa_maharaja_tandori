import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';

import 'invoice_detail_event.dart';
import 'invoice_detail_state.dart';

class InvoiceDetailBloc extends Bloc<InvoiceDetailEvent, InvoiceDetailState> {
  InvoiceDetailBloc({
    required this.transactionsRepo,
  }) : super(const InvoiceDetailStateInitial()) {
    on<InvoiceDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const InvoiceDetailStateLoadingError());

        emit(InvoiceDetailStateViewModel(
          invoiceDetail: await transactionsRepo.findInvoiceDetail(
            event.documentId,
          ),
        ));
      } catch (e) {
        emit(InvoiceDetailStateLoadingError(error: e));
      }
    });
  }

  final TransactionsRepo transactionsRepo;

}
