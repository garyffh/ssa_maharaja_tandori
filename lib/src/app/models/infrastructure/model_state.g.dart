// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelState _$ModelStateFromJson(Map<String, dynamic> json) => ModelState(
      modelError: (json['modelError'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ModelStateToJson(ModelState instance) =>
    <String, dynamic>{
      'modelError': instance.modelError,
    };
