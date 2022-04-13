import 'package:json_annotation/json_annotation.dart';

part 'store_category_read.g.dart';

@JsonSerializable()
class StoreCategoryRead {
  StoreCategoryRead({
    required this.sysStoreCategoryId,
    required this.number,
    required this.name,
  });

  factory StoreCategoryRead.fromJson(Map<String, dynamic> json) =>
      _$StoreCategoryReadFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCategoryReadToJson(this);

  final String sysStoreCategoryId;
  final int number;
  final String name;
  final bool hasSubCategory = false;
  final int parentId = 0;

}
