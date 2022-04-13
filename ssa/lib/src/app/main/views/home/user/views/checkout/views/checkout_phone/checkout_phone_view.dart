import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone_code/checkout_phone_code_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone_update/checkout_phone_update_view.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget_type.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

import 'checkout_phone_bloc.dart';
import 'checkout_phone_event.dart';
import 'checkout_phone_state.dart';
import 'models/checkout_phone_view_type.dart';

class CheckoutPhoneView extends StatelessWidget {
  const CheckoutPhoneView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutPhoneBloc(
        checkoutNavCubit: context.read<CheckoutNavCubit>(),
        checkoutBloc: context.read<CheckoutBloc>(),
        checkoutStepperBloc: context.read<CheckoutStepperBloc>(),
      )..add(CheckoutPhoneEventGetViewModel()),
      child: BlocBuilder<CheckoutPhoneBloc, CheckoutPhoneState>(
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, CheckoutPhoneState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as CheckoutPhoneStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutPhoneBloc>()
                .add(CheckoutPhoneEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => viewContext
                .read<CheckoutPhoneBloc>()
                .add(CheckoutPhoneEventGetViewModel()),
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
    CheckoutPhoneStateViewModel viewModel,
  ) {
    switch (viewModel.checkoutPhoneViewType) {
      case CheckoutPhoneViewType.view:
        {
          viewContext.read<AppFloatingButtonCubit>().showFloatingButtons(
            buttons: [
              _backButton(viewContext, viewModel),
              _continueButton(viewContext, viewModel),
            ],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );

          return ActionCardWidget(
            title: 'Mobile',
            content: Text(
              viewModel.trnCheckoutPhone!.phoneNumber,
              style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
            ),
            actionCardWidgetType: ActionCardWidgetType.edit,
            onPressed: () => viewContext
                .read<CheckoutPhoneBloc>()
                .add(CheckoutPhoneEventShowUpdate()),
          );
        }

      case CheckoutPhoneViewType.update:
        {
          return const CheckoutPhoneUpdateView();
        }

      case CheckoutPhoneViewType.code:
        {
          return CheckoutPhoneCodeView(
            mobileNumber: (viewModel.showCodeMobileNumber == null)
                ? 'UNKNOWN'
                : viewModel.showCodeMobileNumber!,
          );
        }
    }
  }

  Widget _continueButton(
    BuildContext viewContext,
    CheckoutPhoneStateViewModel viewModel,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'CONTINUE',
        iconData: Icons.arrow_right,
        onPressed: viewModel.trnCheckoutPhone == null
            ? null
            : () => viewContext.read<CheckoutPhoneBloc>().add(
                CheckoutPhoneEventSubmit(
                    phone: viewModel.trnCheckoutPhone!.phoneNumber)),
      ),
    );
  }

  Widget _backButton(
    BuildContext viewContext,
    CheckoutPhoneStateViewModel viewModel,
  ) {
    switch (viewModel.checkoutPhoneViewType) {
      case CheckoutPhoneViewType.view:
        {
          return ElevatedActionButton(
            text: 'BACK',
            iconData: Icons.arrow_left,
            onPressed: () => viewContext
                .read<CheckoutStepperBloc>()
                .add(CheckoutStepperEventBack()),
          );
        }

      case CheckoutPhoneViewType.update:
        {
          if (viewModel.trnCheckoutPhone == null) {
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
              onPressed: () => () => viewContext
                  .read<CheckoutPhoneBloc>()
                  .add(CheckoutPhoneEventShowUpdate()),
            );
          }
        }

      case CheckoutPhoneViewType.code:
        {
          return ElevatedActionButton(
            text: 'BACK',
            iconData: Icons.arrow_left,
            onPressed: () => viewContext
                .read<CheckoutPhoneBloc>()
                .add(CheckoutPhoneEventShowUpdate()),
          );
        }
    }
  }
}
