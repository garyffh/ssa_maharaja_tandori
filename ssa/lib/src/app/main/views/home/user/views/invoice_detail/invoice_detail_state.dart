import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/user/invoice_detail.dart';

@immutable
abstract class InvoiceDetailState extends ProgressErrorState {
  const InvoiceDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class InvoiceDetailStateInitial extends InvoiceDetailState {
  const InvoiceDetailStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class InvoiceDetailStateLoadingError extends InvoiceDetailState {
  const InvoiceDetailStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class InvoiceDetailStateViewModel extends InvoiceDetailState {
  const InvoiceDetailStateViewModel({
    required this.invoiceDetail,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final InvoiceDetail invoiceDetail;


}
