import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/main_state.dart';
import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_event.dart';
import 'package:single_store_app/src/app/widgets/ui/logo_widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) =>
            previous.isAuthenticated != current.isAuthenticated,
        listener: (context, authenticationState) {},
        builder: (context, authenticationState) {
          return BlocBuilder<MainBloc, MainState>(
              builder: (context, mainState) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: LogoWidget(),
                ),
                ..._buildMainMenu(
                  context,
                  authenticationState,
                  mainState,
                ),
              ],
            );
          });
        },
      ),
    );
  }

  List<Widget> _buildMainMenu(
    BuildContext context,
    AuthenticationState authenticationState,
    MainState mainState,
  ) {
    if (authenticationState.isAuthenticated) {
      switch (mainState.runtimeType) {
        case MainStateAuthenticate:
        case MainStateHome:
          return _homeMenu(context, authenticationState, mainState);

        case MainStateDriver:
          return _driverMenu(context, mainState);

        default:
          return _homeMenu(context, authenticationState, mainState);
      }
    } else {
      return _unAuthenticatedMenu(context, mainState);
    }
  }

  List<Widget> _homeMenu(
    BuildContext context,
    AuthenticationState authenticationState,
    MainState state,
  ) {
    return [
      if (BlocProvider.of<BusinessSelectBloc>(context).state.isMultiStore)
      ListTile(
        leading: Icon(
          Icons.storefront,
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text('Select Store'),
        onTap: () {
          Navigator.pop(context);
          BlocProvider.of<BusinessSelectBloc>(context).add(BusinessSelectEventUnselect());
        },
      ),
      if (authenticationState.driver)
        ListTile(
          leading: Icon(
            Icons.drive_eta,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Driver'),
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<MainBloc>(context).add(MainEventNavigateDriver());
          },
        ),
      ListTile(
        leading: Icon(
          Icons.store,
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text('Orders'),
        onTap: () {
          BlocProvider.of<HomeNavCubit>(context).showOrders();
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.history,
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text('History'),
        onTap: () {
          BlocProvider.of<HomeNavCubit>(context).showTransactions();
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.account_box,
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text('My Account'),
        onTap: () {
          BlocProvider.of<HomeNavCubit>(context).showMyAccount();
          Navigator.pop(context);
        },
      ),
      ..._sharedMenu(context, state),
      ListTile(
          leading: Icon(
            Icons.policy,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Privacy Policy'),
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<HomeNavCubit>(context).showPrivacyPolicy();
          }),
    ];
  }

  List<Widget> _driverMenu(BuildContext context, MainState state) {
    return [
      if (BlocProvider.of<BusinessSelectBloc>(context).state.isMultiStore)
        ListTile(
          leading: Icon(
            Icons.storefront,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Select Store'),
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<BusinessSelectBloc>(context).add(BusinessSelectEventUnselect());
          },
        ),

      ListTile(
        title: const Text('Home'),
        leading: Icon(
          Icons.dashboard,
          color: Theme.of(context).iconTheme.color,
        ),
        onTap: () {
          Navigator.pop(context);
          BlocProvider.of<MainBloc>(context).add(MainEventNavigateHome());
        },
      ),
      ..._sharedMenu(context, state),
    ];
  }

  List<Widget> _sharedMenu(BuildContext context, MainState state) {
    return [
      ListTile(
          leading: Icon(
            Icons.logout,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Sign Out'),
          onTap: () {
            Navigator.pop(context);
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationEventSignOut());
          }),
    ];
  }

  List<Widget> _unAuthenticatedMenu(BuildContext context, MainState state) {
    return [
      if (BlocProvider.of<BusinessSelectBloc>(context).state.isMultiStore)
      ListTile(
        leading: Icon(
          Icons.storefront,
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text('Select Store'),
        onTap: () {
          Navigator.pop(context);
          BlocProvider.of<BusinessSelectBloc>(context).add(BusinessSelectEventUnselect());
        },
      ),
      ListTile(
          leading: Icon(
            Icons.login,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Sign In'),
          onTap: () {
            Navigator.pop(context);
            context.read<MainBloc>().add(
                  MainEventNavigateAuthenticate(
                      postAuthenticateView: PostAuthenticateView.category),
                );
          }),
      ListTile(
          leading: Icon(
            Icons.policy,
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('Privacy Policy'),
          onTap: () {
            Navigator.pop(context);
            (state is MainStateHome)
                ? context.read<HomeNavCubit>().showPrivacyPolicy()
                : context.read<MainBloc>().add(
                      MainEventNavigateHome(
                          initialRoute: HomeInitialRoute.privacyPolicy),
                    );
          }),
    ];
  }
}
