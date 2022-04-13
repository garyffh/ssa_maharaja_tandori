import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_audio/app_audio_cubit.dart';
import 'package:single_store_app/src/app/services/app_audio/app_audio_state.dart';

import 'app_snack_bar_state.dart';

class AppSnackBarCubit extends Cubit<AppSnackBarState> {
  AppSnackBarCubit({
    required this.appAudioCubit,
  }) : super(const AppSnackBarStateInitial());

  final AppAudioCubit appAudioCubit;

  Future<void> showSnackBar({
    required SnackBar snackBar,
    AppSound appSound = AppSound.message,
  }) async {
    if (appSound != AppSound.none) {
      await appAudioCubit.playSound(appSound);
    }
    emit(AppSnackBarStatePublished(snackBar: snackBar));
  }
}
