import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';

@immutable
abstract class MainState {
  const MainState();
}

class MainStateHome extends MainState {
  const MainStateHome({
    this.initialRoute = HomeInitialRoute.categories,
  }) : super();

  final HomeInitialRoute initialRoute;
}

class MainStateDriver extends MainState {
  const MainStateDriver() : super();
}

class MainStateAuthenticate extends MainState {
  const MainStateAuthenticate({
    required this.postAuthenticateView,
}) : super();

  final PostAuthenticateView postAuthenticateView;
}

