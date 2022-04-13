import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/user/suggest_address_result.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/models/user/validated_address_result.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class AddressRepo extends AppRepo {
  AddressRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<SuggestAddressResult> readSuggestedAddresses({
    required String query,
  }) async {
    return SuggestAddressResult.fromJson(
      await httpPostJsonDecode(
        controllerSegment: 'address/search',
        apiSegment: null,
        multiStoreUrlOverride: true,
        jsonObject: Uri.encodeComponent(query),
      ),
    );
  }

  Future<ValidatedAddressResult> validateAddress({
    required String id,
  }) async {
    return ValidatedAddressResult.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'address/validate',
        apiSegment: Uri.encodeComponent(id),
      ),
    );
  }

  Future<UserAddress> findAddress() async {
    return UserAddress.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/address',
        apiSegment: null,
        multiStoreUrlOverride: true,
      ),
    );
  }

  Future<UserAddress> updateAddress({
    required UserAddress userAddress,
  }) async {
    return UserAddress.fromJson(
      await httpPutJsonDecode(
        controllerSegment: 'store-user/address',
        apiSegment: null,
        multiStoreUrlOverride: true,
        jsonObject: userAddress,
      ),
    );
  }
}
