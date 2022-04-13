// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitem_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SitemDetail _$SitemDetailFromJson(Map<String, dynamic> json) => SitemDetail(
      sysSitemId: json['sysSitemId'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      tax: json['tax'] as int,
      price1: (json['price1'] as num).toDouble(),
      price2: (json['price2'] as num).toDouble(),
      price3: (json['price3'] as num).toDouble(),
      price4: (json['price4'] as num).toDouble(),
      price5: (json['price5'] as num).toDouble(),
      specialPrice1: (json['specialPrice1'] as num?)?.toDouble(),
      specialPrice2: (json['specialPrice2'] as num?)?.toDouble(),
      specialPrice3: (json['specialPrice3'] as num?)?.toDouble(),
      specialPrice4: (json['specialPrice4'] as num?)?.toDouble(),
      specialPrice5: (json['specialPrice5'] as num?)?.toDouble(),
      enabled: json['enabled'] as bool,
      scale: json['scale'] as bool,
      isCondimentChain: json['isCondimentChain'] as bool,
      condimentEntry: json['condimentEntry'] as bool,
      hasImage: json['hasImage'] as bool,
      sysStoreCategory: json['sysStoreCategory'] as String,
      sysStoreCategoryId: json['sysStoreCategoryId'] as String,
      sysCondimentTableId: json['sysCondimentTableId'] as String?,
      sysCondimentChainId: json['sysCondimentChainId'] as String?,
      stockCount: json['stockCount'] as int?,
      pagePosition: json['pagePosition'] as int,
    );

Map<String, dynamic> _$SitemDetailToJson(SitemDetail instance) =>
    <String, dynamic>{
      'sysSitemId': instance.sysSitemId,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'tax': instance.tax,
      'price1': instance.price1,
      'price2': instance.price2,
      'price3': instance.price3,
      'price4': instance.price4,
      'price5': instance.price5,
      'specialPrice1': instance.specialPrice1,
      'specialPrice2': instance.specialPrice2,
      'specialPrice3': instance.specialPrice3,
      'specialPrice4': instance.specialPrice4,
      'specialPrice5': instance.specialPrice5,
      'enabled': instance.enabled,
      'scale': instance.scale,
      'isCondimentChain': instance.isCondimentChain,
      'condimentEntry': instance.condimentEntry,
      'hasImage': instance.hasImage,
      'sysStoreCategory': instance.sysStoreCategory,
      'sysStoreCategoryId': instance.sysStoreCategoryId,
      'sysCondimentTableId': instance.sysCondimentTableId,
      'sysCondimentChainId': instance.sysCondimentChainId,
      'stockCount': instance.stockCount,
      'pagePosition': instance.pagePosition,
    };
