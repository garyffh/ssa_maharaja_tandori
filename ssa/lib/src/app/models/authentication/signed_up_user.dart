import 'package:flutter/cupertino.dart';

@immutable
class SignedUpUser {
  const SignedUpUser({
    required this.firstName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String email;
  final String password;
}
