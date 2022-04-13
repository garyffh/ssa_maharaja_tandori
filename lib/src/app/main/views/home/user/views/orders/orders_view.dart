import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/orders_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'orders_bloc.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(
        ordersRepo: RepositoryProvider.of<OrdersRepo>(context),
        trnOrderMessagingBloc: BlocProvider.of<TrnOrderMessagingBloc>(context),
      )..add(OrdersEventGetViewModel()),
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (viewContext, state) {
          return Column(children: [
            const ViewTitleWidget(
              title: 'Current Orders',
            ),
            _view(viewContext, state),
          ]);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, OrdersState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(viewContext, viewState as OrdersStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return  Expanded(
              child: Center(
              child: ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () =>
                viewContext.read<OrdersBloc>().add(OrdersEventGetViewModel()),
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
    OrdersStateViewModel viewModel,
  ) {
    return Expanded(
      child: viewModel.trnOrders.isEmpty
          ? const EmptyListWidget(label: 'No Current Orders')
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.trnOrders.length,
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
                                Formats.dayMonthYear(
                                    viewModel.trnOrders[index].orderDT),
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
                                    .trnOrders[index].deliveryMethodStatus.text,
                                style: viewContext
                                    .watch<MediaSettingsBloc>()
                                    .state
                                    .bodyText1,
                              ),
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
                              viewContext.read<HomeNavCubit>().showOrderDetail(
                                    viewModel.trnOrders[index].trnOrderId,
                                  );
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
