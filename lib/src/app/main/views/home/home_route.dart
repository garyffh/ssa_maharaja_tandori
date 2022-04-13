import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/main/views/home/cart_add/cart_add_view.dart';
import 'package:single_store_app/src/app/main/views/home/privacy_policy/privacy_policy_view.dart';
import 'package:single_store_app/src/app/main/views/home/trading_hours/views/trading_hours_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_module.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/credit_detail/credit_detail_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/invoice_detail/invoice_detail_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_module.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/order_detail/order_detail_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/orders/orders_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/payment_detail/payment_detail_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/transactions/transactions_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/user_card/user_card_view.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';

import 'cart_display/cart_display_view.dart';
import 'cart_update/cart_update_view.dart';
import 'delivery_areas/views/delivery_areas_view.dart';
import 'home_nav_cubit.dart';
import 'home_nav_state.dart';
import 'order/views/categories/categories_view.dart';
import 'order/views/sitem_detail/sitem_detail_view.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({
    required this.appFloatingButtonCubit,
    Key? key,
  }) : super(key: key);

  final AppFloatingButtonCubit appFloatingButtonCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, HomeNavState>(
        builder: (context, navState) {
      if (navState.floatingActionButton == null) {
        appFloatingButtonCubit.removeFloatingButton();
      } else {
        appFloatingButtonCubit.showFloatingButton(
            floatingActionButton: navState.floatingActionButton!);
      }

      return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
        if ((navState.authenticationIsRequired() ||
            context.read<BusinessSettingsBloc>().state.appSignInRequired) &&
            !authenticationState.isAuthenticated) {
          BlocProvider.of<MainBloc>(context).add(
            MainEventNavigateAuthenticate(
              postAuthenticateView: _postAuthenticateView(navState.view),
            ),
          );
          return _defaultNavigator(context, navState);
        } else {
          if (navState.view == HomeView.myAccount) {
            return const MyAccountModule();
          } else if (navState.view == HomeView.checkout) {
            return const CheckoutModule();
          } else {
            return _buildNavigator(context, navState);
          }
        }
      });
    });
  }

  Navigator _buildNavigator(BuildContext context, HomeNavState navState) {
    switch (navState.view) {
      case HomeView.categories:
        return _defaultNavigator(context, navState);

      case HomeView.userCard:
        return _userCardNavigator(context, navState);

      case HomeView.tradingHours:
        return _tradingHoursNavigator(context, navState);

      case HomeView.orders:
        return _ordersNavigator(context, navState);

      case HomeView.orderDetail:
        return _orderDetailNavigator(context, navState);

      case HomeView.sitemDetail:
        return _sitemDetailNavigator(context, navState);

      case HomeView.deliveryAreas:
        return _deliveryAreasNavigator(context, navState);

      case HomeView.transactions:
      case HomeView.invoiceDetail:
      case HomeView.creditDetail:
      case HomeView.paymentDetail:
        return _transactionsNavigator(context, navState);

      case HomeView.myAccount:
      case HomeView.checkout:
        return _defaultNavigator(context, navState);

      case HomeView.cartDisplay:
        return _cartDisplayNavigator(context, navState);

      case HomeView.cartAdd:
        return _cartAddNavigator(context, navState);

      case HomeView.cartUpdate:
        return _cartUpdateNavigator(context, navState);

      case HomeView.privacyPolicy:
        return _privacyPolicyNavigator(context, navState);

    }
  }

  Navigator _defaultNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _userCardNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<UserCardView>(
          child: UserCardView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _tradingHoursNavigator(
      BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<TradingHoursView>(
          child: TradingHoursView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _ordersNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<OrdersView>(
          key: UniqueKey(),
          child: const OrdersView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _sitemDetailNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<SitemDetailView>(
          key: UniqueKey(),
          child: SitemDetailView(
            initialSitemId:
                (navState as HomeNavStateSitemDetailView).initialSitemId,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _transactionsNavigator(
      BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        const MaterialPage<TransactionsView>(
          child: TransactionsView(),
        ),
        if (navState.view == HomeView.invoiceDetail)
          MaterialPage<InvoiceDetailView>(
            key: ValueKey(
                (navState as HomeNavStateInvoiceDetailView).documentId),
            child: InvoiceDetailView(
              documentId: navState.documentId,
            ),
          ),
        if (navState.view == HomeView.creditDetail)
          MaterialPage<CreditDetailView>(
            key:
                ValueKey((navState as HomeNavStateCreditDetailView).documentId),
            child: CreditDetailView(
              documentId: navState.documentId,
            ),
          ),
        if (navState.view == HomeView.paymentDetail)
          MaterialPage<PaymentDetailView>(
            key: ValueKey(
                (navState as HomeNavStatePaymentDetailView).documentId),
            child: PaymentDetailView(
              documentId: navState.documentId,
            ),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _orderDetailNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<OrderDetailView>(
          key: ValueKey((navState as HomeNavStateOrderDetailView).trnOrderId),
          child: OrderDetailView(
            trnOrderId: navState.trnOrderId,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _deliveryAreasNavigator(
      BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<DeliveryAreasView>(
          child: DeliveryAreasView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _cartDisplayNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<CartDisplayView>(
          key: UniqueKey(),
          child: const CartDisplayView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _cartAddNavigator(BuildContext context, HomeNavState navState) {
    final HomeNavStateCartAddView cartAddNavState =
        navState as HomeNavStateCartAddView;

    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<CartAddView>(
          key: UniqueKey(),
          child: CartAddView(
            postView: cartAddNavState.postView,
            postViewSysSitemId: cartAddNavState.postViewSysSitemId,
            sitem: cartAddNavState.sitem,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _cartUpdateNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<CartUpdateView>(
          key: UniqueKey(),
          child: CartUpdateView(
            updateIndex: (navState as HomeNavStateCartUpdateView).updateIndex,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _privacyPolicyNavigator(BuildContext context, HomeNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<CategoriesView>(
          child: CategoriesView(),
        ),
        MaterialPage<PrivacyPolicyView>(
          key: UniqueKey(),
          child: const PrivacyPolicyView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  PostAuthenticateView _postAuthenticateView(HomeView homeView) {
    switch (homeView) {
      case HomeView.userCard:
        return PostAuthenticateView.userCard;

      case HomeView.checkout:
        return PostAuthenticateView.checkout;

      default:
        return PostAuthenticateView.category;
    }
  }

  bool _handleOnPopPage(
    BuildContext context,
    Route route,
    dynamic result,
    HomeNavState navState,
  ) {
    final HomeNavCubit navCubit = BlocProvider.of<HomeNavCubit>(context);

    switch (navState.view) {
      case HomeView.invoiceDetail:
      case HomeView.creditDetail:
      case HomeView.paymentDetail:
        navCubit.showTransactions();
        break;

      case HomeView.orderDetail:
        navCubit.showOrders();
        break;

      case HomeView.sitemDetail:
        navCubit.showCategories();
        break;

      case HomeView.categories:
      case HomeView.userCard:
      case HomeView.tradingHours:
      case HomeView.orders:
      case HomeView.transactions:
      case HomeView.myAccount:
      case HomeView.checkout:
      case HomeView.deliveryAreas:
      case HomeView.cartDisplay:
      case HomeView.cartAdd:
      case HomeView.cartUpdate:
      case HomeView.privacyPolicy:
        break;
    }

    return false;
  }
}
