// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_member_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMemberGroup _$UserMemberGroupFromJson(Map<String, dynamic> json) =>
    UserMemberGroup(
      memberGroupId: json['memberGroupId'] as String,
      name: json['name'] as String,
      typeId: json['typeId'] as int,
      enabled: json['enabled'] as bool,
      spendMultiplier: (json['spendMultiplier'] as num).toDouble(),
      priceLevel: json['priceLevel'] as int,
    );

Map<String, dynamic> _$UserMemberGroupToJson(UserMemberGroup instance) =>
    <String, dynamic>{
      'memberGroupId': instance.memberGroupId,
      'name': instance.name,
      'typeId': instance.typeId,
      'enabled': instance.enabled,
      'spendMultiplier': instance.spendMultiplier,
      'priceLevel': instance.priceLevel,
    };
