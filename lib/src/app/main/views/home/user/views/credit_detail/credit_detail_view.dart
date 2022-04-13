import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/credit_detail_item.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/line_description_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_qty_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_total_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';


import 'credit_detail_bloc.dart';
import 'credit_detail_event.dart';
import 'credit_detail_state.dart';

class CreditDetailView extends StatelessWidget {
  const CreditDetailView({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditDetailBloc(
        transactionsRepo: RepositoryProvider.of<TransactionsRepo>(context),
      )..add(CreditDetailEventGetViewModel(documentId: documentId)),
      child: BlocBuilder<CreditDetailBloc, CreditDetailState>(
        builder: (viewContext, state) {
          return SubView(
            title: 'Credit',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, CreditDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as CreditDetailStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CreditDetailBloc>()
                .add(CreditDetailEventGetViewModel(documentId: documentId)),
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
      CreditDetailStateViewModel viewModel,
      ) {
    return Container(
      padding:
      EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        children: [
          _header(context, viewModel),
          const Divider(),
          _lines(context, viewModel),
        ],
      ),
    );
  }

  Widget _header(
      BuildContext viewContext,
      CreditDetailStateViewModel viewModel,
      ) {

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              NameValueWidget(
                name: 'Credit #',
                value: viewModel.creditDetail.documentReference,
              ),
              NameValueWidget(
                name: 'Total',
                value: Formats.currency(viewModel.creditDetail.total),
                alignment: WrapAlignment.end,
              ),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              NameValueWidget(
                name: 'Date',
                value:
                Formats.dayMonthYear(viewModel.creditDetail.documentDate),
                alignment: WrapAlignment.end,
              ),
              NameValueWidget(
                name: 'GST',
                value: Formats.currency(viewModel.creditDetail.taxAmount),
                alignment: WrapAlignment.end,
              ),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              NameValueWidget(
                name: 'Source',
                value: viewModel.creditDetail.documentSource,
              ),
              if (viewModel.creditDetail.totalPoints != 0)
                NameValueWidget(
                  name: 'Points',
                  value: Formats.points(viewModel.creditDetail.totalPoints),
                ),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              NameValueWidget(
                name: 'Balance',
                value: Formats.currency(viewModel.creditDetail.displayBalance(viewContext.read<BusinessSettingsBloc>().state.multiStore)),
              ),
              if (viewModel.creditDetail.displayPointBalance(viewContext.read<BusinessSettingsBloc>().state.multiStore) != 0)
                NameValueWidget(
                  name: 'Points Balance',
                  value: Formats.points(viewModel.creditDetail.displayPointBalance(viewContext.read<BusinessSettingsBloc>().state.multiStore)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lines(
      BuildContext viewContext,
      CreditDetailStateViewModel viewModel,
      ) {
    final List<CreditDetailItem> readableItems = viewModel.creditDetail.readableItems();

    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(viewContext.watch<MediaSettingsBloc>().state.sp30),
        1: const FlexColumnWidth(),
        2: const IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: List<TableRow>.generate(readableItems.length,
              (index) {
            final CreditDetailItem item = readableItems[index];
            return TableRow(
              children: <Widget>[
                LineQtyCell(
                  show: item.itemTypeId == 3,
                  isScale: item.isScale,
                  qty: item.quantity,
                ),
                LineDescriptionCell(
                  isCondiment: item.isCondiment,
                  isInstructions: item.isInstructions,
                  description: item.description,
                ),
                LineTotalCell(
                  isCondiment: item.isCondiment,
                  total: item.total,
                ),
              ],
            );
          }),
    );
  }

}
