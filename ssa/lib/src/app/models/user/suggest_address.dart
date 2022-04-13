import 'package:json_annotation/json_annotation.dart';

part 'suggest_address.g.dart';

@JsonSerializable()
class SuggestAddress {
  SuggestAddress({
    required this.id,
    required this.address,
    required this.rank,
  });

  factory SuggestAddress.fromJson(Map<String, dynamic> json) =>
      _$SuggestAddressFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestAddressToJson(this);

  final String id;
  final String address;
  final int rank;
}
