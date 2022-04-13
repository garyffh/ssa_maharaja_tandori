import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/scaffolds/authenticate_scaffold.dart';
import 'package:single_store_app/src/app/main/scaffolds/driver_scaffold.dart';
import 'package:single_store_app/src/app/main/scaffolds/home_scaffold.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_module.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_module.dart';
import 'package:single_store_app/src/app/main/views/home/home_module.dart';

import 'main_bloc.dart';
import 'main_state.dart';

class MainRoute extends StatelessWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state.runtimeType == MainStateHome)
            MaterialPage<HomeScaffold>(
              child: HomeScaffold(
                initialRoute: (state as MainStateHome).initialRoute,
                child: const HomeModule(), // only create modules from here to scaffold
              ),
            ),
          if (state.runtimeType == MainStateDriver)
            const MaterialPage<DriverScaffold>(
              child: DriverScaffold(
                child: DriverModule(),
              ),
            ),
          if (state.runtimeType == MainStateAuthenticate)
            MaterialPage<AuthenticateScaffold>(
              child: AuthenticateScaffold(
                postAuthenticateView:
                    (state as MainStateAuthenticate).postAuthenticateView,
                child: const AuthenticateModule(),
              ),
            ),
        ],
        onPopPage: (route, dynamic result) => route.didPop(result),
      );
    });
  }
}
