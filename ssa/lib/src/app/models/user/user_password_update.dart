import 'package:json_annotation/json_annotation.dart';

part 'user_password_update.g.dart';

@JsonSerializable()
class UserPasswordUpdate {
  UserPasswordUpdate({
    required this.email,
    required this.password,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory UserPasswordUpdate.fromUserPasswordUpdate(UserPasswordUpdate source) => UserPasswordUpdate.fromJson(source.toJson());

  factory UserPasswordUpdate.fromJson(Map<String, dynamic> json) => _$UserPasswordUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserPasswordUpdateToJson(this);

  final   String email;
  final   String password;
  final   String newPassword;
  final   String confirmNewPassword;

}
