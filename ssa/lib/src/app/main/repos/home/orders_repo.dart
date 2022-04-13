import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/models/order/trn_order_read.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class OrdersRepo extends AppRepo {
  OrdersRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
    appRepoCubit: appRepoCubit,
    multiStoreUrl: true,
  );

  Future<List<TrnOrderRead>> readTrnOrders() async {
    return httpGetJsonDecodeListModel<TrnOrderRead>(
      controllerSegment: 'trn-order',
      apiSegment: null,
      fromJson: (m) => TrnOrderRead.fromJson(m),
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


}
