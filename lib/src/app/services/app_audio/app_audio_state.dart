import 'package:meta/meta.dart';

enum AppSound {
  none,
  message,
  driverDelivery,
  userPickup
}

@immutable
abstract class AppAudioState {
  const AppAudioState({
    required this.appSound,
  });


  final AppSound appSound;

}

class AppAudioStateInitial extends AppAudioState {
   const AppAudioStateInitial() : super(appSound: AppSound.none);
}

class AppAudioPlay extends AppAudioState {
   const AppAudioPlay({
     required AppSound appSound,
  }) : super(appSound: appSound);

}

