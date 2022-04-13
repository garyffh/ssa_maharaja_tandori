import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

part 'user_phone_verify.g.dart';

@JsonSerializable()
class UserPhoneVerify {
  UserPhoneVerify({
    required this.updateId,
    required this.mobileNumber,
  });


  factory UserPhoneVerify.fromJson(Map<String, dynamic> json) => _$UserPhoneVerifyFromJson(json);
  Map<String, dynamic> toJson() => _$UserPhoneVerifyToJson(this);

  @Uint8ListConverter()
  final Uint8List updateId;
  final   String mobileNumber;

}
