import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/initial/initial_state.dart';
import 'package:single_store_app/src/app/models/multi_store/multi_store_settings.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';

enum BusinessSelectStateType { pending, loaded, selected }

@immutable
abstract class BusinessSelectState {
  const BusinessSelectState({
    required this.type,
  });

  final BusinessSelectStateType type;

  bool get isMultiStore => false;
  bool get isSelected => false;
  String get title => '';
  String get selectedBusinessIdentity => '';
  StoreSettings? get selectedStore => null;
}

class BusinessSelectStatePending extends BusinessSelectState {
  const BusinessSelectStatePending()
      : super(type: BusinessSelectStateType.pending);
}

abstract class BusinessSelectStateView extends BusinessSelectState {
  const BusinessSelectStateView({
    required this.multiStoreSettings,
    required BusinessSelectStateType type,
  }) : super(type: type);

  final MultiStoreSettings multiStoreSettings;

  @override
  String get title => multiStoreSettings.applicationName;

  @override
  bool get isMultiStore => multiStoreSettings.isMultiStore;

}

class BusinessSelectStateLoaded extends BusinessSelectStateView {
  const BusinessSelectStateLoaded({
    required MultiStoreSettings multiStoreSettings,
  }) : super(
          multiStoreSettings: multiStoreSettings,
          type: BusinessSelectStateType.loaded,
        );

  BusinessSelectStateLoaded.fromServerBusiness(InitialStateLoaded instance)
      : super(
            multiStoreSettings: MultiStoreSettings.fromInitialState(instance),
            type: BusinessSelectStateType.loaded);


  @override
  bool get isSelected => false;

  @override
  StoreSettings? get selectedStore => null;
}

class BusinessSelectStateSelected extends BusinessSelectStateView {
  const BusinessSelectStateSelected({
    required MultiStoreSettings multiStoreSettings,
    required this.selectedIdentity,
  }) : super(
          multiStoreSettings: multiStoreSettings,
          type: BusinessSelectStateType.selected,
        );

  final String selectedIdentity;

  @override
  bool get isSelected => true;

  @override
  String get selectedBusinessIdentity => selectedStore == null ? '' : selectedStore!.businessIdentity;

  @override
  StoreSettings? get selectedStore =>
      multiStoreSettings.stores.firstWhereOrNull(
          (element) => element.businessIdentity == selectedIdentity);
}
