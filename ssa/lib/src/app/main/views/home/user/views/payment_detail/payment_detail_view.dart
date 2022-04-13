import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method_type.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'payment_detail_bloc.dart';
import 'payment_detail_event.dart';
import 'payment_detail_state.dart';

class PaymentDetailView extends StatelessWidget {
  const PaymentDetailView({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentDetailBloc(
        transactionsRepo: RepositoryProvider.of<TransactionsRepo>(context),
      )..add(PaymentDetailEventGetViewModel(
          documentId: documentId,
        )),
      child: BlocBuilder<PaymentDetailBloc, PaymentDetailState>(
        builder: (viewContext, state) {
          return SubView(
            title: 'Payment',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, PaymentDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as PaymentDetailStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<PaymentDetailBloc>()
                .add(PaymentDetailEventGetViewModel(
                  documentId: documentId,
                )),
          );
        }

      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext context,
    PaymentDetailStateViewModel viewModel,
  ) {

    return Container(
      padding:
          EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameValueWidget(
            name: 'Payment #',
            value: viewModel.paymentDetail.documentReference,
          ),
          NameValueWidget(
            name: 'Date',
            value: Formats.dayMonthYear(viewModel.paymentDetail.documentDate),
          ),
          NameValueWidget(
            name: 'Payment Amount',
            value: Formats.currency(viewModel.paymentDetail.cardAmount),
          ),
          NameValueWidget(
            name: 'Method',
            value:
                '${viewModel.paymentDetail.userPaymentTypeId.text} ${viewModel.paymentDetail.userPaymentName}',
          ),
          NameValueWidget(
            name: 'Balance',
            value: Formats.currency(viewModel.paymentDetail.displayBalance(context.read<BusinessSettingsBloc>().state.multiStore)),
          ),
          if (viewModel.paymentDetail.redeemAmount != 0)
            NameValueWidget(
              name: 'Redeemed Amount',
              value: Formats.currency(viewModel.paymentDetail.redeemAmount),
            ),
          if (viewModel.paymentDetail.redeemPoints != 0)
            NameValueWidget(
              name: 'Points Redeemed',
              value: Formats.points(viewModel.paymentDetail.redeemPoints),
            ),
          if (viewModel.paymentDetail.displayPointBalance(context.read<BusinessSettingsBloc>().state.multiStore) != 0)
            NameValueWidget(
              name: 'Points Balance',
              value: Formats.points(viewModel.paymentDetail.displayPointBalance(context.read<BusinessSettingsBloc>().state.multiStore)),
            ),
          NameValueWidget(
              name: 'Message',
              value: viewModel.paymentDetail.paymentResponseMessage),
        ],
      ),
    );
  }
}
