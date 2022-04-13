import 'package:json_annotation/json_annotation.dart';

part 'user_member_group.g.dart';

@JsonSerializable()
class UserMemberGroup {
  UserMemberGroup({
    required this.memberGroupId,
    required this.name,
    required this.typeId,
    required this.enabled,
    required this.spendMultiplier,
    required this.priceLevel,
  });

  factory UserMemberGroup.fromJson(Map<String, dynamic> json) => _$UserMemberGroupFromJson(json);
  Map<String, dynamic> toJson() => _$UserMemberGroupToJson(this);

  final   String memberGroupId;
  final   String name;
  final   int typeId;
  final   bool enabled;
  final   double spendMultiplier;
  final   int priceLevel;

}
