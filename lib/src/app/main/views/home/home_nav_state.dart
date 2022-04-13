import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

enum HomeView {
  categories,
  userCard,
  tradingHours,
  orders,
  transactions,
  myAccount,
  sitemDetail,
  checkout,
  invoiceDetail,
  creditDetail,
  paymentDetail,
  orderDetail,
  deliveryAreas,
  cartDisplay,
  cartAdd,
  cartUpdate,
  privacyPolicy,
}

abstract class HomeNavState {
  HomeNavState({
    required this.view,
    this.floatingActionButton,
  });

  final HomeView view;
  final FloatingActionButton? floatingActionButton;

  int bottomNavigationIndex() {
    switch (view) {
      case HomeView.userCard:
        return 0;

      case HomeView.categories:
        return 1;

      case HomeView.cartDisplay:
        return 2;

      case HomeView.tradingHours:
        return 3;

      default:
        return 0;
    }
  }

  bool bottomNavBarActive() {
    switch (view) {
      case HomeView.userCard:
      case HomeView.categories:
      case HomeView.cartDisplay:
      case HomeView.tradingHours:
        return true;

      default:
        return false;
    }
  }

  bool authenticationIsRequired() {
    switch (view) {
      case HomeView.categories:
      case HomeView.sitemDetail:
      case HomeView.tradingHours:
      case HomeView.deliveryAreas:
      case HomeView.cartDisplay:
      case HomeView.cartAdd:
      case HomeView.cartUpdate:
      case HomeView.privacyPolicy:
        return false;

      default:
        return true;
    }
  }
}

class HomeNavStateCategoriesView extends HomeNavState {
  HomeNavStateCategoriesView() : super(view: HomeView.categories);
}

class HomeNavStateUserCardView extends HomeNavState {
  HomeNavStateUserCardView() : super(view: HomeView.userCard);
}


class HomeNavStateTradingHoursView extends HomeNavState {
  HomeNavStateTradingHoursView() : super(view: HomeView.tradingHours);
}

class HomeNavStateOrdersView extends HomeNavState {
  HomeNavStateOrdersView() : super(view: HomeView.orders);
}


class HomeNavStateTransactionsView extends HomeNavState {
  HomeNavStateTransactionsView() : super(view: HomeView.transactions);
}

class HomeNavStateMyAccountView extends HomeNavState {
  HomeNavStateMyAccountView() : super(view: HomeView.myAccount);
}

class HomeNavStateCheckoutView extends HomeNavState {
  HomeNavStateCheckoutView() : super(view: HomeView.checkout);
}

class HomeNavStateSitemDetailView extends HomeNavState {
  HomeNavStateSitemDetailView({required this.initialSitemId})
      : super(view: HomeView.sitemDetail);

  final String initialSitemId;
}

class HomeNavStateInvoiceDetailView extends HomeNavState {
  HomeNavStateInvoiceDetailView({
    required this.documentId,
  }) : super(view: HomeView.invoiceDetail);

  final String documentId;
}

class HomeNavStateCreditDetailView extends HomeNavState {
  HomeNavStateCreditDetailView({
    required this.documentId,
  }) : super(view: HomeView.creditDetail);
  final String documentId;
}

class HomeNavStatePaymentDetailView extends HomeNavState {
  HomeNavStatePaymentDetailView({
    required this.documentId,
  }) : super(view: HomeView.paymentDetail);
  final String documentId;
}

class HomeNavStateOrderDetailView extends HomeNavState {
  HomeNavStateOrderDetailView({
    required this.trnOrderId,
  }) : super(view: HomeView.orderDetail);
  final String trnOrderId;
}

class HomeNavStateDeliveryAreasView extends HomeNavState {
  HomeNavStateDeliveryAreasView() : super(view: HomeView.deliveryAreas);
}

class HomeNavStateCartDisplayView extends HomeNavState {
  HomeNavStateCartDisplayView() : super(view: HomeView.cartDisplay);
}

class HomeNavStateCartAddView extends HomeNavState {
  HomeNavStateCartAddView({
    required this.postView,
    this.postViewSysSitemId,
    required this.sitem,
}) : super(view: HomeView.cartAdd);

  final HomeView postView;
  final String? postViewSysSitemId;
  final Sitem sitem;
}

class HomeNavStateCartUpdateView extends HomeNavState {
  HomeNavStateCartUpdateView({
    required this.updateIndex,
}) : super(view: HomeView.cartUpdate);
  final int updateIndex;
}

class HomeNavStatePrivacyPolicyView extends HomeNavState {
  HomeNavStatePrivacyPolicyView() : super(view: HomeView.privacyPolicy);
}
