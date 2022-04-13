import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/models/checkout_stepper_step.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_address/checkout_address_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_delivery_method/checkout_delivery_method_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_payment_method/checkout_payment_method_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_view.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/checkout_submit_view.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class CheckoutStepperView extends StatelessWidget {
  const CheckoutStepperView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutStepperBloc, CheckoutStepperState>(
      builder: (viewContext, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ViewTitleWidget(
              title: 'Checkout',
              textLeft: false,
              leadPadding: false,
            ),
            Expanded(
              child: _view(viewContext, state),
            ),
          ],
        );
      },
    );
  }

  Widget _view(BuildContext viewContext, CheckoutStepperState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as CheckoutStepperStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<CheckoutStepperBloc>()
                .add(CheckoutStepperEventGetViewModel()),
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
    CheckoutStepperStateViewModel viewModel,
  ) {
    return Stepper(
      type: StepperType.horizontal,
      steps: _steps(viewContext, viewModel.currentStep),
      currentStep: viewModel.viewStep.index,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return const SizedBox.shrink();
      },
    );
  }

  List<Step> _steps(
          BuildContext viewContext, CheckoutStepperStep currentStep) =>
      [
        Step(
          title: currentStep == CheckoutStepperStep.deliveryMethod
              ? Text(
                  'Select',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : const SizedBox.shrink(),
          subtitle: currentStep == CheckoutStepperStep.deliveryMethod
              ? Text(
                  'Time',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : null,
          isActive: currentStep == CheckoutStepperStep.deliveryMethod,
          state: StepState.indexed,
          content: currentStep == CheckoutStepperStep.deliveryMethod
              ? CheckoutDeliveryMethodView(
                  trnCheckoutDeliveryMethod: viewContext
                      .read<CheckoutBloc>()
                      .state
                      .trnCheckout
                      .trnCheckoutDeliveryMethod,
                )
              : const SizedBox.shrink(),
        ),
        Step(
          title: currentStep == CheckoutStepperStep.address
              ? Text(
                  viewContext
                              .watch<CheckoutBloc>()
                              .state
                              .trnCheckout
                              .trnCheckoutDeliveryMethod ==
                          null
                      ? 'Billing'
                      : viewContext
                          .watch<CheckoutBloc>()
                          .state
                          .trnCheckout
                          .trnCheckoutDeliveryMethod!
                          .deliveryMethodType
                          .addressText,
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : const SizedBox.shrink(),
          subtitle: currentStep == CheckoutStepperStep.address
              ? Text(
                  'Address',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : null,
          isActive: currentStep == CheckoutStepperStep.address,
          state: StepState.indexed,
          content: currentStep == CheckoutStepperStep.address
              ? const CheckoutAddressView()
              : const SizedBox.shrink(),
        ),
        Step(
          title: currentStep == CheckoutStepperStep.phone
              ? Text(
                  'Mobile',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : const SizedBox.shrink(),
          subtitle: currentStep == CheckoutStepperStep.phone
              ? Text(
                  'Number',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : null,
          isActive: currentStep == CheckoutStepperStep.phone,
          state: StepState.indexed,
          content: currentStep == CheckoutStepperStep.phone
              ? const CheckoutPhoneView()
              : const SizedBox.shrink(),
        ),
        Step(
          title: currentStep == CheckoutStepperStep.paymentMethod
              ? Text(
                  'Payment',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : const SizedBox.shrink(),
          subtitle: currentStep == CheckoutStepperStep.paymentMethod
              ? Text(
                  'Method',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : null,
          isActive: currentStep == CheckoutStepperStep.paymentMethod,
          state: StepState.indexed,
          content: currentStep == CheckoutStepperStep.paymentMethod
              ? const CheckoutPaymentMethodView()
              : const SizedBox.shrink(),
        ),
        Step(
          title: currentStep == CheckoutStepperStep.submit
              ? Text(
                  'Review &',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : const SizedBox.shrink(),
          subtitle: currentStep == CheckoutStepperStep.submit
              ? Text(
                  'Submit',
                  style: Theme.of(viewContext).textTheme.caption,
                )
              : null,
          isActive: currentStep == CheckoutStepperStep.submit,
          state: StepState.indexed,
          content: currentStep == CheckoutStepperStep.submit
              ? const CheckoutSubmitView()
              : const SizedBox.shrink(),
        ),
      ];
}
