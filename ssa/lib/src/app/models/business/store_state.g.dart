// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreState _$StoreStateFromJson(Map<String, dynamic> json) => StoreState(
      storeAvailable: json['storeAvailable'] as bool,
      deliveryAvailable: json['deliveryAvailable'] as bool,
      manualStoreOnline: json['manualStoreOnline'] as bool,
      manualDeliveryOnline: json['manualDeliveryOnline'] as bool,
      storeOnline: json['storeOnline'] as bool,
      driverAvailable: json['driverAvailable'] as bool,
      storePrepTime: json['storePrepTime'] as int,
      storeLiveTime: json['storeLiveTime'] as int,
      driverDeliveryTime: json['driverDeliveryTime'] as int,
      driverLiveTime: json['driverLiveTime'] as int,
      messageTitle: json['messageTitle'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$StoreStateToJson(StoreState instance) =>
    <String, dynamic>{
      'storeAvailable': instance.storeAvailable,
      'deliveryAvailable': instance.deliveryAvailable,
      'manualStoreOnline': instance.manualStoreOnline,
      'manualDeliveryOnline': instance.manualDeliveryOnline,
      'storeOnline': instance.storeOnline,
      'driverAvailable': instance.driverAvailable,
      'storePrepTime': instance.storePrepTime,
      'storeLiveTime': instance.storeLiveTime,
      'driverDeliveryTime': instance.driverDeliveryTime,
      'driverLiveTime': instance.driverLiveTime,
      'messageTitle': instance.messageTitle,
      'message': instance.message,
    };
