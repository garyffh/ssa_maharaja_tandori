import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/user/credit_detail.dart';
import 'package:single_store_app/src/app/models/user/invoice_detail.dart';
import 'package:single_store_app/src/app/models/user/payment_detail.dart';
import 'package:single_store_app/src/app/models/user/user_transaction.dart';
import 'package:single_store_app/src/app/models/user/user_transaction_read_option.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class TransactionsRepo extends AppRepo {
  TransactionsRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<List<UserTransaction>> readUserTransactions(
    UserTransactionReadOption userTransactionReadOption,
  ) async {
    return httpPutJsonDecodeListModel<UserTransaction>(
      controllerSegment: 'user/user-transaction',
      apiSegment: null,
      fromJson: (m) => UserTransaction.fromJson(m),
      jsonObject: userTransactionReadOption,
    );
  }

  Future<InvoiceDetail> findInvoiceDetail(String documentId) async {
    return InvoiceDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/user-transaction/invoice',
        apiSegment: documentId,
        multiStoreUrlOverride: true,
      ),
    );
  }

  Future<CreditDetail> findCreditDetail(String documentId) async {
    return CreditDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/user-transaction/credit',
        apiSegment: documentId,
        multiStoreUrlOverride: true,
      ),
    );
  }

  Future<PaymentDetail> findPaymentDetail(String documentId) async {
    return PaymentDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/user-transaction/payment',
        apiSegment: documentId,
        multiStoreUrlOverride: true,
      ),
    );
  }
}
