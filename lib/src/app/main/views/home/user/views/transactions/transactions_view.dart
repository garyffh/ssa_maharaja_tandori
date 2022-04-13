import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_document_type.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'transactions_bloc.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsBloc(
        transactionsRepo: RepositoryProvider.of<TransactionsRepo>(context),
      )..add(TransactionsEventGetViewModel()),
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (viewContext, state) {
          return Column(
            children: [
              ViewTitleWidget(
                title: 'History',
                trailingWidget: _paymentFilterSwitch(viewContext, state),
              ),
              _view(viewContext, state),
            ],
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, TransactionsState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as TransactionsStateViewModel);
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
                    .read<TransactionsBloc>()
                    .add(TransactionsEventGetViewModel()),
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
    TransactionsStateViewModel viewModel,
  ) {
    return Expanded(
      child: viewModel.userTransactions.isEmpty
          ? const EmptyListWidget(label: 'No Transactions')
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.userTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(
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
                                    .sp(46),
                              ),
                              child: Text(
                                Formats.dayMonthYear(viewModel
                                    .userTransactions[index].documentDate),
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
                                    .sp(38),
                              ),
                              child: Text(
                                viewModel
                                    .userTransactions[index].documentType.text,
                                style: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .bodyText1,
                              ),
                            ),
                            Text(
                              viewModel
                                  .userTransactions[index].documentReference,
                              style: viewContext
                                  .watch<MediaSettingsBloc>()
                                  .state
                                  .bodyText1,
                            ),
                          ],
                        ),
                        IconButton(
                            iconSize: viewContext
                                .watch<MediaSettingsBloc>()
                                .state
                                .sp20,
                            icon: const Icon(
                              Icons.navigate_next,
                            ),
                            onPressed: () {
                              if (viewModel
                                      .userTransactions[index].documentType ==
                                  UserDocumentType.invoice) {
                                viewContext
                                    .read<HomeNavCubit>()
                                    .showInvoiceDetail(
                                      viewModel
                                          .userTransactions[index].documentId,
                                    );
                              } else if (viewModel
                                      .userTransactions[index].documentType ==
                                  UserDocumentType.credit) {
                                viewContext
                                    .read<HomeNavCubit>()
                                    .showCreditDetail(
                                      viewModel
                                          .userTransactions[index].documentId,
                                    );
                              } else {
                                viewContext
                                    .read<HomeNavCubit>()
                                    .showPaymentDetail(
                                      viewModel
                                          .userTransactions[index].documentId,
                                    );
                              }
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget? _paymentFilterSwitch(
      BuildContext viewContext, TransactionsState state) {
    return (state is TransactionsStateViewModel)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Text(
                  'PAYMENTS',
                  style: viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .titleActionTextStyle,
                  softWrap: false,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                ),
              Transform.scale(
                scale: viewContext.watch<MediaSettingsBloc>().state.sp(4),
                child: Switch(
                  value: state.showPayments,
                  onChanged: (value) => viewContext
                      .read<TransactionsBloc>()
                      .add(TransactionsEventUpdatePaymentFilter(
                          showPayments: value)),
                ),
              ),
            ],
          )
        : null;
  }
}
