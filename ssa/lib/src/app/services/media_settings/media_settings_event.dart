import 'package:single_store_app/src/app/infrastructure/app_media_device.dart';

abstract class MediaSettingsEvent {}

class MediaSettingsEventUpdate extends MediaSettingsEvent {
  MediaSettingsEventUpdate({
    required this.appMediaDevice,
  });

  final AppMediaDevice appMediaDevice;

}

