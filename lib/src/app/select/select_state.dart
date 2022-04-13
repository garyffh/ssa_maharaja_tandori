
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';

enum PostSelectView { category }

@immutable
abstract class SelectState {
  const SelectState();
}

class SelectStateSelect extends SelectState {
  const SelectStateSelect({
    required this.postSelectView,
  }) : super();

  final PostSelectView postSelectView;
}

class SelectStateHome extends SelectState {
  const SelectStateHome({
    this.initialRoute = HomeInitialRoute.categories,
  }) : super();

  final HomeInitialRoute initialRoute;
}

class SelectStateDriver extends SelectState {
  const SelectStateDriver() : super();
}

class SelectStateAuthenticate extends SelectState {
  const SelectStateAuthenticate({
    required this.postAuthenticateView,
}) : super();

  final PostAuthenticateView postAuthenticateView;
}

