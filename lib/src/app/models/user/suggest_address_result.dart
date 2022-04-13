import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/user/suggest_address.dart';

part 'suggest_address_result.g.dart';

@JsonSerializable()
class SuggestAddressResult {
  SuggestAddressResult({
    required this.suggest,
  });

  factory SuggestAddressResult.fromJson(Map<String, dynamic> json) =>
      _$SuggestAddressResultFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestAddressResultToJson(this);

  final List<SuggestAddress>? suggest;
}
