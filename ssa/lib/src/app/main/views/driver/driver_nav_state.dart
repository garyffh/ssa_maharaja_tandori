import 'package:flutter/material.dart';

enum DriverView {
  deliveries,
  vehicles,
  transactions,
  deliveryDetail,
  enableDeliveries,
  invoiceDetail,
  paymentDetail,
  vehicleAdd,
}

abstract class DriverNavState {
  DriverNavState({
    required this.view,
    this.floatingActionButton,
  });

  final DriverView view;
  final FloatingActionButton? floatingActionButton;

  bool bottomNavBarActive() {
    switch(view) {
      case DriverView.transactions:
      case DriverView.vehicles:
      case DriverView.deliveries:
        return true;

      default:
        return false;
    }
  }

  int bottomNavigationIndex() {
    switch(view) {
      case DriverView.transactions:
        return 0;

      case DriverView.deliveries:
        return 1;

      case DriverView.vehicles:
        return 2;

      default:
        return 0;
    }
  }

  bool authenticationIsRequired() {

    switch(view) {

      default:
        return true;
    }

  }

}

class DriverNavStateDeliveriesView extends DriverNavState {
  DriverNavStateDeliveriesView() : super(view: DriverView.deliveries);
}

class DriverNavStateVehiclesView extends DriverNavState {
  DriverNavStateVehiclesView() : super(view: DriverView.vehicles);
}

class DriverNavStateTransactionsView extends DriverNavState {
  DriverNavStateTransactionsView() : super(view: DriverView.transactions);
}

class DriverNavStateDeliveryDetailView extends DriverNavState {
  DriverNavStateDeliveryDetailView({required this.trnOrderId})
      : super(view: DriverView.deliveryDetail);

  final String trnOrderId;

}

class DriverNavStateEnableDeliveriesView extends DriverNavState {
  DriverNavStateEnableDeliveriesView() : super(view: DriverView.enableDeliveries);
}

class DriverNavStateInvoiceDetailView extends DriverNavState {
  DriverNavStateInvoiceDetailView({
    required this.documentId,
}) : super(view: DriverView.invoiceDetail);

  final String documentId;
}

class DriverNavStatePaymentDetailView extends DriverNavState {
  DriverNavStatePaymentDetailView({
    required this.documentId,
  }) : super(view: DriverView.paymentDetail);

  final String documentId;
}
class DriverNavStateVehicleAddView extends DriverNavState {
  DriverNavStateVehicleAddView() : super(view: DriverView.vehicleAdd);
}
