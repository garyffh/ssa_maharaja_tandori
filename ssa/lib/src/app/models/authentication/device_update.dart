import 'package:json_annotation/json_annotation.dart';

part 'device_update.g.dart';

@JsonSerializable()
class DeviceUpdate {
  DeviceUpdate({
    required this.typeId,
    required this.token,
    required this.version,
  });

  factory DeviceUpdate.fromJson(Map<String, dynamic> json) =>
      _$DeviceUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceUpdateToJson(this);

  final int typeId;
  final String? token;
  final int version;
}
