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

import 'driver_invoice_detail_bloc.dart';
import 'driver_invoice_detail_event.dart';
import 'driver_invoice_detail_state.dart';

class DriverInvoiceDetailView extends StatelessWidget {
  const DriverInvoiceDetailView({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverInvoiceDetailBloc(
        driverRepo: RepositoryProvider.of<DriverRepo>(context),
      )..add(DriverInvoiceDetailEventGetViewModel(documentId: documentId)),
      child: BlocBuilder<DriverInvoiceDetailBloc, DriverInvoiceDetailState>(
        builder: (viewContext, state) {
          return SubView(
            title: 'Invoice',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, DriverInvoiceDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverInvoiceDetailStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<DriverInvoiceDetailBloc>()
                .add(DriverInvoiceDetailEventGetViewModel(
                    documentId: documentId)),
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
    DriverInvoiceDetailStateViewModel viewModel,
  ) {
    return Container(
      padding:
          EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameValueWidget(
            name: 'Invoice #',
            value: viewModel.driverInvoice.documentReference,
          ),
          NameValueWidget(
            name: 'Date',
            value: Formats.dayMonthYearTime(viewModel.driverInvoice.documentDT),
          ),
          NameValueWidget(
            name: 'Total',
            value: Formats.currency(viewModel.driverInvoice.total),
          ),
          NameValueWidget(
            name: 'Balance',
            value: Formats.currency(viewModel.driverInvoice.balance),
          ),
        ],
      ),
    );
  }
}
