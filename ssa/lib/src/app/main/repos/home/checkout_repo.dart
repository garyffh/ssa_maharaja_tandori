import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_order.dart';
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';
import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class CheckoutRepo extends AppRepo {
  CheckoutRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<UserBillingClient> getUserBillingClient() async {
    return UserBillingClient.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/billing-client',
        apiSegment: null,
      ),
    );
  }

  Future<TrnOrder> sendOrderWithPayment(
      {required TrnCheckoutOrder content}) async {
    return TrnOrder.fromJson(
      await httpPostJsonDecode(
        controllerSegment: 'checkout/invoice-with-payment',
        apiSegment: null,
        multiStoreUrlOverride: true,
        jsonObject: content,
      ),
    );
  }

  Future<TrnOrder> sendOrderNoPayment(
      {required TrnCheckoutOrder content}) async {
    return TrnOrder.fromJson(
      await httpPostJsonDecode(
        controllerSegment: 'checkout/invoice-no-payment',
        apiSegment: null,
        multiStoreUrlOverride: true,
        jsonObject: content,
      ),
    );
  }

  Future<TrnOrder> findTrnOrder(String trnOrderId) async {
    return TrnOrder.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'trn-order',
        apiSegment: trnOrderId,
      ),
    );
  }

  Future<List<UserPaymentMethodRead>> readUserPaymentMethods(
      {bool consolePrint = false}) async {
    return httpGetJsonDecodeListModel<UserPaymentMethodRead>(
      controllerSegment: 'user/payment-methods',
      apiSegment: null,
      fromJson: (m) => UserPaymentMethodRead.fromJson(m),
    );
  }
}
