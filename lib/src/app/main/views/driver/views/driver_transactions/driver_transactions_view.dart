import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/driver/driver_document_type.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'driver_transactions_bloc.dart';
import 'driver_transactions_event.dart';
import 'driver_transactions_state.dart';

class DriverTransactionsView extends StatelessWidget {
  const DriverTransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverTransactionsBloc(
        driverRepo: RepositoryProvider.of<DriverRepo>(context),
      )..add(DriverTransactionsEventGetViewModel()),
      child: BlocBuilder<DriverTransactionsBloc, DriverTransactionsState>(
        builder: (viewContext, state) {
          return Column(
            children: [
              const ViewTitleWidget(
                title: 'Transactions',
              ),
              _view(viewContext, state),
            ],
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, DriverTransactionsState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverTransactionsStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return Expanded(
            child: Center(
              child: ProgressErrorWidget(
                progressErrorState: viewState,
                dataDirection: DataDirection.receiving,
                tryAgainCallback: () => viewContext
                    .read<DriverTransactionsBloc>()
                    .add(DriverTransactionsEventGetViewModel()),
              ),
            ),
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
    BuildContext viewContext,
    DriverTransactionsStateViewModel viewModel,
  ) {
    return Expanded(
      child: viewModel.driverTransactions.isEmpty
          ? const EmptyListWidget(label: 'No Transactions')
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.driverTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          viewContext.watch<MediaSettingsBloc>().state.sp16,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,

                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                minWidth: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .sp(48),
                              ),
                              child: Text(
                                Formats.dayMonthTime(viewModel
                                    .driverTransactions[index].documentDT),
                                style: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .bodyText1,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                minWidth: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .sp(52),
                              ),
                              child: Text(
                                '${viewModel.driverTransactions[index].documentType.text} ${viewModel.driverTransactions[index].documentReference}',
                                style: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .bodyText1,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize:
                              viewContext.watch<MediaSettingsBloc>().state.sp20,
                          icon: const Icon(
                            Icons.navigate_next,
                          ),
                          onPressed: () {
                            if (viewModel
                                    .driverTransactions[index].documentType ==
                                DriverDocumentType.invoice) {
                              viewContext
                                  .read<DriverNavCubit>()
                                  .showInvoiceDetail(viewModel
                                      .driverTransactions[index].documentId);
                            } else {
                              viewContext
                                  .read<DriverNavCubit>()
                                  .showPaymentDetail(viewModel
                                      .driverTransactions[index].documentId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
