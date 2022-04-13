import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_state.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/confirmation_dialog.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/title_action_button.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view_scroll.dart';

class PaymentMethodsView extends StatefulWidget {
  const PaymentMethodsView({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodsBloc(
        paymentMethodRepo: context.read<PaymentMethodRepo>(),
      )..add(PaymentMethodsEventGetViewModel()),
      child: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
        builder: (viewContext, state) {
          return SubViewScroll(
            title: 'Payment Methods',
            child: _view(viewContext, state),
            trailingWidget: state.type == ProgressErrorStateType.loaded
                ? TitleActionButton(
                    onPressed: () => viewContext
                        .read<MyAccountNavCubit>()
                        .showPaymentMethodAdd(),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, PaymentMethodsState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(viewContext, viewState as PaymentMethodsStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<PaymentMethodsBloc>()
                .add(PaymentMethodsEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: null,
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    PaymentMethodsStateViewModel viewModel,
  ) {
    return viewModel.paymentMethods.isEmpty
        ? const EmptyListWidget(label: 'No Payment Methods')
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: viewModel.paymentMethods.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    viewModel.paymentMethods[index].name,
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.subtitle1,
                  ),
                  trailing:
                      _popupMenu(viewContext, viewModel.paymentMethods[index]),
                ),
              );
            },
          );
  }

  Widget _popupMenu(
    BuildContext viewContext,
    UserPaymentMethod userPaymentMethod,
  ) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: 1,
            child: Text('Make Default'),
          ),
          PopupMenuItem(
            value: 2,
            child: Text('Remove'),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 1:
              _showSetDefaultConfirmationDialog(viewContext, userPaymentMethod);
              break;

            case 2:
              _showRemoveConfirmationDialog(viewContext, userPaymentMethod);
              break;
          }
        },
      );

  void _showSetDefaultConfirmationDialog(
    BuildContext viewContext,
    UserPaymentMethod userPaymentMethod,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Default Payment Method',
              content: 'Confirm making this the default payment method.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<PaymentMethodsBloc>().add(
                  PaymentMethodsEventDefault(
                        userPaymentMethod: userPaymentMethod,
                      ),
                    );
              },
            );
          });

  void _showRemoveConfirmationDialog(
    BuildContext viewContext,
    UserPaymentMethod userPaymentMethod,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Remove Payment Method',
              content: 'Confirm removing the payment method.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<PaymentMethodsBloc>().add(
                      PaymentMethodsEventDelete(
                        userPaymentMethod: userPaymentMethod,
                      ),
                    );
              },
            );
          });
}
