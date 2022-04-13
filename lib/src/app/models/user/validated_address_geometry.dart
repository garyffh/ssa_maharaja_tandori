import 'package:json_annotation/json_annotation.dart';

part 'validated_address_geometry.g.dart';

@JsonSerializable()
class ValidatedAddressGeometry {
  ValidatedAddressGeometry({
    required this.coordinates,
  });

  factory ValidatedAddressGeometry.fromJson(Map<String, dynamic> json) =>
      _$ValidatedAddressGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatedAddressGeometryToJson(this);

  final List<double> coordinates;
}
