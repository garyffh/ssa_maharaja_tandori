import 'package:json_annotation/json_annotation.dart';

part 'store_time_read.g.dart';

@JsonSerializable()
class StoreTimeRead {
  StoreTimeRead({
    required this.sysStoreTimeId,
    required this.day,
    required this.number,
    required this.fromTime,
    required this.toTime,
  });

  factory StoreTimeRead.fromJson(Map<String, dynamic> json) => _$StoreTimeReadFromJson(json);
  Map<String, dynamic> toJson() => _$StoreTimeReadToJson(this);

  final   int sysStoreTimeId;
  final   String day;
  final   int number;
  final   String fromTime;
  final   String toTime;

}
