import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/checkout_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_payment_method_add/checkout_payment_method_add_view.dart';
import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget_type.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

import 'checkout_payment_method_bloc.dart';
import 'checkout_payment_method_event.dart';
import 'checkout_payment_method_state.dart';
import 'models/checkout_payment_method_view_type.dart';

class CheckoutPaymentMethodView extends StatefulWidget {
  const CheckoutPaymentMethodView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckoutPaymentMethodViewState();
}

class _CheckoutPaymentMethodViewState extends State<CheckoutPaymentMethodView> {
  late FormGroup form;

  @override
  void initState() {
    form = FormGroup(
      {
        'selectedPaymentMethod': FormControl<UserPaymentMethodRead>(
          validators: [Validators.required],
        ),
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutPaymentMethodBloc(
        checkoutNavCubit: context.read<CheckoutNavCubit>(),
        checkoutBloc: context.read<CheckoutBloc>(),
        checkoutStepperBloc: context.read<CheckoutStepperBloc>(),
      )..add(CheckoutPaymentMethodEventGetViewModel()),
      child: BlocBuilder<CheckoutPaymentMethodBloc, CheckoutPaymentMethodState>(
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, CheckoutPaymentMethodState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as CheckoutPaymentMethodStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutPaymentMethodBloc>()
                .add(CheckoutPaymentMethodEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          viewContext.read<AppFloatingButtonCubit>().removeFloatingButton();

          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () => viewContext
                .read<CheckoutPaymentMethodBloc>()
                .add(CheckoutPaymentMethodEventGetViewModel()),
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
    CheckoutPaymentMethodStateViewModel viewModel,
  ) {
    switch (viewModel.checkoutPaymentMethodViewType) {
      case CheckoutPaymentMethodViewType.view:
        {
          return viewModel.trnCheckoutPaymentMethod.creditTransaction
              ? _creditTransactionWidget(viewContext, viewModel)
              : _paymentMethodSelectForm(viewContext, viewModel);
        }

      case CheckoutPaymentMethodViewType.add:
        {
          return const CheckoutPaymentMethodAddView();
        }
    }
  }

  Widget _creditTransactionWidget(
    BuildContext viewContext,
    CheckoutPaymentMethodStateViewModel viewModel,
  ) {
    viewContext.read<AppFloatingButtonCubit>().showFloatingButtons(
      buttons: [
        _backButton(viewContext),
        _creditContinueButton(viewContext),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    return ActionCardWidget(
        title: 'Payment Method',
        content: Text(
          'Add to account.',
          style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          textAlign: TextAlign.center,
        ));
  }

  Widget _paymentMethodSelectForm(
    BuildContext viewContext,
    CheckoutPaymentMethodStateViewModel viewModel,
  ) {
    form.control('selectedPaymentMethod').value =
        viewModel.trnCheckoutPaymentMethod.selectedPaymentMethod;

    return ActionCardWidget(
      title: 'Payment Method',
      actionCardWidgetType: ActionCardWidgetType.add,
      onPressed: () => viewContext
          .read<CheckoutPaymentMethodBloc>()
          .add(CheckoutPaymentMethodEventShowAdd()),
      content: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth:
                      viewContext.watch<MediaSettingsBloc>().state.sp(100),
                ),
                child: ReactiveDropdownField<UserPaymentMethodRead>(
                  key: const ValueKey('selectedPaymentMethod'),
                  style: viewContext
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldTextStyle,
                  formControlName: 'selectedPaymentMethod',
                  hint: Text(
                    'Payment method',
                    style: viewContext
                        .watch<MediaSettingsBloc>()
                        .state
                        .formHelperTextStyle,
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.required: 'Payment method is required',
                  },
                  items: List.generate(
                    viewModel.trnCheckoutPaymentMethod.paymentMethods.length,
                    (index) => DropdownMenuItem<UserPaymentMethodRead>(
                      value: viewModel
                          .trnCheckoutPaymentMethod.paymentMethods[index],
                      child: Text(
                        viewModel.trnCheckoutPaymentMethod.paymentMethods[index]
                            .name,
                        style: viewContext
                            .watch<MediaSettingsBloc>()
                            .state
                            .bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
              ReactiveFormConsumer(
                builder: (formContext, form, child) {
                  viewContext
                      .read<AppFloatingButtonCubit>()
                      .showFloatingButtons(
                    buttons: [
                      _backButton(viewContext),
                      _paymentMethodContinueButton(
                        viewContext,
                        form,
                      ),
                    ],
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                  );

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentMethodContinueButton(
    BuildContext viewContext,
    FormGroup form,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'CONTINUE',
        iconData: Icons.arrow_right,
        onPressed: form.valid
            ? () => viewContext.read<CheckoutPaymentMethodBloc>().add(
                  CheckoutPaymentMethodEventSubmit(
                    selectedPaymentMethod: form
                        .control('selectedPaymentMethod')
                        .value as UserPaymentMethodRead,
                    creditTransaction: false,
                  ),
                )
            : null,
      ),
    );
  }

  Widget _creditContinueButton(
    BuildContext viewContext,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'CONTINUE',
        iconData: Icons.arrow_right,
        onPressed: () => viewContext.read<CheckoutPaymentMethodBloc>().add(
              CheckoutPaymentMethodEventSubmit(
                selectedPaymentMethod: null,
                creditTransaction: true,
              ),
            ),
      ),
    );
  }

  Widget _backButton(BuildContext viewContext) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ElevatedActionButton(
        text: 'BACK',
        iconData: Icons.arrow_left,
        onPressed: () => viewContext
            .read<CheckoutStepperBloc>()
            .add(CheckoutStepperEventBack()),
      ),
    );
  }
}
