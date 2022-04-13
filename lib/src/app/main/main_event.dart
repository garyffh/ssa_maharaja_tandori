import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';

abstract class MainEvent {}

class MainEventNavigateHome extends MainEvent {
  MainEventNavigateHome({
    this.initialRoute = HomeInitialRoute.categories,
  });

  final HomeInitialRoute initialRoute;
}

class MainEventNavigateDriver extends MainEvent {
  MainEventNavigateDriver();
}

class MainEventNavigateAuthenticate extends MainEvent {
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

