import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/storage_key.constants.dart';
import 'package:single_store_app/src/app/models/cart/cart_store.dart';
import 'package:single_store_app/src/app/repos/storage_repo.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';
import 'package:single_store_app/src/app/services/storage/storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit({
    required this.storageRepo,
    required this.businessSettingsBloc,
  }) : super(StorageState.fromBusinessSettings(businessSettingsBloc.state)) {
    businessSettingsSubscription =
        businessSettingsBloc.stream.listen((businessSettingsState) {
      if (businessSettingsState is BusinessSettingsStateLoaded) {
        emit(StorageState(
            businessIdentity: businessSettingsState.businessIdentity));
      }
    });
  }

  final StorageRepo storageRepo;
  final BusinessSettingsBloc businessSettingsBloc;
  late StreamSubscription businessSettingsSubscription;

  /// Business Settings
  Future<void> saveBusinessName(String businessName) async =>
      storageRepo.setString(businessNameKey, businessName);

  Future<String?> getBusinessName() async =>
      storageRepo.getString(businessNameKey);

  /// Theme
  Future<void> saveTheme(String theme) async =>
      storageRepo.setString(themeKey, theme);

  Future<String?> getTheme() async => storageRepo.getString(themeKey);

  /// Access Token
  Future<bool> accessTokenExists() async =>
      storageRepo.keyExists('${state.businessIdentity}$accessTokenKey');

  Future<String?> getAccessToken() async =>
      storageRepo.getString('${state.businessIdentity}$accessTokenKey');

  Future<void> saveAccessToken(String accessToken) async => storageRepo
      .setString('${state.businessIdentity}$accessTokenKey', accessToken);

  Future<void> removeAccessToken() async =>
      storageRepo.removeKey('${state.businessIdentity}$accessTokenKey');

  /// Refresh Token
  Future<bool> refreshTokenExists() async =>
      storageRepo.keyExists('${state.businessIdentity}$refreshTokenKey');

  Future<String?> getRefreshToken() async =>
      storageRepo.getString('${state.businessIdentity}$refreshTokenKey');

  Future<void> saveRefreshToken(String refreshToken) async => storageRepo
      .setString('${state.businessIdentity}$refreshTokenKey', refreshToken);

  Future<void> removeRefreshToken() async =>
      storageRepo.removeKey('${state.businessIdentity}$refreshTokenKey');

  /// Cart
  Future<bool> cartExists() async =>
      storageRepo.keyExists('${state.businessIdentity}$cartKey');

  Future<CartStore> getCart() async {
    if (await cartExists()) {
      return CartStore.fromJson(jsonDecode((await storageRepo.getString(
          '${state.businessIdentity}$cartKey'))!) as Map<String, dynamic>);
    } else {
      return CartStore.empty();
    }
  }

  Future<void> saveCart(CartStore cartStore) async => storageRepo.setString(
      '${state.businessIdentity}$cartKey', jsonEncode(cartStore));

  @override
  Future<void> close() {
    businessSettingsSubscription.cancel();
    return super.close();
  }
}
