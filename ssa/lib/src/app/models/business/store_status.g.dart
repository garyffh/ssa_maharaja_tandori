// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_status.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoreStatusCWProxy {
  StoreStatus deliveryTimes(DeliveryMethodTimes deliveryTimes);

  StoreStatus openStatus(OpenStatus openStatus);

  StoreStatus periodTimes(DeliveryMethodTimes periodTimes);

  StoreStatus statusTime(DateTime statusTime);

  StoreStatus storeState(StoreState storeState);

  StoreStatus storeTimes(DeliveryMethodTimes storeTimes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreStatus(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreStatus(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreStatus call({
    DeliveryMethodTimes? deliveryTimes,
    OpenStatus? openStatus,
    DeliveryMethodTimes? periodTimes,
    DateTime? statusTime,
    StoreState? storeState,
    DeliveryMethodTimes? storeTimes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStoreStatus.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStoreStatus.copyWith.fieldName(...)`
class _$StoreStatusCWProxyImpl implements _$StoreStatusCWProxy {
  final StoreStatus _value;

  const _$StoreStatusCWProxyImpl(this._value);

  @override
  StoreStatus deliveryTimes(DeliveryMethodTimes deliveryTimes) =>
      this(deliveryTimes: deliveryTimes);

  @override
  StoreStatus openStatus(OpenStatus openStatus) => this(openStatus: openStatus);

  @override
  StoreStatus periodTimes(DeliveryMethodTimes periodTimes) =>
      this(periodTimes: periodTimes);

  @override
  StoreStatus statusTime(DateTime statusTime) => this(statusTime: statusTime);

  @override
  StoreStatus storeState(StoreState storeState) => this(storeState: storeState);

  @override
  StoreStatus storeTimes(DeliveryMethodTimes storeTimes) =>
      this(storeTimes: storeTimes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreStatus(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreStatus(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreStatus call({
    Object? deliveryTimes = const $CopyWithPlaceholder(),
    Object? openStatus = const $CopyWithPlaceholder(),
    Object? periodTimes = const $CopyWithPlaceholder(),
    Object? statusTime = const $CopyWithPlaceholder(),
    Object? storeState = const $CopyWithPlaceholder(),
    Object? storeTimes = const $CopyWithPlaceholder(),
  }) {
    return StoreStatus(
      deliveryTimes:
          deliveryTimes == const $CopyWithPlaceholder() || deliveryTimes == null
              ? _value.deliveryTimes
              // ignore: cast_nullable_to_non_nullable
              : deliveryTimes as DeliveryMethodTimes,
      openStatus:
          openStatus == const $CopyWithPlaceholder() || openStatus == null
              ? _value.openStatus
              // ignore: cast_nullable_to_non_nullable
              : openStatus as OpenStatus,
      periodTimes:
          periodTimes == const $CopyWithPlaceholder() || periodTimes == null
              ? _value.periodTimes
              // ignore: cast_nullable_to_non_nullable
              : periodTimes as DeliveryMethodTimes,
      statusTime:
          statusTime == const $CopyWithPlaceholder() || statusTime == null
              ? _value.statusTime
              // ignore: cast_nullable_to_non_nullable
              : statusTime as DateTime,
      storeState:
          storeState == const $CopyWithPlaceholder() || storeState == null
              ? _value.storeState
              // ignore: cast_nullable_to_non_nullable
              : storeState as StoreState,
      storeTimes:
          storeTimes == const $CopyWithPlaceholder() || storeTimes == null
              ? _value.storeTimes
              // ignore: cast_nullable_to_non_nullable
              : storeTimes as DeliveryMethodTimes,
    );
  }
}

extension $StoreStatusCopyWith on StoreStatus {
  /// Returns a callable class that can be used as follows: `instanceOfclass StoreStatus.name.copyWith(...)` or like so:`instanceOfclass StoreStatus.name.copyWith.fieldName(...)`.
  _$StoreStatusCWProxy get copyWith => _$StoreStatusCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreStatus _$StoreStatusFromJson(Map<String, dynamic> json) => StoreStatus(
      statusTime: DateTime.parse(json['statusTime'] as String),
      storeState:
          StoreState.fromJson(json['storeState'] as Map<String, dynamic>),
      storeTimes: DeliveryMethodTimes.fromJson(
          json['storeTimes'] as Map<String, dynamic>),
      deliveryTimes: DeliveryMethodTimes.fromJson(
          json['deliveryTimes'] as Map<String, dynamic>),
      periodTimes: DeliveryMethodTimes.fromJson(
          json['periodTimes'] as Map<String, dynamic>),
      openStatus: $enumDecode(_$OpenStatusEnumMap, json['openStatus']),
    );

Map<String, dynamic> _$StoreStatusToJson(StoreStatus instance) =>
    <String, dynamic>{
      'statusTime': instance.statusTime.toIso8601String(),
      'storeState': instance.storeState,
      'storeTimes': instance.storeTimes,
      'deliveryTimes': instance.deliveryTimes,
      'periodTimes': instance.periodTimes,
      'openStatus': _$OpenStatusEnumMap[instance.openStatus],
    };

const _$OpenStatusEnumMap = {
  OpenStatus.open: 0,
  OpenStatus.offline: 1,
  OpenStatus.closed: 2,
  OpenStatus.openingSoon: 3,
};
