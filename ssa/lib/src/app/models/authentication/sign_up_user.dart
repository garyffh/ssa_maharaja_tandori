import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';

part 'sign_up_user.g.dart';

@CopyWith()
@immutable
class SignUpUser {
  const SignUpUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
}
