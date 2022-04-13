import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method_add.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class PaymentMethodRepo extends AppRepo {
  PaymentMethodRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<List<UserPaymentMethod>> readUserPaymentMethods() async {
    return httpGetJsonDecodeListModel<UserPaymentMethod>(
      controllerSegment: 'user/payment-methods',
      apiSegment: null,
      fromJson: (m) => UserPaymentMethod.fromJson(m),
    );
  }

  Future<UserPaymentMethod> findUserPaymentMethod({
    required String paymentMethodId,
  }) async {
    return UserPaymentMethod.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/payment-method-find',
        apiSegment: paymentMethodId,
      ),
    );
  }

  Future<void> addUserPaymentMethods({
    required UserPaymentMethodAdd content,
  }) async {
    await httpPost(
      controllerSegment: 'user/payment-method',
      apiSegment: null,
      multiStoreUrlOverride: true,
      jsonObject: content,
    );
  }

  Future<void> deleteUserPaymentMethod({
    required UserPaymentMethod content,
  }) async {
    await httpPost(
      controllerSegment: 'user/payment-method-delete',
      apiSegment: null,
      jsonObject: content,
    );
  }

  Future<void> defaultUserPaymentMethod({
    required UserPaymentMethod content,
  }) async {
    await httpPost(
      controllerSegment: 'user/payment-method-default',
      apiSegment: null,
      jsonObject: content,
    );
  }
}
