import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/widgets/form/form_confirmation_widget.dart';


class PasswordResetConfirmationView extends StatelessWidget {
  const PasswordResetConfirmationView({
    required this.postAuthenticateView,
    Key? key,
  }) : super(key: key);

  final PostAuthenticateView postAuthenticateView;

  @override
  Widget build(BuildContext context) {
    return FormConfirmationWidget(
      message: const ['Your password has been reset.'],
      continueCallback: () => context.read<AuthenticateNavCubit>().showSignIn(
        postAuthenticateView: postAuthenticateView,
      ),
    );
  }

}
