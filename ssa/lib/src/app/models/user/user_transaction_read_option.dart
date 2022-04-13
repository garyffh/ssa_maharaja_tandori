import 'package:json_annotation/json_annotation.dart';

part 'user_transaction_read_option.g.dart';

@JsonSerializable()
class UserTransactionReadOption {
  UserTransactionReadOption({
    required this.searchTypeId,
    this.userSubscriptionId,
    this.fromDate,
    this.toDate,
  });

  factory UserTransactionReadOption.fromJson(Map<String, dynamic> json) => _$UserTransactionReadOptionFromJson(json);
  Map<String, dynamic> toJson() => _$UserTransactionReadOptionToJson(this);

  final   int searchTypeId;
  final   String? userSubscriptionId;
  final   DateTime? fromDate;
  final   DateTime? toDate;

}
