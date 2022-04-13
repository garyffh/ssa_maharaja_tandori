import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_phone/checkout_phone_event.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_code_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/elevated_action_button.dart';

class CheckoutPhoneCodeView extends StatelessWidget {
  const CheckoutPhoneCodeView({
    required this.mobileNumber,
    Key? key,
  }) : super(key: key);

  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    context.read<AppFloatingButtonCubit>().showFloatingButtons(
      buttons: [
        _backButton(context),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    return PhoneCodeWidget(
      mobileNumber: mobileNumber,
      onSubmitted: (mobileNumber) => context.read<CheckoutPhoneBloc>().add(
            CheckoutPhoneEventSubmit(
              phone: mobileNumber,
            ),
          ),
    );
  }

  Widget _backButton(
    BuildContext context,
  ) {
    return ElevatedActionButton(
      text: 'BACK',
      iconData: Icons.arrow_left,
      onPressed: () => context
              .read<CheckoutPhoneBloc>()
              .add(CheckoutPhoneEventShowUpdate()),
    );
  }
}
