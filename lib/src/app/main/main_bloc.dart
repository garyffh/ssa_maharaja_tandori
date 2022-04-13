import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainStateHome()) {
    on<MainEventNavigateHome>((event, emit) async {
      emit(MainStateHome(
        initialRoute: event.initialRoute,
      ));
    });

    on<MainEventNavigateDriver>((event, emit) async {
      emit(const MainStateDriver());
    });

    on<MainEventNavigateAuthenticate>((event, emit) async {
      emit(MainStateAuthenticate(
          postAuthenticateView: event.postAuthenticateView));
    });


  }

}
