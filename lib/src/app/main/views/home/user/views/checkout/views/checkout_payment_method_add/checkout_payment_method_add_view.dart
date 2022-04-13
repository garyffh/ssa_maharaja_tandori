import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_payment_method/checkout_payment_method_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_payment_method/checkout_payment_method_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_payment_method/checkout_payment_method_state.dart';
import 'package:single_store_app/src/app/models/payment_method/payment_method_controller.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_event.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_state.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

class CheckoutPaymentMethodAddView extends StatelessWidget {
  const CheckoutPaymentMethodAddView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaymentMethodWidget(
      paymentMethodConsumer: (
        BuildContext paymentMethodWidgetContext,
        FormGroup paymentAddForm,
        PaymentMethodWidgetState paymentMethodWidgetState,
          PaymentMethodController paymentMethodController,
      ) {
        context.read<AppFloatingButtonCubit>().showFloatingButtons(
          buttons: [
            _backButton(paymentMethodWidgetContext),
            _continueButton(
              paymentMethodWidgetContext,
              paymentAddForm,
              paymentMethodWidgetState,
                paymentMethodController,
            ),
          ],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );

        return const SizedBox.shrink();
      },
      onSubmitted: () => context
          .read<CheckoutPaymentMethodBloc>()
          .add(CheckoutPaymentMethodEventRefresh()),
    );
  }

  Widget _continueButton(
    BuildContext viewContext,
    FormGroup form,
    PaymentMethodWidgetState viewState,
      PaymentMethodController paymentMethodController,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'ADD',
        iconData: Icons.add,
        onPressed: onPressedContinueButton(
          viewContext,
          form,
          viewState,
            paymentMethodController,
        ),
      ),
    );
  }

  VoidCallback? onPressedContinueButton(
    BuildContext viewContext,
    FormGroup form,
    PaymentMethodWidgetState viewState,
      PaymentMethodController paymentMethodController,
  ) {
    return (form.valid && paymentMethodController.complete == true && !viewState.inProgress)
        ? () {
            if (viewState.hasError) {
              paymentMethodController.clear();
              viewContext
                  .read<PaymentMethodWidgetBloc>()
                  .add(PaymentMethodWidgetEventResetError());
            } else if (!viewState.inProgress) {
              viewContext.read<PaymentMethodWidgetBloc>().add(
                    PaymentMethodWidgetEventSubmit(
                      cardName: form.value['cardName']! as String,
                    ),
                  );
            }
          }
        : null;
  }

  Widget _backButton(BuildContext viewContext) {
    if (viewContext.read<CheckoutPaymentMethodBloc>().state
        is CheckoutPaymentMethodStateViewModel) {
      final CheckoutPaymentMethodStateViewModel viewModel = viewContext
          .read<CheckoutPaymentMethodBloc>()
          .state as CheckoutPaymentMethodStateViewModel;

      if (viewModel.trnCheckoutPaymentMethod.paymentMethods.isEmpty) {
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
      } else {
        return Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ElevatedActionButton(
            text: 'BACK',
            iconData: Icons.arrow_left,
            onPressed: () => viewContext
                .read<CheckoutPaymentMethodBloc>()
                .add(CheckoutPaymentMethodEventShowView()),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
