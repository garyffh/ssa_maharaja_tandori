import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/address_update_widget.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/checkout_address_edit.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/checkout_message_widget.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/address_result.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

import 'checkout_address_bloc.dart';
import 'checkout_address_event.dart';
import 'checkout_address_state.dart';
import 'models/checkout_address_view_type.dart';

class CheckoutAddressView extends StatelessWidget {
  const CheckoutAddressView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutAddressBloc(
        checkoutNavCubit: context.read<CheckoutNavCubit>(),
        checkoutBloc: context.read<CheckoutBloc>(),
        checkoutStepperBloc: context.read<CheckoutStepperBloc>(),
        businessSettingsBloc: context.read<BusinessSettingsBloc>(),
      )..add(CheckoutAddressEventGetViewModel()),
      child: BlocBuilder<CheckoutAddressBloc, CheckoutAddressState>(
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, CheckoutAddressState viewState) {

    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as CheckoutAddressStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutAddressBloc>()
                .add(CheckoutAddressEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {

          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => viewContext
                .read<CheckoutAddressBloc>()
                .add(CheckoutAddressEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    CheckoutAddressStateViewModel viewModel,
  ) {

    switch (viewModel.checkoutAddressViewType) {
      case CheckoutAddressViewType.view:
        {
          viewContext.read<AppFloatingButtonCubit>().showFloatingButtons(
            buttons: [
              _backButton(viewContext, viewModel),
              _continueButton(viewContext, viewModel),
            ],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );

          return _addressView(
            viewContext,
            viewModel,
          );
        }

      case CheckoutAddressViewType.update:
        {
          viewContext.read<AppFloatingButtonCubit>().showFloatingButtons(
            buttons: [
              _backButton(viewContext, viewModel),
            ],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );

          return _addressUpdate(viewContext, viewModel);
          //   Column(
          //   children: [
          //     _addressUpdate(viewContext, viewModel),
          //     const SizedBox(height: 40.0),
          //   ],
          // );
        }
    }
  }

  Widget _addressView(
    BuildContext viewContext,
    CheckoutAddressStateViewModel viewModel,
  ) {
    if (viewModel.validAddressDistance) {
      return CheckoutAddressEdit(
        trnCheckoutAddress: viewModel.trnCheckoutAddress,
        onEdit: () {
          viewContext
              .read<CheckoutAddressBloc>()
              .add(CheckoutAddressEventShowUpdate());
        },
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CheckoutAddressEdit(
            trnCheckoutAddress: viewModel.trnCheckoutAddress,
            onEdit: () {
              viewContext
                  .read<CheckoutAddressBloc>()
                  .add(CheckoutAddressEventShowUpdate());
            },
          ),
          const CheckoutMessageWidget(
              message: ['SORRY, THIS ADDRESS IS NOT IN OUR DELIVERY AREA!'],
              error: true),
        ],
      );
    }
  }

  Widget _addressUpdate(
    BuildContext viewContext,
    CheckoutAddressStateViewModel viewModel,
  ) {
    return AddressUpdateWidget(
      saveAddress: false,
      showCompany: false,
      onValidateAddress: (AddressResult address) {
        viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();
      },
      onSubmitAddress: (UserAddress address) {
        viewContext.read<CheckoutAddressBloc>().add(
              CheckoutAddressEventUpdate(
                address: address,
              ),
            );
      },
    );
  }

  Widget _continueButton(
    BuildContext viewContext,
    CheckoutAddressStateViewModel viewModel,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'CONTINUE',
        iconData: Icons.arrow_right,
        onPressed: viewModel.trnCheckoutAddress == null ||
                !viewModel.validAddressDistance
            ? null
            : () => viewContext
                .read<CheckoutAddressBloc>()
                .add(CheckoutAddressEventSubmit()),
      ),
    );
  }

  Widget _backButton(
    BuildContext viewContext,
    CheckoutAddressStateViewModel viewModel,
  ) {
    switch (viewModel.checkoutAddressViewType) {
      case CheckoutAddressViewType.view:
        {
          return ElevatedActionButton(
            text: 'BACK',
            iconData: Icons.arrow_left,
            onPressed: () => viewContext
                .read<CheckoutStepperBloc>()
                .add(CheckoutStepperEventBack()),
          );
        }

      case CheckoutAddressViewType.update:
        {
          if (viewModel.trnCheckoutAddress == null) {
            return ElevatedActionButton(
              text: 'BACK',
              iconData: Icons.arrow_left,
              onPressed: () => viewContext
                  .read<CheckoutStepperBloc>()
                  .add(CheckoutStepperEventBack()),
            );
          } else {
            return ElevatedActionButton(
              text: 'BACK',
              iconData: Icons.arrow_left,
              onPressed: () => viewContext
                  .read<CheckoutAddressBloc>()
                  .add(CheckoutAddressEventShowView()),
            );
          }
        }
    }
  }
}
