import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';
import 'package:single_store_app/src/app/models/authentication/signed_up_user.dart';

enum AuthenticateView {
  signIn,
  emailVerification,
  emailSignUp,
  signUpConfirmation,
  passwordVerification,
  passwordCode,
  passwordReset,
  passwordResetConfirmation,

}
enum PostAuthenticateView { category, userCard, checkout }

abstract class AuthenticateNavState {
  AuthenticateNavState({
    required this.view,
    required this.postAuthenticateView,
    this.floatingActionButton,
  });

  final AuthenticateView view;
  final PostAuthenticateView postAuthenticateView;
  final FloatingActionButton? floatingActionButton;

}

class AuthenticateNavStateSignInView extends AuthenticateNavState {
  AuthenticateNavStateSignInView({
    required PostAuthenticateView postAuthenticateView,
    this.signedUpUser,
  }) : super(
    view: AuthenticateView.signIn,
          postAuthenticateView: postAuthenticateView,
        );
  final SignedUpUser? signedUpUser;
}

class AuthenticateNavStateEmailVerificationView extends AuthenticateNavState {
  AuthenticateNavStateEmailVerificationView({
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.emailVerification,
          postAuthenticateView: postAuthenticateView,
        );
}

class AuthenticateNavStateEmailSignUpView extends AuthenticateNavState {
  AuthenticateNavStateEmailSignUpView({
    required this.signUpUser,
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.emailSignUp,
          postAuthenticateView: postAuthenticateView,
        );

  final SignUpUser signUpUser;
}

class AuthenticateNavStateSignUpConfirmationView extends AuthenticateNavState {
  AuthenticateNavStateSignUpConfirmationView({
    required PostAuthenticateView postAuthenticateView,
    required this.signedUpUser,
  }) : super(
    view: AuthenticateView.signUpConfirmation,
          postAuthenticateView: postAuthenticateView,
        );

  final SignedUpUser signedUpUser;
}

class AuthenticateNavStatePasswordVerificationView extends AuthenticateNavState {
  AuthenticateNavStatePasswordVerificationView({
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.passwordVerification,
    postAuthenticateView: postAuthenticateView,
  );
}

class AuthenticateNavStatePasswordCodeView extends AuthenticateNavState {
  AuthenticateNavStatePasswordCodeView({
    required this.email,
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.passwordCode,
    postAuthenticateView: postAuthenticateView,
  );
  final String email;
}

class AuthenticateNavStatePasswordResetView extends AuthenticateNavState {
  AuthenticateNavStatePasswordResetView({
    required this.email,
    required this.code,
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.passwordReset,
    postAuthenticateView: postAuthenticateView,
  );
  final String email;
  final String code;
}

class AuthenticateNavStatePasswordResetConfirmationView extends AuthenticateNavState {
  AuthenticateNavStatePasswordResetConfirmationView({
    required PostAuthenticateView postAuthenticateView,
  }) : super(
    view: AuthenticateView.passwordResetConfirmation,
    postAuthenticateView: postAuthenticateView,
  );

}
