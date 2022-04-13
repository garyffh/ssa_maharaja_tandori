import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

@immutable
class StorageState {
  const StorageState({
    this.businessIdentity,
  });

  StorageState.fromBusinessSettings(BusinessSettingsState businessSettingsState)
      : businessIdentity =
            businessSettingsState.type == BusinessSettingStateType.loaded
                ? (businessSettingsState as BusinessSettingsStateLoaded)
                    .businessIdentity
                : null;

  final String? businessIdentity;
}
