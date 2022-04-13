import 'package:single_store_app/src/app/initial/initial_state.dart';
import 'package:single_store_app/src/app/initial/initial_store.dart';

import 'store_settings.dart';

class MultiStoreSettings {
  const MultiStoreSettings({
    required this.applicationName,
    required this.theme,
    required this.newAccounts,
    required this.signInRequired,
    required this.hasEnterpriseApp,
    required this.isMultiStore,
    required this.stores,
  });

  MultiStoreSettings.fromInitialState(InitialStateLoaded instance)
      : applicationName = instance.applicationName,
        theme = instance.theme,
        newAccounts = instance.newAccounts,
        signInRequired = instance.signInRequired,
        hasEnterpriseApp = instance.hasEnterpriseApp,
        isMultiStore = instance.isMultiStore,
        stores = storesFromInitialStores(
            isMultiStore: instance.isMultiStore,
            initialStores: instance.stores);

  MultiStoreSettings.clone(MultiStoreSettings instance)
      : applicationName = instance.applicationName,
        theme = instance.theme,
        newAccounts = instance.newAccounts,
        signInRequired = instance.signInRequired,
        hasEnterpriseApp = instance.hasEnterpriseApp,
        isMultiStore = instance.isMultiStore,
        stores = storesFromStoreSettings(storeSettings: instance.stores);

  final String applicationName;
  final String theme;
  final bool newAccounts;
  final bool signInRequired;
  final bool hasEnterpriseApp;
  final bool isMultiStore;

  final List<StoreSettings> stores;

  static List<StoreSettings> storesFromInitialStores({
    required bool isMultiStore,
    required List<InitialStore> initialStores,
  }) {
    return List<StoreSettings>.generate(
      initialStores.length,
      (index) => StoreSettings.fromInitialStore(
          isMultiStore: isMultiStore, instance: initialStores[index]),
    );
  }

  static List<StoreSettings> testStoresFromInitialStores({
    required bool isMultiStore,
    required List<InitialStore> initialStores,
  }) {
    final List<StoreSettings> rtn = List.empty(growable: true);

    for (var i = 0; i < 10; i++) {
      rtn.addAll(List<StoreSettings>.generate(
        initialStores.length,
        (index) => StoreSettings.fromInitialStore(
            isMultiStore: isMultiStore, instance: initialStores[index]),
      ));
    }

    return rtn;
  }

  static List<StoreSettings> storesFromStoreSettings({
    required List<StoreSettings> storeSettings,
  }) {
    return List<StoreSettings>.generate(
      storeSettings.length,
      (index) => StoreSettings.clone(storeSettings[index]),
    );
  }
}
