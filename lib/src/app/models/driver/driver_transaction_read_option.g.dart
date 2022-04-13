// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_transaction_read_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverTransactionReadOption _$DriverTransactionReadOptionFromJson(
        Map<String, dynamic> json) =>
    DriverTransactionReadOption(
      searchTypeId: json['searchTypeId'] as int? ?? 0,
      userSubscriptionId: json['userSubscriptionId'] as String?,
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
    );

Map<String, dynamic> _$DriverTransactionReadOptionToJson(
        DriverTransactionReadOption instance) =>
    <String, dynamic>{
      'searchTypeId': instance.searchTypeId,
      'userSubscriptionId': instance.userSubscriptionId,
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
    };
