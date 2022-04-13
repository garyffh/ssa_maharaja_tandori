import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'driver_payment_detail_bloc.dart';
import 'driver_payment_detail_event.dart';
import 'driver_payment_detail_state.dart';

class DriverPaymentDetailView extends StatelessWidget {
  const DriverPaymentDetailView({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverPaymentDetailBloc(
        driverRepo: RepositoryProvider.of<DriverRepo>(context),
      )..add(DriverPaymentDetailEventGetViewModel(documentId: documentId)),
      child: BlocBuilder<DriverPaymentDetailBloc, DriverPaymentDetailState>(
        builder: (viewContext, state) {
          return SubView(
            title: 'Payment',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, DriverPaymentDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<DriverPaymentDetailBloc>()
                .add(DriverPaymentDetailEventGetViewModel(
                    documentId: documentId)),
          );
        }

      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverPaymentDetailStateViewModel);
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
      case ProgressErrorStateType.progressError:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext context,
    DriverPaymentDetailStateViewModel viewModel,
  ) {
    return Container(
      padding:
          EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameValueWidget(
            name: 'Payment #',
            value: viewModel.driverPayment.documentReference,
          ),
          NameValueWidget(
            name: 'Date',
            value: Formats.dayMonthYearTime(viewModel.driverPayment.documentDT),
          ),
          NameValueWidget(
            name: 'Payment Amount',
            value: Formats.currency(viewModel.driverPayment.total),
          ),
          NameValueWidget(
            name: 'Balance',
            value: Formats.currency(viewModel.driverPayment.balance),
          ),
          NameValueWidget(
              name: 'Comment', value: viewModel.driverPayment.comment),
        ],
      ),
    );
  }
}
