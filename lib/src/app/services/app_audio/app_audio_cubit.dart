import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'app_audio_state.dart';

class AppAudioCubit extends Cubit<AppAudioState> {
  AppAudioCubit() : super(const AppAudioStateInitial());

  final audioPlayer = AudioPlayer();

  String? audioFile(AppSound appSound) {
    switch (appSound) {
      case AppSound.none:
        {
          return null;
        }

      case AppSound.message:
        {
          return 'assets/sounds/sound1.mp3';
        }

      case AppSound.driverDelivery:
        {
          return 'assets/sounds/sound2.mp3';
        }

      case AppSound.userPickup:
        {
          return 'assets/sounds/sound4.mp3';
        }
    }
  }

  Future<void> playSound(AppSound appSound) async {
    final String? soundFile = audioFile(appSound);

    if (soundFile == null) {
      return;
    }

    await audioPlayer.setAsset(soundFile);
    await audioPlayer.play();

    emit(AppAudioPlay(appSound: appSound));
  }

  Future<void> playMessage() async => playSound(AppSound.message);

  Future<void> playDriverDelivery() async => playSound(AppSound.driverDelivery);

  Future<void> playUserPickup() async => playSound(AppSound.userPickup);
}
