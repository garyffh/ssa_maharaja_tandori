import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/user/user_document_type.dart';

part 'user_transaction.g.dart';


@JsonSerializable()
class UserTransaction {
  UserTransaction({
    required this.documentId,
    required this.documentDate,
    required this.documentType,
    required this.documentSource,
    required this.documentReference,
    required this.total,
    required this.points,
    required this.paid,
    required this.redeemPoints,
    required this.openingBalance,
    required this.closingBalance,
    required this.pointBalance,
    required this.bonusBalance,
    required this.allocated,
  });

  //factory UserTransaction.fromUserTransaction(UserTransaction source) => UserTransaction.fromJson(source.toJson());

  factory UserTransaction.fromJson(Map<String, dynamic> json) => _$UserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);

  final   String documentId;
  final   DateTime documentDate;
  final   UserDocumentType documentType;
  final   String documentSource;
  final   String documentReference;
  final   double total;
  final   int points;
  final   double paid;
  final   int redeemPoints;
  final   double openingBalance;
  final   double closingBalance;
  final   int pointBalance;
  final   int bonusBalance;
  final   bool allocated;

}
