import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_state.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

import 'app_theme_event.dart';
import 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc({
    required this.storageCubit,
    required BusinessSelectBloc businessSelectBloc,
    required BusinessSettingsBloc businessSettingsBloc,
  }) : super(const AppThemeStateInitial()) {
    on<AppThemeEventThemeFromStorage>((event, emit) async {
      final String? businessName = await storageCubit.getBusinessName();
      final String? theme = await storageCubit.getTheme();

      if (businessName != null && theme != null) {
        emit(
          AppThemeStateLoaded(
            businessName: businessName,
            theme: theme,
            themeMode: state.themeMode,
          ),
        );
      }
    });

    on<AppThemeEventThemeUpdateFromServer>((event, emit) async {

      await storageCubit
          .saveBusinessName(event.businessName);
      await storageCubit.saveTheme(event.theme);

      emit(
        AppThemeStateLoaded(
          businessName: event.businessName,
          theme: event.theme,
          themeMode: state.themeMode,
        ),
      );
    });

    on<AppThemeEventModeUpdate>((event, emit) async {

      emit(AppThemeStateLoaded(
        businessName: state.businessName,
        theme: state.theme,
        themeMode: event.themeMode,
      ));
    });

    businessSelectBlocSubscription = businessSelectBloc.stream.listen((state) {
      if (state.type == BusinessSelectStateType.loaded) {
        final BusinessSelectStateLoaded businessSelectStateLoaded = state as BusinessSelectStateLoaded;
        add(
          AppThemeEventThemeUpdateFromServer(
            businessName: businessSelectStateLoaded.multiStoreSettings.applicationName,
            theme: businessSelectStateLoaded.multiStoreSettings.theme,
          ),
        );
      }
    });

    businessSettingsSubscription = businessSettingsBloc.stream.listen((state) {
      if (state.type == BusinessSettingStateType.loaded) {
        final BusinessSettingsStateLoaded businessSettingsStateLoaded = state as BusinessSettingsStateLoaded;
        add(
          AppThemeEventThemeUpdateFromServer(
            businessName: businessSettingsStateLoaded.businessName,
            theme: businessSettingsStateLoaded.theme,
          ),
        );
      }
    });
  }

  final StorageCubit storageCubit;
  late StreamSubscription businessSelectBlocSubscription;
  late StreamSubscription businessSettingsSubscription;

  // final sampleTheme = 'blue';
  //final sampleTheme = 'brown'; // elevated text stays same for light and dark
  //final sampleTheme =  'green';
  //final sampleTheme =  'grey';
  // final sampleTheme =  'pink';
  // final sampleTheme =  'purple';
  //final sampleTheme =  'orange';
  //final sampleTheme =  'espresso';
  //final sampleTheme =  'ebony';

  @override
  Future<void> close() {
    businessSelectBlocSubscription.cancel();
    businessSettingsSubscription.cancel();
    return super.close();
  }
}
