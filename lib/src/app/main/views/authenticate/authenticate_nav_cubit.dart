import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';
import 'package:single_store_app/src/app/models/authentication/signed_up_user.dart';

import 'authenticate_nav_state.dart';

class AuthenticateNavCubit extends Cubit<AuthenticateNavState> {
  AuthenticateNavCubit()
      : super(AuthenticateNavStatePasswordVerificationView(
            postAuthenticateView: PostAuthenticateView.category));

  AuthenticateNavCubit.postAuthenticateCategory()
      : super(AuthenticateNavStateSignInView(
          postAuthenticateView: PostAuthenticateView.category,
        ));

  AuthenticateNavCubit.postAuthenticateUserCard()
      : super(AuthenticateNavStateSignInView(
          postAuthenticateView: PostAuthenticateView.userCard,
        ));

  AuthenticateNavCubit.postAuthenticateCheckout()
      : super(AuthenticateNavStateSignInView(
          postAuthenticateView: PostAuthenticateView.checkout,
        ));

  void showSignIn({
    required PostAuthenticateView postAuthenticateView,
    SignedUpUser? signedUpUser,
  }) =>
      emit(AuthenticateNavStateSignInView(
        postAuthenticateView: postAuthenticateView,
        signedUpUser: signedUpUser,
      ));

  void showEmailVerification() =>
      emit(AuthenticateNavStateEmailVerificationView(
          postAuthenticateView: state.postAuthenticateView));

  void showEmailSignUp({
    required SignUpUser signUpUser,
  }) =>
      emit(AuthenticateNavStateEmailSignUpView(
        signUpUser: signUpUser,
        postAuthenticateView: state.postAuthenticateView,
      ));

  void showSignUpConfirmation({
    required SignedUpUser signedUpUser,
  }) =>
      emit(AuthenticateNavStateSignUpConfirmationView(
        postAuthenticateView: state.postAuthenticateView,
        signedUpUser: signedUpUser,
      ));

  void showPasswordVerification() =>
      emit(AuthenticateNavStatePasswordVerificationView(
          postAuthenticateView: state.postAuthenticateView));

  void showPasswordCode({required String email}) =>
      emit(AuthenticateNavStatePasswordCodeView(
        email: email,
        postAuthenticateView: state.postAuthenticateView,
      ));

  void showPasswordReset({
    required String email,
    required String code,
  }) =>
      emit(AuthenticateNavStatePasswordResetView(
        email: email,
        code: code,
        postAuthenticateView: state.postAuthenticateView,
      ));

  void showPasswordResetConfirmation() =>
      emit(AuthenticateNavStatePasswordResetConfirmationView(
        postAuthenticateView: state.postAuthenticateView,
      ));
}
