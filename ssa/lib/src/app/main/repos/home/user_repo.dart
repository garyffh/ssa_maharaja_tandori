import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/user/user_password_update.dart';
import 'package:single_store_app/src/app/models/user/user_phone_update.dart';
import 'package:single_store_app/src/app/models/user/user_phone_verify.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class UserRepo extends AppRepo {
  UserRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: false,
        );

  Future<UserPhoneVerify> phoneVerify({
    required UserPhoneVerify userPhoneVerify,
  }) async {
    return UserPhoneVerify.fromJson(
      await httpPutJsonDecode(
        controllerSegment: 'user/phone-verify',
        apiSegment: null,
        jsonObject: userPhoneVerify,
      ),
    );
  }

  Future<void> phoneUpdate({
    required UserPhoneUpdate userPhoneUpdate,
  }) async {
    await httpPutJsonDecode(
      controllerSegment: 'store-user/phone-update',
      apiSegment: null,
      jsonObject: userPhoneUpdate,
    );
  }

  Future<void> passwordUpdate({
    required UserPasswordUpdate userPasswordUpdate,
  }) async {
    await httpPutJsonDecode(
      controllerSegment: 'user/change-password',
      apiSegment: null,
      jsonObject: userPasswordUpdate,
    );
  }
}
