import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_event.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_state.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';

class UserBusinessBloc extends Bloc<UserBusinessEvent, UserBusinessState> {
  UserBusinessBloc({
    required this.businessSettingsBloc,
    required this.authenticationBloc,
  }) : super(UserBusinessState(
          businessPriceLevel: businessSettingsBloc.state.activePriceLevel,
          userPriceLevel: authenticationBloc.state.userPriceLevel,
        )) {
    on<UserBusinessEventUpdateBusinessPriceLevel>((event, emit) async {
      emit(UserBusinessState(
          businessPriceLevel: event.businessPriceLevel,
          userPriceLevel: state.userPriceLevel));
    });

    on<UserBusinessEventUpdateUserPriceLevel>((event, emit) async {
      emit(UserBusinessState(
          businessPriceLevel: state.businessPriceLevel,
          userPriceLevel: event.userPriceLevel));
    });

    businessSettingsBlocSubscription =
        businessSettingsBloc.stream.listen((businessSettingsState) {
      add(UserBusinessEventUpdateBusinessPriceLevel(
          businessPriceLevel: businessSettingsState.activePriceLevel));
    });

    authenticationBlocSubscription =
        authenticationBloc.stream.listen((authenticationState) {
      add(UserBusinessEventUpdateUserPriceLevel(
          userPriceLevel: authenticationState.userPriceLevel));
    });
  }

  final BusinessSettingsBloc businessSettingsBloc;
  final AuthenticationBloc authenticationBloc;
  late StreamSubscription businessSettingsBlocSubscription;
  late StreamSubscription authenticationBlocSubscription;


  @override
  Future<void> close() {
    authenticationBlocSubscription.cancel();
    businessSettingsBlocSubscription.cancel();
    return super.close();
  }
}
