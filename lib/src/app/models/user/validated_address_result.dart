import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/user/validated_address.dart';

part 'validated_address_result.g.dart';

@JsonSerializable()
class ValidatedAddressResult {
  ValidatedAddressResult({
    required this.address,
});

  factory ValidatedAddressResult.fromJson(Map<String, dynamic> json) =>
      _$ValidatedAddressResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatedAddressResultToJson(this);

    final ValidatedAddress address;

}