// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
      message: json['Message'] as String?,
      modelState: json['ModelState'] == null
          ? null
          : ModelState.fromJson(json['ModelState'] as Map<String, dynamic>),
      errorDescription: json['error_description'] as String?,
    );

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'Message': instance.message,
      'ModelState': instance.modelState,
      'error_description': instance.errorDescription,
    };
