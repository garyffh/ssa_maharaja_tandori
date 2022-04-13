import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';

abstract class BusinessSettingsEvent {}

class BusinessSettingsEventUpdate extends BusinessSettingsEvent {
  BusinessSettingsEventUpdate({required this.storeSettings});

  final StoreSettings storeSettings;

}
