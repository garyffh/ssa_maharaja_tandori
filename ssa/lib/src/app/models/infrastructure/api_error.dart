import 'package:json_annotation/json_annotation.dart';

import 'model_state.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  ApiError({
    this.message,
    this.modelState,
    this.errorDescription,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'ModelState')
  final ModelState? modelState;

  @JsonKey(name: 'error_description')
  final String? errorDescription;

}
