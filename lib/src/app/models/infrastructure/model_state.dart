import 'package:json_annotation/json_annotation.dart';

part 'model_state.g.dart';

@JsonSerializable()
class ModelState {
  ModelState({
    this.modelError,
  });

  factory ModelState.fromJson(Map<String, dynamic> json) =>
      _$ModelStateFromJson(json);

  Map<String, dynamic> toJson() => _$ModelStateToJson(this);

  final List<String>? modelError;
}
