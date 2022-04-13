import 'package:flutter/foundation.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/authentication/device_update.dart';
import 'package:single_store_app/src/app/models/authentication/email_sign_up.dart';
import 'package:single_store_app/src/app/models/authentication/password_reset.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';
import 'package:single_store_app/src/app/models/authentication/verify_email.dart';
import 'package:single_store_app/src/app/models/authentication/verify_email_result.dart';
import 'package:single_store_app/src/app/models/authentication/verify_password.dart';
import 'package:single_store_app/src/app/models/authentication/verify_password_result.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class AuthenticationRepo extends AppRepo {
  AuthenticationRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: false,
        );

  Future<ServerToken> signIn(String email, String password) async {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 14000));

    final Map<String, String> formData = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': PackageConstants.clientId,
    };

    return ServerToken.fromJson(
        await httpPostFormDataWithoutApiSegmentJsonDecode(
      urlSegment: 'token',
      formData: formData,
    ));
  }

  Future<ServerToken> refreshToken(String refreshToken) async {
    final Map<String, String> formData = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': PackageConstants.clientId,
    };

    return ServerToken.fromJson(
        await httpPostFormDataWithoutApiSegmentJsonDecode(
      urlSegment: 'token',
      formData: formData,
    ));
  }

  Future<void> deviceUpdate(String? token) async {
    if (!AppConstants.enabledMessagingPlatform) {
      return;
    }

    try {
      late int typeId;

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          typeId = 1;
          break;

        case TargetPlatform.iOS:
          typeId = 2;
          break;

        default:
          typeId = 0;
          break;
      }

      await httpPut(
        controllerSegment: 'user/device-update',
        apiSegment: null,
        jsonObject: DeviceUpdate(
          typeId: typeId,
          token: token,
          version: AppConstants.version,
        ),
      );
    } catch (_) {
      // ignore all errors
    }
  }

  Future<void> disableDevice() async {
    await deviceUpdate(null);
  }

  Future<VerifyEmailResult> verifyEmail({required VerifyEmail content}) async {
    return VerifyEmailResult.fromJson(
      await httpPostJsonDecode(
        controllerSegment: 'user/verify-email',
        apiSegment: null,
        jsonObject: content,
      ),
    );
  }

  Future<void> emailSignUp({required EmailSignUp content}) async {
    await httpPost(
      controllerSegment: 'store-user/email',
      apiSegment: null,
      jsonObject: content,
    );
  }

  Future<VerifyPasswordResult> verifyPassword(
      {required VerifyPassword content}) async {
    return VerifyPasswordResult.fromJson(
      await httpPutJsonDecode(
        controllerSegment: 'user/verify-password',
        apiSegment: null,
        jsonObject: content,
      ),
    );
  }

  Future<void> resetPassword({required PasswordReset content}) async {
    await httpPut(
      controllerSegment: 'user/reset-password',
      apiSegment: null,
      jsonObject: content,
    );
  }
}
