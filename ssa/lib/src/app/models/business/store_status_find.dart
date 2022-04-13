import 'package:json_annotation/json_annotation.dart';

part 'store_status_find.g.dart';

@JsonSerializable()
class StoreStatusFind {
  StoreStatusFind({
    required this.timeZone,
  });

  factory StoreStatusFind.fromJson(Map<String, dynamic> json) =>
      _$StoreStatusFindFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStatusFindToJson(this);

  final String timeZone;
}
