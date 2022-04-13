import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_bloc.dart';
import 'package:single_store_app/src/app/main/main_event.dart';
import 'package:single_store_app/src/app/main/scaffolds/models/home_initial_route.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/email_sign_up/email_sign_up_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/email_verification/email_verification_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset_confirmation/password_reset_confirmation_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/sign_in/sign_in_view.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/sign_up_confirmation/sign_up_confirmation_view.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'authenticate_nav_cubit.dart';
import 'authenticate_nav_state.dart';

class AuthenticateRoute extends StatelessWidget {
  const AuthenticateRoute({
    required this.appFloatingButtonCubit,
    Key? key,
  }) : super(key: key);

  final AppFloatingButtonCubit appFloatingButtonCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateNavCubit, AuthenticateNavState>(
        builder: (context, navState) {
          if (navState.floatingActionButton == null) {
            appFloatingButtonCubit.removeFloatingButton();
          } else {
            appFloatingButtonCubit.showFloatingButton(
                floatingActionButton: navState.floatingActionButton!);
          }

      return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) =>
              previous.isAuthenticated != current.isAuthenticated,
          builder: (context, authenticationState) {
            return authenticationState.isAuthenticated
                ? _authenticatedNavigator(
                    context,
                    navState,
                    authenticationState,
                  )
                : _unauthenticatedNavigator(
                    context,
                    navState,
                    authenticationState,
                  );
          });
    });
  }

  Navigator _authenticatedNavigator(
    BuildContext context,
    AuthenticateNavState navState,
    AuthenticationState authenticationState,
  ) {
    switch (navState.postAuthenticateView) {
      case PostAuthenticateView.category:
        BlocProvider.of<MainBloc>(context).add(
          MainEventNavigateHome(
            initialRoute: HomeInitialRoute.categories,
          ),
        );
        break;

      case PostAuthenticateView.userCard:
        BlocProvider.of<MainBloc>(context).add(
          MainEventNavigateHome(
            initialRoute: HomeInitialRoute.userCard,
          ),
        );
        break;

      case PostAuthenticateView.checkout:
        BlocProvider.of<MainBloc>(context).add(
          MainEventNavigateHome(
            initialRoute: HomeInitialRoute.checkout,
          ),
        );
        break;

      default:
        BlocProvider.of<MainBloc>(context).add(
          MainEventNavigateHome(),
        );
        break;
    }

    return _defaultNavigator(context, navState, authenticationState);
  }

  Navigator _unauthenticatedNavigator(
    BuildContext context,
    AuthenticateNavState navState,
    AuthenticationState authenticationState,
  ) {
    switch (navState.view) {
      case AuthenticateView.signIn:
        return _defaultNavigator(context, navState, authenticationState);

      case AuthenticateView.emailVerification:
      case AuthenticateView.emailSignUp:
        return _emailSignUpNavigator(context, navState);

      case AuthenticateView.signUpConfirmation:
        return _emailSignUpConfirmationNavigator(context, navState);

      case AuthenticateView.passwordVerification:
      case AuthenticateView.passwordCode:
      case AuthenticateView.passwordReset:
        return _passwordResetNavigator(context, navState);

      case AuthenticateView.passwordResetConfirmation:
        return _passwordResetConfirmationNavigator(context, navState);
    }
  }

  Navigator _defaultNavigator(
    BuildContext context,
    AuthenticateNavState navState,
    AuthenticationState authenticationState,
  ) {
    return Navigator(
      pages: [
        MaterialPage<SignInView>(
          child: SignInView(
            viewMessage: _signInMessage(authenticationState),
            signedUpUser:
                (navState as AuthenticateNavStateSignInView).signedUpUser,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result);
      },
    );
  }

  Navigator _emailSignUpNavigator(
      BuildContext context, AuthenticateNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<EmailVerificationView>(
          child: EmailVerificationView(),
        ),
        if (navState.view == AuthenticateView.emailSignUp)
          MaterialPage<EmailSignUpView>(
              child: EmailSignUpView(
            signUpUser:
                (navState as AuthenticateNavStateEmailSignUpView).signUpUser,
          )),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result);
      },
    );
  }

  Navigator _emailSignUpConfirmationNavigator(
      BuildContext context, AuthenticateNavState navState) {
    return Navigator(
      pages: [
        MaterialPage<SignUpConfirmationView>(
          child: SignUpConfirmationView(
            postAuthenticateView: navState.postAuthenticateView,
            signedUpUser:
                (navState as AuthenticateNavStateSignUpConfirmationView)
                    .signedUpUser,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result);
      },
    );
  }

  Navigator _passwordResetNavigator(
      BuildContext context, AuthenticateNavState navState) {
    return Navigator(
      pages: [
        const MaterialPage<PasswordVerificationView>(
          child: PasswordVerificationView(),
        ),
        if (navState.view == AuthenticateView.passwordCode)
          MaterialPage<PasswordCodeView>(
            child: PasswordCodeView(
              email: (navState as AuthenticateNavStatePasswordCodeView).email,
            ),
          ),
        if (navState.view == AuthenticateView.passwordReset)
          MaterialPage<PasswordResetView>(
            child: PasswordResetView(
              email: (navState as AuthenticateNavStatePasswordResetView).email,
              code: navState.code,
            ),
          ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result);
      },
    );
  }

  Navigator _passwordResetConfirmationNavigator(
      BuildContext context, AuthenticateNavState navState) {
    return Navigator(
      pages: [
        MaterialPage<PasswordResetConfirmationView>(
          child: PasswordResetConfirmationView(
            postAuthenticateView: navState.postAuthenticateView,
          ),
        ),
      ],
      onPopPage: (route, dynamic result) {
        return _handleOnPopPage(context, route, result);
      },
    );
  }

  bool _handleOnPopPage(
      BuildContext context, Route<dynamic> route, dynamic result) {
    final AuthenticateNavCubit navCubit =
        BlocProvider.of<AuthenticateNavCubit>(context);

    switch (navCubit.state.view) {
      case AuthenticateView.passwordCode:
        navCubit.showPasswordVerification();
        break;

      case AuthenticateView.passwordReset:
        navCubit.showPasswordCode(
            email: (navCubit.state as AuthenticateNavStatePasswordResetView)
                .email);
        break;

      case AuthenticateView.emailSignUp:
        navCubit.showEmailVerification();
        break;

      case AuthenticateView.emailVerification:
      case AuthenticateView.passwordResetConfirmation:
      case AuthenticateView.passwordVerification:
      case AuthenticateView.signUpConfirmation:
      case AuthenticateView.signIn:
        break;
    }

    return false;
  }

  List<String>? _signInMessage(AuthenticationState authenticationState) {
    if (authenticationState is AuthenticationStateUnauthenticated) {
      return authenticationState.signInMessage;
    } else {
      return null;
    }
  }
}
