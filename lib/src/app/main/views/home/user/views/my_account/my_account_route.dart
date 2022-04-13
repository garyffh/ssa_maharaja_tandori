import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/address_update/address_update_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/dashboard/dashboard_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/password_update/password_update_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/password_update_confirmation/password_update_confirmation_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_method_add/payment_method_add_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/phone_code/phone_code_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/phone_update/phone_update_view.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'my_account_nav_cubit.dart';
import 'my_account_nav_state.dart';

class MyAccountRoute extends StatelessWidget {
  const MyAccountRoute({required this.appFloatingButtonCubit, Key? key})
      : super(key: key);

  final AppFloatingButtonCubit appFloatingButtonCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAccountNavCubit, MyAccountNavState>(
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
      BuildContext context, MyAccountNavState navState) {
    switch (navState.view) {
      case MyAccountView.dashboard:
        return _dashboardNavigator(context, navState);

      case MyAccountView.paymentMethods:
        return _paymentMethodsNavigator(context, navState);

      case MyAccountView.paymentMethodAdd:
        return _paymentMethodAddNavigator(context, navState);

      case MyAccountView.addressUpdate:
        return _addressUpdateNavigator(context, navState);

      case MyAccountView.passwordUpdate:
        return _passwordUpdateNavigator(context, navState);

      case MyAccountView.passwordUpdateConfirmation:
        return _passwordUpdateConfirmationNavigator(context, navState);

      case MyAccountView.phoneUpdate:
      case MyAccountView.phoneCode:
        return _phoneUpdateNavigator(context, navState);
    }
  }

  Navigator _defaultNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<DashboardView>(
          child: DashboardView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _dashboardNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<DashboardView>(
          child: DashboardView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _paymentMethodsNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<PaymentMethodsView>(
          child: PaymentMethodsView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _paymentMethodAddNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<PaymentMethodAddView>(
          child: PaymentMethodAddView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _addressUpdateNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<AddressUpdateView>(
          child: AddressUpdateView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _passwordUpdateNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<PasswordUpdateView>(
          child: PasswordUpdateView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _passwordUpdateConfirmationNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: const [
        MaterialPage<PasswordUpdateConfirmationView>(
          child: PasswordUpdateConfirmationView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Navigator _phoneUpdateNavigator(
      BuildContext context, MyAccountNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<PhoneUpdateView>(
          child: PhoneUpdateView(),
        ),
        if (navState.view == MyAccountView.phoneCode)
          MaterialPage<PhoneCodeView>(
            child: PhoneCodeView(
              mobileNumber:
                  (navState as MyAccountNavStatePhoneCodeView).mobileNumber,
            ),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  Widget _unauthenticatedNavigator(
      BuildContext context, MyAccountNavState navState) {
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
    MyAccountNavState navState,
  ) {
    final MyAccountNavCubit navCubit =
        BlocProvider.of<MyAccountNavCubit>(context);

    switch (navState.view) {
      case MyAccountView.paymentMethods:
      case MyAccountView.addressUpdate:
      case MyAccountView.passwordUpdate:
      case MyAccountView.phoneUpdate:
        navCubit.showDashBoard();
        break;

      case MyAccountView.paymentMethodAdd:
        navCubit.showPaymentMethods();
        break;

      case MyAccountView.phoneCode:
        navCubit.showPhoneUpdate();
        break;

      case MyAccountView.dashboard:
      case MyAccountView.passwordUpdateConfirmation:
        break;
    }

    return false;
  }
}
