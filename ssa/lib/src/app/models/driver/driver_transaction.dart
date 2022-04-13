import 'package:json_annotation/json_annotation.dart';

import 'driver_document_type.dart';

part 'driver_transaction.g.dart';

@JsonSerializable()
class DriverTransaction {
  DriverTransaction({
    required this.documentId,
    required this.documentDT,
    required this.documentDate,
    required this.documentType,
    required this.documentReference,
    required this.total,
    required this.openingBalance,
    required this.closingBalance,
  });

  factory DriverTransaction.fromJson(Map<String, dynamic> json) =>
      _$DriverTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$DriverTransactionToJson(this);

  final String documentId;
  final DateTime documentDT;
  final DateTime documentDate;
  final DriverDocumentType documentType;
  final String documentReference;
  final double total;
  final double openingBalance;
  final double closingBalance;
}
