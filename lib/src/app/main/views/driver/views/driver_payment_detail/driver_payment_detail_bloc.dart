import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';

import 'driver_payment_detail_event.dart';
import 'driver_payment_detail_state.dart';

class DriverPaymentDetailBloc
    extends Bloc<DriverPaymentDetailEvent, DriverPaymentDetailState> {
  DriverPaymentDetailBloc({required this.driverRepo})
      : super(const DriverPaymentDetailStateInitial()) {
    on<DriverPaymentDetailEventGetViewModel>((event, emit) async {
      try {
        emit(const DriverPaymentDetailStateLoadingError());

        emit(DriverPaymentDetailStateViewModel(
            driverPayment: await driverRepo.findDriverPaymentDetail(
          documentId: event.documentId,
        )));
      } catch (e) {
        emit(DriverPaymentDetailStateLoadingError(error: e));
      }
    });
  }

  final DriverRepo driverRepo;
}
