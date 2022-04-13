import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_deliveries/driver_deliveries_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_delivery_detail/driver_delivery_detail_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_enable_deliveries/driver_enable_deliveries_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_invoice_detail/driver_invoice_detail_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_payment_detail/driver_payment_detail_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_transactions/driver_transactions_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_vehicle_add/driver_vehicle_add_view.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_vehicles/driver_vehicles_view.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'driver_nav_cubit.dart';
import 'driver_nav_state.dart';

class DriverRoute extends StatelessWidget {
  const DriverRoute({
    required this.appFloatingButtonCubit,
    Key? key,}) : super(key: key);

  final AppFloatingButtonCubit appFloatingButtonCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverNavCubit, DriverNavState>(
        builder: (navContext, navState) {
          if (navState.floatingActionButton == null) {
            appFloatingButtonCubit.removeFloatingButton();
          } else {
            appFloatingButtonCubit.showFloatingButton(
                floatingActionButton: navState.floatingActionButton!);
          }
      return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            return authenticationState.isAuthenticated
                ? _authenticatedNavigator(navContext, navState)
                : _unauthenticatedNavigator(navContext, navState);
          });
    });
  }

  Navigator _authenticatedNavigator(
      BuildContext context, DriverNavState navState) {
    switch (navState.view) {
      case DriverView.transactions:
      case DriverView.invoiceDetail:
      case DriverView.paymentDetail:
        return _transactionsNavigator(context, navState);

      case DriverView.vehicles:
      case DriverView.vehicleAdd:
        return _vehicleNavigator(context, navState);

      case DriverView.enableDeliveries:
        return _enabledDeliveriesNavigator(context, navState);


      case DriverView.deliveries:
        return _defaultNavigator(context, navState);

      case DriverView.deliveryDetail:
        return _deliveryDetailNavigator(context, navState);

    }
  }

  Navigator _defaultNavigator(BuildContext context, DriverNavState navState) {
    return Navigator(
      pages: const [
         MaterialPage<DriverDeliveriesView>(
          child: DriverDeliveriesView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _deliveryDetailNavigator(BuildContext context, DriverNavState navState) {
    return Navigator(
      pages: [
          MaterialPage<DriverDeliveryDetailView>(
            child: DriverDeliveryDetailView(
              trnOrderId:
              (navState as DriverNavStateDeliveryDetailView).trnOrderId,
            ),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _enabledDeliveriesNavigator(
      BuildContext context, DriverNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<DriverEnableDeliveriesView>(
          child: DriverEnableDeliveriesView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _transactionsNavigator(
      BuildContext context, DriverNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<DriverTransactionsView>(
          child: DriverTransactionsView(),
        ),
        if (navState.view == DriverView.invoiceDetail)
          MaterialPage<DriverInvoiceDetailView>(
            child: DriverInvoiceDetailView(
              documentId:
                  (navState as DriverNavStateInvoiceDetailView).documentId,
            ),
          ),
        if (navState.view == DriverView.paymentDetail)
          MaterialPage<DriverPaymentDetailView>(
            child: DriverPaymentDetailView(
              documentId:
                  (navState as DriverNavStatePaymentDetailView).documentId,
            ),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _vehicleNavigator(BuildContext context, DriverNavState navState) {
    return Navigator(
      pages: [
        if (navState.view == DriverView.vehicles)
          const MaterialPage<DriverVehiclesView>(
            child: DriverVehiclesView(),
          ),
        if (navState.view == DriverView.vehicleAdd)
          const MaterialPage<DriverVehicleAddView>(
            child: DriverVehicleAddView(),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Widget _unauthenticatedNavigator(
      BuildContext context, DriverNavState navState) {
    if (navState.authenticationIsRequired()) {
      BlocProvider.of<MainBloc>(context)
          .add(MainEventNavigateAuthenticate.defaultPostAuthenticateView());
    }
    return _defaultNavigator(context, navState);
  }

  bool _handleOnPopPage(
    BuildContext context,
    Route route,
    dynamic result,
    DriverNavState navState,
  ) {
    final DriverNavCubit navCubit = BlocProvider.of<DriverNavCubit>(context);

    switch (navState.view) {
      case DriverView.vehicleAdd:
        navCubit.showVehicles();
        break;

      case DriverView.paymentDetail:
      case DriverView.invoiceDetail:
        navCubit.showTransactions();
        break;

      case DriverView.deliveryDetail:
      case DriverView.enableDeliveries:
        navCubit.showDeliveries();
        break;

      case DriverView.transactions:
      case DriverView.vehicles:
      case DriverView.deliveries:
        break;
    }

    return false;
    // return route.didPop(result);
  }
}
