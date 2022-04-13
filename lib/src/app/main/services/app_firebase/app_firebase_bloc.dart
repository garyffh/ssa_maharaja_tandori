import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/firebase_options.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';

import 'app_firebase_event.dart';
import 'app_firebase_state.dart';

class AppFirebaseBloc extends Bloc<AppFirebaseEvent, AppFirebaseState> {
  AppFirebaseBloc({
    required this.appThemeBloc,
  }) : super(const AppFirebaseStateInitial()) {
    on<AppFirebaseEventInitialise>((event, emit) async {
      try {
        emit(const AppFirebaseStateProgressError());

        if(defaultTargetPlatform != TargetPlatform.iOS) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        } else {
          await Firebase.initializeApp();
        }

        // final FirebasePerformance performance = FirebasePerformance.instance;
        // await performance.setPerformanceCollectionEnabled(true);

        emit(const AppFirebaseStateEnabled());
      } on UnsupportedError catch (_) {
        emit(
          AppFirebaseStateProgressError(
            error: AppException.fromString(
              'Firebase is not supported!',
            ),
          ),
        );
      } catch (e) {
        emit(AppFirebaseStateProgressError(error: e));
      }
    });
  }

  final AppThemeBloc appThemeBloc;
}
