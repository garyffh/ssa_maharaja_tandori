import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_state.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_event.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_state.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

class CheckoutPhoneUpdateView extends StatelessWidget {
  const CheckoutPhoneUpdateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhoneUpdateWidget(
      phoneUpdateConsumer: (
        BuildContext phoneUpdateWidgetContext,
        FormGroup phoneUpdateForm,
        PhoneUpdateWidgetState phoneUpdateWidgetState,
      ) {
        context.read<AppFloatingButtonCubit>().showFloatingButtons(
          buttons: [
            _backButton(context),
            _continueButton(phoneUpdateWidgetContext, phoneUpdateWidgetState,
                phoneUpdateForm),
          ],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );

        return const SizedBox.shrink();
      },
      onSubmitted: (String mobileNumber) => context
          .read<CheckoutPhoneBloc>()
          .add(CheckoutPhoneEventShowCode(mobileNumber: mobileNumber)),
    );
  }

  Widget _continueButton(
    BuildContext phoneUpdateWidgetContext,
    PhoneUpdateWidgetState phoneUpdateWidgetState,
    FormGroup phoneUpdateForm,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: ElevatedActionButton(
        text: 'CONTINUE',
        iconData: Icons.arrow_right,
        onPressed: onPressedSubmitButton(
          phoneUpdateWidgetContext,
          phoneUpdateForm,
          phoneUpdateWidgetState,
        ),
      ),
    );
  }

  Widget _backButton(
    BuildContext viewContext,
  ) {
    if (viewContext.read<CheckoutPhoneBloc>().state
        is CheckoutPhoneStateViewModel) {
      final CheckoutPhoneStateViewModel checkoutPhoneStateViewModel =
          viewContext.read<CheckoutPhoneBloc>().state
              as CheckoutPhoneStateViewModel;
      if (checkoutPhoneStateViewModel.trnCheckoutPhone == null) {
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
                .read<CheckoutPhoneBloc>()
                .add(CheckoutPhoneEventShowView()),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext phoneUpdateWidgetContext,
    FormGroup phoneUpdateForm,
    PhoneUpdateWidgetState phoneUpdateWidgetState,
  ) {
    return phoneUpdateForm.valid
        ? () {
            if (phoneUpdateWidgetState.hasError) {
              phoneUpdateWidgetContext
                  .read<PhoneUpdateWidgetBloc>()
                  .add(PhoneUpdateWidgetEventResetError());
            } else if (!phoneUpdateWidgetState.inProgress) {
              phoneUpdateWidgetContext.read<PhoneUpdateWidgetBloc>().add(
                    PhoneUpdateWidgetEventSubmit(
                      mobile: phoneUpdateForm.value['mobile']! as String,
                    ),
                  );
            }
          }
        : null;
  }
}
