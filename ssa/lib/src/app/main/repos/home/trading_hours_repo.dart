import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/business/delivery_period_read.dart';
import 'package:single_store_app/src/app/models/business/delivery_time_read.dart';
import 'package:single_store_app/src/app/models/business/store_time_read.dart';
import 'package:single_store_app/src/app/models/business/store_trading_exception_read.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class TradingHoursRepo extends AppRepo {
  TradingHoursRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
    appRepoCubit: appRepoCubit,
    multiStoreUrl: true,
  );

  Future<List<StoreTimeRead>> allStoreTimes() async {
    return httpGetJsonDecodeListModel<StoreTimeRead>(
      controllerSegment: 'store-time',
      apiSegment: null,
      fromJson: (m) => StoreTimeRead.fromJson(m),
    );
  }

  Future<List<DeliveryTimeRead>> allDeliveryTimes() async {
    return httpGetJsonDecodeListModel<DeliveryTimeRead>(
      controllerSegment: 'delivery-time',
      apiSegment: null,
      fromJson: (m) => DeliveryTimeRead.fromJson(m),
    );
  }

  Future<List<DeliveryPeriodRead>> allDeliveryPeriods() async {
    return httpGetJsonDecodeListModel<DeliveryPeriodRead>(
      controllerSegment: 'delivery-period',
      apiSegment: null,
      fromJson: (m) => DeliveryPeriodRead.fromJson(m),
    );
  }

  Future<List<StoreTradingExceptionRead>> allTradingExceptions() async {
    return httpGetJsonDecodeListModel<StoreTradingExceptionRead>(
      controllerSegment: 'store-trading-exception',
      apiSegment: null,
      fromJson: (m) => StoreTradingExceptionRead.fromJson(m),
    );
  }

}
