// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignUpUserCWProxy {
  SignUpUser confirmPassword(String confirmPassword);

  SignUpUser email(String email);

  SignUpUser firstName(String firstName);

  SignUpUser lastName(String lastName);

  SignUpUser password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpUser(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpUser call({
    String? confirmPassword,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignUpUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignUpUser.copyWith.fieldName(...)`
class _$SignUpUserCWProxyImpl implements _$SignUpUserCWProxy {
  final SignUpUser _value;

  const _$SignUpUserCWProxyImpl(this._value);

  @override
  SignUpUser confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  SignUpUser email(String email) => this(email: email);

  @override
  SignUpUser firstName(String firstName) => this(firstName: firstName);

  @override
  SignUpUser lastName(String lastName) => this(lastName: lastName);

  @override
  SignUpUser password(String password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpUser(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpUser call({
    Object? confirmPassword = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return SignUpUser(
      confirmPassword: confirmPassword == const $CopyWithPlaceholder() ||
              confirmPassword == null
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $SignUpUserCopyWith on SignUpUser {
  /// Returns a callable class that can be used as follows: `instanceOfclass SignUpUser.name.copyWith(...)` or like so:`instanceOfclass SignUpUser.name.copyWith.fieldName(...)`.
  _$SignUpUserCWProxy get copyWith => _$SignUpUserCWProxyImpl(this);
}
