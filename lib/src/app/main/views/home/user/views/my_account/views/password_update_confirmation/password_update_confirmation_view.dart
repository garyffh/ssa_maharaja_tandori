import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/widgets/form/form_confirmation_widget.dart';

class PasswordUpdateConfirmationView extends StatelessWidget {
  const PasswordUpdateConfirmationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormConfirmationWidget(
      message: const ['Your password has been changed.'],
      continueCallback: () => context.read<MyAccountNavCubit>().showDashBoard(),
    );
  }
}
