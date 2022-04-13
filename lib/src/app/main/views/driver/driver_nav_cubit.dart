import 'package:flutter_bloc/flutter_bloc.dart';

import 'driver_nav_state.dart';

class DriverNavCubit extends Cubit<DriverNavState> {
  DriverNavCubit() : super(DriverNavStateDeliveriesView());

  void showDeliveries() => emit(DriverNavStateDeliveriesView());

  void showTransactions() => emit(DriverNavStateTransactionsView());

  void showVehicles() => emit(DriverNavStateVehiclesView());

  void showDeliveryDetail(String trnOrderId) => emit(DriverNavStateDeliveryDetailView(trnOrderId: trnOrderId));

  void showEnableDeliveries() => emit(DriverNavStateEnableDeliveriesView());

  void showInvoiceDetail(String documentId) =>
      emit(DriverNavStateInvoiceDetailView(documentId: documentId));

  void showPaymentDetail(String documentId) =>
      emit(DriverNavStatePaymentDetailView(documentId: documentId));

  void showVehicleAdd() => emit(DriverNavStateVehicleAddView());

}
