// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condiment_table_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CondimentTableItem _$CondimentTableItemFromJson(Map<String, dynamic> json) =>
    CondimentTableItem(
      number: json['number'] as int,
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
    );

Map<String, dynamic> _$CondimentTableItemToJson(CondimentTableItem instance) =>
    <String, dynamic>{
      'number': instance.number,
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
    };
