import 'package:json_annotation/json_annotation.dart';

part 'driver_payment.g.dart';

@JsonSerializable()
class DriverPayment {
  DriverPayment({
    required this.documentId,
    required this.createdDT,
    required this.documentDate,
    required this.documentDT,
    required this.documentReference,
    required this.comment,
    required this.total,
    required this.balance,
  });

  // factory DriverPayment.fromDriverPayment(DriverPayment source) => DriverPayment.fromJson(source.toJson());

  factory DriverPayment.fromJson(Map<String, dynamic> json) => _$DriverPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$DriverPaymentToJson(this);

  final   String documentId;
  final   String createdDT;
  final   DateTime documentDate;
  final   DateTime documentDT;
  final   String documentReference;
  final   String comment;
  final   double total;
  final   double balance;

}
