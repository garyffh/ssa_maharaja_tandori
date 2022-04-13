// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_delivery_zone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoreDeliveryZoneCWProxy {
  StoreDeliveryZone bicycle(bool bicycle);

  StoreDeliveryZone deliveryCost(double deliveryCost);

  StoreDeliveryZone deliveryDistance(double deliveryDistance);

  StoreDeliveryZone deliveryFee(double deliveryFee);

  StoreDeliveryZone drive(bool drive);

  StoreDeliveryZone name(String name);

  StoreDeliveryZone number(int number);

  StoreDeliveryZone storeDeliveryZoneId(String storeDeliveryZoneId);

  StoreDeliveryZone walk(bool walk);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreDeliveryZone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreDeliveryZone(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreDeliveryZone call({
    bool? bicycle,
    double? deliveryCost,
    double? deliveryDistance,
    double? deliveryFee,
    bool? drive,
    String? name,
    int? number,
    String? storeDeliveryZoneId,
    bool? walk,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStoreDeliveryZone.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStoreDeliveryZone.copyWith.fieldName(...)`
class _$StoreDeliveryZoneCWProxyImpl implements _$StoreDeliveryZoneCWProxy {
  final StoreDeliveryZone _value;

  const _$StoreDeliveryZoneCWProxyImpl(this._value);

  @override
  StoreDeliveryZone bicycle(bool bicycle) => this(bicycle: bicycle);

  @override
  StoreDeliveryZone deliveryCost(double deliveryCost) =>
      this(deliveryCost: deliveryCost);

  @override
  StoreDeliveryZone deliveryDistance(double deliveryDistance) =>
      this(deliveryDistance: deliveryDistance);

  @override
  StoreDeliveryZone deliveryFee(double deliveryFee) =>
      this(deliveryFee: deliveryFee);

  @override
  StoreDeliveryZone drive(bool drive) => this(drive: drive);

  @override
  StoreDeliveryZone name(String name) => this(name: name);

  @override
  StoreDeliveryZone number(int number) => this(number: number);

  @override
  StoreDeliveryZone storeDeliveryZoneId(String storeDeliveryZoneId) =>
      this(storeDeliveryZoneId: storeDeliveryZoneId);

  @override
  StoreDeliveryZone walk(bool walk) => this(walk: walk);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoreDeliveryZone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoreDeliveryZone(...).copyWith(id: 12, name: "My name")
  /// ````
  StoreDeliveryZone call({
    Object? bicycle = const $CopyWithPlaceholder(),
    Object? deliveryCost = const $CopyWithPlaceholder(),
    Object? deliveryDistance = const $CopyWithPlaceholder(),
    Object? deliveryFee = const $CopyWithPlaceholder(),
    Object? drive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? storeDeliveryZoneId = const $CopyWithPlaceholder(),
    Object? walk = const $CopyWithPlaceholder(),
  }) {
    return StoreDeliveryZone(
      bicycle: bicycle == const $CopyWithPlaceholder() || bicycle == null
          ? _value.bicycle
          // ignore: cast_nullable_to_non_nullable
          : bicycle as bool,
      deliveryCost:
          deliveryCost == const $CopyWithPlaceholder() || deliveryCost == null
              ? _value.deliveryCost
              // ignore: cast_nullable_to_non_nullable
              : deliveryCost as double,
      deliveryDistance: deliveryDistance == const $CopyWithPlaceholder() ||
              deliveryDistance == null
          ? _value.deliveryDistance
          // ignore: cast_nullable_to_non_nullable
          : deliveryDistance as double,
      deliveryFee:
          deliveryFee == const $CopyWithPlaceholder() || deliveryFee == null
              ? _value.deliveryFee
              // ignore: cast_nullable_to_non_nullable
              : deliveryFee as double,
      drive: drive == const $CopyWithPlaceholder() || drive == null
          ? _value.drive
          // ignore: cast_nullable_to_non_nullable
          : drive as bool,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
      storeDeliveryZoneId:
          storeDeliveryZoneId == const $CopyWithPlaceholder() ||
                  storeDeliveryZoneId == null
              ? _value.storeDeliveryZoneId
              // ignore: cast_nullable_to_non_nullable
              : storeDeliveryZoneId as String,
      walk: walk == const $CopyWithPlaceholder() || walk == null
          ? _value.walk
          // ignore: cast_nullable_to_non_nullable
          : walk as bool,
    );
  }
}

extension $StoreDeliveryZoneCopyWith on StoreDeliveryZone {
  /// Returns a callable class that can be used as follows: `instanceOfclass StoreDeliveryZone.name.copyWith(...)` or like so:`instanceOfclass StoreDeliveryZone.name.copyWith.fieldName(...)`.
  _$StoreDeliveryZoneCWProxy get copyWith =>
      _$StoreDeliveryZoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDeliveryZone _$StoreDeliveryZoneFromJson(Map<String, dynamic> json) =>
    StoreDeliveryZone(
      storeDeliveryZoneId: json['storeDeliveryZoneId'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      deliveryDistance: (json['deliveryDistance'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      walk: json['walk'] as bool,
      bicycle: json['bicycle'] as bool,
      drive: json['drive'] as bool,
    );

Map<String, dynamic> _$StoreDeliveryZoneToJson(StoreDeliveryZone instance) =>
    <String, dynamic>{
      'storeDeliveryZoneId': instance.storeDeliveryZoneId,
      'name': instance.name,
      'number': instance.number,
      'deliveryDistance': instance.deliveryDistance,
      'deliveryFee': instance.deliveryFee,
      'deliveryCost': instance.deliveryCost,
      'walk': instance.walk,
      'bicycle': instance.bicycle,
      'drive': instance.drive,
    };
