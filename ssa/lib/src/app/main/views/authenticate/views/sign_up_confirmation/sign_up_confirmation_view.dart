import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/models/authentication/signed_up_user.dart';
import 'package:single_store_app/src/app/widgets/form/form_confirmation_widget.dart';


class SignUpConfirmationView extends StatelessWidget {
  const SignUpConfirmationView({
    required this.postAuthenticateView,
    required this.signedUpUser,
    Key? key,
  }) : super(key: key);

  final PostAuthenticateView postAuthenticateView;
  final SignedUpUser signedUpUser;

  @override
  Widget build(BuildContext context) {
    return FormConfirmationWidget(
      message: const ['You have registered.', 'Continue to Sign In.'],
      continueCallback: () =>
          context.read<AuthenticateNavCubit>().showSignIn(
            postAuthenticateView: postAuthenticateView,
            signedUpUser: signedUpUser,
          ),
    );
  }

}
