import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_complete/checkout_complete_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_stepper/checkout_stepper_view.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'checkout_nav_cubit.dart';
import 'checkout_nav_state.dart';

class CheckoutRoute extends StatelessWidget {
  const CheckoutRoute({
    required this.appFloatingButtonCubit,
    Key? key,
  }) : super(key: key);

  final AppFloatingButtonCubit appFloatingButtonCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutNavCubit, CheckoutNavState>(
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
      BuildContext context, CheckoutNavState navState) {
    switch (navState.view) {
      case CheckoutView.stepper:
        return _defaultNavigator(context, navState);


      case CheckoutView.complete:
        return _completeNavigator(context, navState);
    }
  }

  Widget _unauthenticatedNavigator(
      BuildContext context, CheckoutNavState navState) {
    if (navState.authenticationIsRequired()) {
      BlocProvider.of<MainBloc>(context)
          .add(MainEventNavigateAuthenticate.checkoutPostAuthenticateView());
    }
    return _defaultNavigator(context, navState);
  }

  Navigator _defaultNavigator(BuildContext context, CheckoutNavState navState) {
    return Navigator(
      pages: [
        MaterialPage<CheckoutStepperView>(
          key: UniqueKey(),
          child: const CheckoutStepperView(),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }


  Navigator _completeNavigator(BuildContext context, CheckoutNavState navState) {
    return Navigator(
      pages: [
        MaterialPage<CheckoutCompleteView>(
          child: CheckoutCompleteView(
            trnOrder: (navState as CheckoutNavStateCompleteView).trnOrder,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result, navState);
      },
    );
  }

  bool _handleOnPopPage(
    BuildContext context,
    Route route,
    dynamic result,
    CheckoutNavState navState,
  ) {
    // final CheckoutNavCubit navCubit =
    //     BlocProvider.of<CheckoutNavCubit>(context);

    switch (navState.view) {
      case CheckoutView.stepper:
      case CheckoutView.complete:
        break;
    }

    return false;
  }
}
