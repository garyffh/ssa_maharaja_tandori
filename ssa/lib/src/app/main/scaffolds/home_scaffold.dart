import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_state.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_state.dart';
import 'package:single_store_app/src/app/widgets/ui/badge_icon.dart';
import 'package:single_store_app/src/app/widgets/view/primary_scaffold.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    required this.child,
    this.initialRoute = HomeInitialRoute.categories,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final HomeInitialRoute initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _homeNavCubitWithInitialRoute(),
        ),
      ],
      child: BlocBuilder<HomeNavCubit, HomeNavState>(
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
              selectedItemColor: state.bottomNavBarActive()
                  ? null
                  : Theme.of(context).bottomNavigationUnselectedColor,
              selectedLabelStyle: state.bottomNavBarActive()
                  ? null
                  : Theme.of(context).bottomNavigationUnselectedStyle,
              unselectedIconTheme: state.bottomNavBarActive()
                  ? null
                  : Theme.of(context).bottomNavigationUnselectedIconTheme,
              selectedIconTheme: state.bottomNavBarActive()
                  ? null
                  : Theme.of(context).bottomNavigationUnselectedIconTheme,
              currentIndex: state.bottomNavigationIndex(),
              type: BottomNavigationBarType.fixed,
              onTap: (int value) {
                switch (value) {
                  case 0:
                    context.read<HomeNavCubit>().showUserCard();
                    break;

                  case 1:
                    context.read<HomeNavCubit>().showCategories();
                    break;

                  case 2:
                    context.read<HomeNavCubit>().showCartDisplay();
                    break;

                  case 3:
                    context.read<HomeNavCubit>().showTradingHours();
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

  HomeNavCubit _homeNavCubitWithInitialRoute() {
    switch (initialRoute) {
      case HomeInitialRoute.userCard:
        return HomeNavCubit.toUserCard();

      case HomeInitialRoute.cart:
        return HomeNavCubit.toCartDisplay();

      case HomeInitialRoute.checkout:
        return HomeNavCubit.toCheckout();

      case HomeInitialRoute.tradingHours:
        return HomeNavCubit.toTradingHours();

      case HomeInitialRoute.privacyPolicy:
        return HomeNavCubit.toPrivacyPolicy();

      case HomeInitialRoute.categories:
        return HomeNavCubit();
    }
  }
}
