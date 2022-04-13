import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/payment_method/payment_method_controller.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_event.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_state.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

class PaymentMethodAddView extends StatelessWidget {
  const PaymentMethodAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubView(
      title: 'Add Payment Method',
      child: PaymentMethodWidget(
        paymentMethodConsumer: (
          BuildContext paymentMethodWidgetContext,
          FormGroup paymentAddForm,
          PaymentMethodWidgetState paymentMethodWidgetState,
          PaymentMethodController paymentMethodController,
        ) {
          return FormProgressButton(
            text: 'Submit',
            progressFormView: paymentMethodWidgetState,
            onPressed: onPressedSubmitButton(
              paymentMethodWidgetContext,
              paymentAddForm,
              paymentMethodWidgetState,
              paymentMethodController,
            ),
            dataDirection: DataDirection.none,
          );
        },
        onSubmitted: () =>
            context.read<MyAccountNavCubit>().showPaymentMethods(),
      ),
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext viewContext,
    FormGroup form,
    PaymentMethodWidgetState viewState,
    PaymentMethodController paymentMethodController,
  ) {
    return (form.valid && paymentMethodController.complete == true)
        ? () {
            if (viewState.hasError) {
              paymentMethodController.clear();
              viewContext
                  .read<PaymentMethodWidgetBloc>()
                  .add(PaymentMethodWidgetEventResetError());
            } else if (!viewState.inProgress) {
              viewContext.read<PaymentMethodWidgetBloc>().add(
                    PaymentMethodWidgetEventSubmit(
                      cardName: (form.value['cardName']! as String).trim(),
                    ),
                  );
            }
          }
        : null;
  }
}
