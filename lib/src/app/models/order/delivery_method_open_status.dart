import 'package:json_annotation/json_annotation.dart';

enum DeliveryMethodOpenStatus {
  @JsonValue(0)
  closed,
  @JsonValue(1)
  open,
  @JsonValue(2)
  schedule
}
