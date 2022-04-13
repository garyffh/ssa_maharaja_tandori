import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_state.dart';
import 'package:single_store_app/src/app/widgets/ui/badge_icon.dart';
import 'package:single_store_app/src/app/widgets/view/primary_scaffold.dart';

import 'models/home_initial_route.dart';

class AuthenticateScaffold extends StatelessWidget {
  const AuthenticateScaffold({
    required this.child,
    required this.postAuthenticateView,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final PostAuthenticateView postAuthenticateView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticateNavCubitWithPostAuthenticateView(),
      child: BlocBuilder<AuthenticateNavCubit, AuthenticateNavState>(
        builder: (context, state) {
          return PrimaryScaffold(
            body: BlocListener<AppSnackBarCubit, AppSnackBarState>(
              listener: (scaffoldContext, snackBarState) {
                if (snackBarState.snackBar != null) {
                  ScaffoldMessenger.of(scaffoldContext)
                      .showSnackBar(snackBarState.snackBar!);
                }
              },
              child: child,
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor:
                  Theme.of(context).bottomNavigationUnselectedColor,
              selectedLabelStyle:
                  Theme.of(context).bottomNavigationUnselectedStyle,
              unselectedIconTheme:
                  Theme.of(context).bottomNavigationUnselectedIconTheme,
              selectedIconTheme:
                  Theme.of(context).bottomNavigationUnselectedIconTheme,
              currentIndex: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (int value) {
                switch (value) {
                  case 0:
                    BlocProvider.of<MainBloc>(context).add(
                      MainEventNavigateHome(
                          initialRoute: HomeInitialRoute.userCard),
                    );
                    break;

                  case 1:
                    BlocProvider.of<MainBloc>(context).add(
                      MainEventNavigateHome(
                          initialRoute: HomeInitialRoute.categories),
                    );
                    break;

                  case 2:
                    BlocProvider.of<MainBloc>(context).add(
                      MainEventNavigateHome(
                          initialRoute: HomeInitialRoute.cart),
                    );
                    break;

                  case 3:
                    BlocProvider.of<MainBloc>(context).add(
                      MainEventNavigateHome(
                          initialRoute: HomeInitialRoute.tradingHours),
                    );
                    break;
                }
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.card_membership),
                  label: 'Loyalty',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: BadgeIcon(
                    iconData: Icons.shopping_cart,
                    value: context.watch<CartBloc>().state.itemCount,
                  ),
                  label: 'Cart',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.schedule),
                  label: 'Hours',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AuthenticateNavCubit _authenticateNavCubitWithPostAuthenticateView() {
    switch (postAuthenticateView) {
      case PostAuthenticateView.category:
        return AuthenticateNavCubit.postAuthenticateCategory();

      case PostAuthenticateView.userCard:
        return AuthenticateNavCubit.postAuthenticateUserCard();

      case PostAuthenticateView.checkout:
        return AuthenticateNavCubit.postAuthenticateCheckout();

      default:
        return AuthenticateNavCubit.postAuthenticateCategory();
    }
  }
}
