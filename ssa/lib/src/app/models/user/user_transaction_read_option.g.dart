// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_read_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransactionReadOption _$UserTransactionReadOptionFromJson(
        Map<String, dynamic> json) =>
    UserTransactionReadOption(
      searchTypeId: json['searchTypeId'] as int,
      userSubscriptionId: json['userSubscriptionId'] as String?,
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
    );

Map<String, dynamic> _$UserTransactionReadOptionToJson(
        UserTransactionReadOption instance) =>
    <String, dynamic>{
      'searchTypeId': instance.searchTypeId,
      'userSubscriptionId': instance.userSubscriptionId,
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
    };
