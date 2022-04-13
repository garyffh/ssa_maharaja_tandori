import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/select/select_state.dart';

abstract class SelectEvent {}

class SelectEventNavigateSelect extends SelectEvent {
  SelectEventNavigateSelect({
    required this.postSelectView,
  });

  SelectEventNavigateSelect.defaultPostSelectView()
      : postSelectView = PostSelectView.category;


  final PostSelectView postSelectView;
}

class SelectEventNavigateHome extends SelectEvent {
  SelectEventNavigateHome({
    this.initialRoute = HomeInitialRoute.categories,
  });

  final HomeInitialRoute initialRoute;
}

class MainEventNavigateDriver extends SelectEvent {
  MainEventNavigateDriver();
}

class MainEventNavigateAuthenticate extends SelectEvent {
  MainEventNavigateAuthenticate({
    required this.postAuthenticateView,
  });

  MainEventNavigateAuthenticate.defaultPostAuthenticateView()
      : postAuthenticateView = PostAuthenticateView.category;

  MainEventNavigateAuthenticate.userCardPostAuthenticateView()
      : postAuthenticateView = PostAuthenticateView.userCard;

  MainEventNavigateAuthenticate.checkoutPostAuthenticateView()
      : postAuthenticateView = PostAuthenticateView.checkout;

  final PostAuthenticateView postAuthenticateView;
}

