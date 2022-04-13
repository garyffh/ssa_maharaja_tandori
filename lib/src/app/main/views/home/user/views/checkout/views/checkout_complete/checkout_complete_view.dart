import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';
import 'package:single_store_app/src/app/widgets/view/trn_order_view.dart';

import 'checkout_complete_bloc.dart';
import 'checkout_complete_event.dart';
import 'checkout_complete_state.dart';

class CheckoutCompleteView extends StatelessWidget {
  const CheckoutCompleteView({
    required this.trnOrder,
    Key? key,
  }) : super(key: key);

  final TrnOrder trnOrder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCompleteBloc(
        trnOrderMessagingBloc: context.read<TrnOrderMessagingBloc>(),
        appMessagingCubit: context.read<AppMessagingCubit>(),
        cartBloc: context.read<CartBloc>(),
      )..add(CheckoutCompleteEventGetViewModel(trnOrder: trnOrder)),
      child: BlocBuilder<CheckoutCompleteBloc, CheckoutCompleteState>(
        builder: (viewContext, state) {
          return PrimaryView(
            title: 'Order Submitted',
            // leadPadding: false,
            trailingWidget: Container(
              padding: EdgeInsets.only(
                  right: viewContext.watch<MediaSettingsBloc>().state.sp(24)),
              child: Icon(
                Icons.check_circle,
                size: viewContext.watch<MediaSettingsBloc>().state.sp22,
              ),
            ),
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, CheckoutCompleteState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return TrnOrderView(
            trnOrder: (viewState as CheckoutCompleteStateViewModel).trnOrder,
          );
        }

      case ProgressErrorStateType.initial:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
          );
        }

      case ProgressErrorStateType.loadingError:
      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }
}
