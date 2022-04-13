import 'package:json_annotation/json_annotation.dart';

part 'driver_invoice.g.dart';

@JsonSerializable()
class DriverInvoice {
  DriverInvoice({
    required this.documentId,
    required this.createdDT,
    required this.documentDate,
    required this.documentDT,
    required this.documentReference,
    required this.totalEx,
    required this.taxAmount,
    required this.total,
    required this.balance,
  });

  // factory DriverInvoice.fromDriverInvoice(DriverInvoice source) => DriverInvoice.fromJson(source.toJson());

  factory DriverInvoice.fromJson(Map<String, dynamic> json) => _$DriverInvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$DriverInvoiceToJson(this);

  final   String documentId;
  final   String createdDT;
  final   DateTime documentDate;
  final   DateTime documentDT;
  final   String documentReference;
  final   double totalEx;
  final   double taxAmount;
  final   double total;
  final   double balance;

}
