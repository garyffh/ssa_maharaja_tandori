import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_state.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateNavCubit, AuthenticateNavState>(
        builder: (context, state) {
          return TextButton(
            child: Text(
              'Already registered? Sign In',
              style: TextStyle(
                fontSize: context.watch<MediaSettingsBloc>().state.buttonFontSize,
              ),
            ),
            onPressed: () => context
                .read<AuthenticateNavCubit>()
                .showSignIn(postAuthenticateView: state.postAuthenticateView),
          );
        });
  }

}
