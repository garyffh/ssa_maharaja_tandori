import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';

abstract class EmailSignUpEvent {
}


class EmailSignUpEventSubmit extends EmailSignUpEvent {
  EmailSignUpEventSubmit({
    required this.signUpUser,
    required this.emailCode,

  });

  final SignUpUser signUpUser;
  final String  emailCode;

}

