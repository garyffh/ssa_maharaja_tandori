import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';

import 'driver_invoice_detail_event.dart';
import 'driver_invoice_detail_state.dart';

class DriverInvoiceDetailBloc
    extends Bloc<DriverInvoiceDetailEvent, DriverInvoiceDetailState> {
  DriverInvoiceDetailBloc({
    required this.driverRepo,
  }) : super(const DriverInvoiceDetailStateInitial()) {
    on<DriverInvoiceDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverInvoiceDetailStateLoadingError());

        emit(DriverInvoiceDetailStateViewModel(
          driverInvoice: await driverRepo.findDriverInvoiceDetail(
            documentId: event.documentId,
          ),
        ));
      } catch (e) {
        emit(DriverInvoiceDetailStateLoadingError(error: e));
      }
    });
  }

  final DriverRepo driverRepo;
}
