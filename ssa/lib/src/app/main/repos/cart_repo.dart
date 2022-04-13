import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';
import 'package:single_store_app/src/app/models/products/condiment_chain.dart';
import 'package:single_store_app/src/app/models/products/condiment_table.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class CartRepo extends AppRepo {
  CartRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<CondimentChain> findCondimentChain({
    required String sysCondimentChainId,
  }) async {
    return CondimentChain.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'condiment-chain/detail',
        apiSegment: sysCondimentChainId,
      ),
    );
  }

  Future<CondimentTable> findCondimentTable({
    required String sysCondimentTableId,
  }) async {
    return CondimentTable.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'condiment-table',
        apiSegment: sysCondimentTableId,
      ),
    );
  }

  Future<SitemDetail> findSitemDetail({
    required String sysSitemId,
  }) async {
    return SitemDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'sitem/detail',
        apiSegment: sysSitemId,
      ),
    );
  }

  Future<List<UserPaymentMethodRead>> readUserPaymentMethods() async {
    return httpGetJsonDecodeListModel<UserPaymentMethodRead>(
      controllerSegment: 'user/payment-methods',
      apiSegment: null,
      fromJson: (m) => UserPaymentMethodRead.fromJson(m),
    );
  }
}
