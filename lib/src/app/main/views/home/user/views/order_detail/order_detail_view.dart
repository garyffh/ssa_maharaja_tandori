import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/orders_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';
import 'package:single_store_app/src/app/widgets/view/trn_order_view.dart';

import 'order_detail_bloc.dart';
import 'order_detail_event.dart';
import 'order_detail_state.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({
    required this.trnOrderId,
    Key? key,
  }) : super(key: key);

  final String trnOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailBloc(
        ordersRepo: RepositoryProvider.of<OrdersRepo>(context),
        trnOrderMessagingBloc: BlocProvider.of<TrnOrderMessagingBloc>(context),
        appMessagingCubit: BlocProvider.of<AppMessagingCubit>(context),
      )..add(OrderDetailEventGetViewModel(trnOrderId: trnOrderId)),
      child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (viewContext, state) {
          return SubView(
            title: 'Order',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, OrderDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return TrnOrderView(
            trnOrder: (viewState as OrderDetailStateViewModel).trnOrder,
          );
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<OrderDetailBloc>()
                .add(OrderDetailEventGetViewModel(trnOrderId: trnOrderId)),
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

}
