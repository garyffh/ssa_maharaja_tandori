import 'package:json_annotation/json_annotation.dart';

part 'driver_transaction_read_option.g.dart';

@JsonSerializable()
class DriverTransactionReadOption {
  DriverTransactionReadOption({
    this.searchTypeId = 0,
    this.userSubscriptionId,
    this.fromDate,
    this.toDate,
  });

  factory DriverTransactionReadOption.fromJson(Map<String, dynamic> json) =>
      _$DriverTransactionReadOptionFromJson(json);

  Map<String, dynamic> toJson() => _$DriverTransactionReadOptionToJson(this);

  final int searchTypeId;
  final String? userSubscriptionId;
  final DateTime? fromDate;
  final DateTime? toDate;
}
