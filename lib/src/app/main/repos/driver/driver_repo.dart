import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/driver/driver_deliveries.dart';
import 'package:single_store_app/src/app/models/driver/driver_enable_deliveries.dart';
import 'package:single_store_app/src/app/models/driver/driver_invoice.dart';
import 'package:single_store_app/src/app/models/driver/driver_payment.dart';
import 'package:single_store_app/src/app/models/driver/driver_transaction.dart';
import 'package:single_store_app/src/app/models/driver/driver_transaction_read_option.dart';
import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery_action.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class DriverRepo extends AppRepo {
  DriverRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<DriverEnableDeliveries> findDriverEnableDeliveries() async {
    return DriverEnableDeliveries.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/enable-deliveries',
        apiSegment: null,
      ),
    );
  }

  Future<List<DriverTransaction>> readDriverTransactions({
    required DriverTransactionReadOption driverTransactionReadOption,
  }) async {
    return httpPutJsonDecodeListModel<DriverTransaction>(
      controllerSegment: 'driver/transactions',
      apiSegment: null,
      fromJson: (m) => DriverTransaction.fromJson(m),
      jsonObject: driverTransactionReadOption,
    );
  }

  Future<DriverInvoice> findDriverInvoiceDetail({
    required String documentId,
  }) async {
    return DriverInvoice.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/invoice',
        apiSegment: documentId,
      ),
    );
  }

  Future<DriverPayment> findDriverPaymentDetail({
    required String documentId,
  }) async {
    return DriverPayment.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/payment',
        apiSegment: documentId,
      ),
    );
  }

  Future<List<DriverVehicle>> readDriverVehicles() async {
    return httpGetJsonDecodeListModel<DriverVehicle>(
      controllerSegment: 'user/cars',
      apiSegment: null,
      multiStoreUrlOverride: true,
      fromJson: (m) => DriverVehicle.fromJson(m),
    );
  }

  Future<void> addDriverVehicle({required DriverVehicle content}) async {
    await httpPost(
      controllerSegment: 'user/car',
      apiSegment: null,
      multiStoreUrlOverride: true,
      jsonObject: content,
    );
  }

  Future<void> currentDriverVehicle({required DriverVehicle content}) async {
    await httpPost(
      controllerSegment: 'user/car-current',
      apiSegment: null,
      multiStoreUrlOverride: true,
      jsonObject: content,
    );
  }

  Future<void> deleteDriverVehicle({required DriverVehicle content}) async {
    await httpPost(
      controllerSegment: 'user/car-delete',
      apiSegment: null,
      multiStoreUrlOverride: true,
      jsonObject: content,
    );
  }

  Future<DriverDeliveries> getDriverDeliveries() async {
    return DriverDeliveries.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/deliveries',
        apiSegment: null,
      ),
    );
  }

  Future<void> disableDeliveries() async {
    await httpPut(
      controllerSegment: 'driver/disable-deliveries',
      apiSegment: null,
    );
  }

  Future<void> enableDeliveries() async {
    await httpPut(
      controllerSegment: 'driver/enable-deliveries',
      apiSegment: null,
    );
  }

  Future<TrnDelivery> findDriverDelivery(String id) async {
    return TrnDelivery.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/delivery',
        apiSegment: id,
      ),
    );
  }

  // TODO(Gary): remove multiStoreOveride
  Future<TrnDeliveryAction> deliveryPickedUp(String id) async {
    return TrnDeliveryAction.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/drive',
        apiSegment: id,
        multiStoreUrlOverride: true,
      ),
    );
  }

  // TODO(Gary): remove multiStoreOveride
  Future<TrnDeliveryAction> deliveryDelivered(String id) async {
    return TrnDeliveryAction.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'driver/deliver',
        apiSegment: id,
        multiStoreUrlOverride: true,
      ),
    );
  }
}
