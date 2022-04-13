import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

import 'home_nav_state.dart';

class HomeNavCubit extends Cubit<HomeNavState> {
  HomeNavCubit() : super(HomeNavStateCategoriesView());

  HomeNavCubit.toUserCard() : super(HomeNavStateUserCardView());

  HomeNavCubit.toCartDisplay() : super(HomeNavStateCartDisplayView());

  HomeNavCubit.toCheckout() : super(HomeNavStateCheckoutView());

  HomeNavCubit.toTradingHours() : super(HomeNavStateTradingHoursView());

  HomeNavCubit.toPrivacyPolicy() : super(HomeNavStatePrivacyPolicyView());

  void showCategories() => emit(HomeNavStateCategoriesView());

  void showUserCard() => emit(HomeNavStateUserCardView());

  void showTradingHours() => emit(HomeNavStateTradingHoursView());

  void showOrders() => emit(HomeNavStateOrdersView());

  void showTransactions() => emit(HomeNavStateTransactionsView());

  void showMyAccount() => emit(HomeNavStateMyAccountView());

  void showCheckout() => emit(HomeNavStateCheckoutView());

  void showSitemDetail(String initialSitemId) =>
      emit(HomeNavStateSitemDetailView(initialSitemId: initialSitemId));

  void showInvoiceDetail(String documentId) =>
      emit(HomeNavStateInvoiceDetailView(documentId: documentId));

  void showCreditDetail(String documentId) =>
      emit(HomeNavStateCreditDetailView(documentId: documentId));

  void showPaymentDetail(String documentId) =>
      emit(HomeNavStatePaymentDetailView(documentId: documentId));

  void showOrderDetail(String trnOrderId) =>
      emit(HomeNavStateOrderDetailView(trnOrderId: trnOrderId));

  void showDeliveryAreas() => emit(HomeNavStateDeliveryAreasView());

  void showCartDisplay() => emit(HomeNavStateCartDisplayView());

  void showCartAdd({
    required HomeView postView,
    String? postViewSysSitemId,
    required Sitem sitem,
  }) =>
      emit(HomeNavStateCartAddView(
        postView: postView,
        postViewSysSitemId: postViewSysSitemId,
        sitem: sitem,
      ));

  void showCartUpdate(int updateIndex) => emit(HomeNavStateCartUpdateView(updateIndex: updateIndex));

  void showPrivacyPolicy() => emit(HomeNavStatePrivacyPolicyView());

}
