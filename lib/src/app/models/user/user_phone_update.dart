import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

part 'user_phone_update.g.dart';

@JsonSerializable()
class UserPhoneUpdate {
  UserPhoneUpdate({
    required this.updateId,
    required this.mobileCode,
    required this.mobileNumber,
  });

  factory UserPhoneUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserPhoneUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserPhoneUpdateToJson(this);

  @Uint8ListConverter()
  final Uint8List updateId;
  final String mobileCode;
  final String mobileNumber;
}
