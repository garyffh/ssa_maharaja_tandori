import 'package:json_annotation/json_annotation.dart';

import 'invoice_detail_item.dart';

part 'invoice_detail.g.dart';

@JsonSerializable()
class InvoiceDetail {
  InvoiceDetail({
    required this.documentId,
    required this.createdDT,
    required this.documentDate,
    required this.documentDT,
    required this.documentSource,
    required this.documentReference,
    required this.billingCycle,
    required this.totalEx,
    required this.taxAmount,
    required this.total,
    required this.productPoints,
    required this.spendPoints,
    required this.paid,
    required this.redeemPoints,
    this.identityBalance,
    this.identityPointBalance,
    this.identityBonusBalance,
    required this.balance,
    required this.pointBalance,
    required this.bonusBalance,
    required this.allocated,
    required this.creditApplied,
    required this.deliveryMethodType,
    required this.deliveryMethodTime,
    required this.issuerCompany,
    required this.issuerCompanyNumber,
    required this.issuerStreet,
    required this.issuerExtended,
    required this.issuerLocality,
    required this.issuerRegion,
    required this.issuerPostalCode,
    required this.issuerCountry,
    required this.issuerPhoneNumber,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.companyNumber,
    required this.addressNote,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.timeZoneId,
    required this.phoneNumber,
    required this.items,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDetailToJson(this);

  final String documentId;
  final String createdDT;
  final DateTime documentDate;
  final DateTime documentDT;
  final String documentSource;
  final String documentReference;
  final int? billingCycle;
  final double totalEx;
  final double taxAmount;
  final double total;
  final int productPoints;
  final int spendPoints;
  final double paid;
  final int redeemPoints;
  final double? identityBalance;
  final int? identityPointBalance;
  final int? identityBonusBalance;
  final double balance;
  final int pointBalance;
  final int bonusBalance;
  final bool allocated;
  final bool creditApplied;
  final int deliveryMethodType;
  final DateTime deliveryMethodTime;
  final String issuerCompany;
  final String issuerCompanyNumber;
  final String issuerStreet;
  final String issuerExtended;
  final String issuerLocality;
  final String issuerRegion;
  final String issuerPostalCode;
  final String issuerCountry;
  final String issuerPhoneNumber;
  final String firstName;
  final String lastName;
  final String company;
  final String companyNumber;
  final String addressNote;
  final String street;
  final String extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final double? lat;
  final double? lng;
  final double? distance;
  final String? timeZoneId;
  final String phoneNumber;

  final List<InvoiceDetailItem> items;

  int get totalPoints => productPoints + spendPoints - redeemPoints;

  List<InvoiceDetailItem> readableItems() =>
      items.where((element) => element.isReadable).toList();

  double displayBalance(bool showForIdentity) {
    if(showForIdentity && identityBalance != null) {
      return identityBalance!;
    } else {
      return balance;
    }
  }

  int displayPointBalance(bool showForIdentity) {
    if(showForIdentity && identityPointBalance != null) {
      return identityPointBalance!;
    } else {
      return pointBalance;
    }
  }

  int displayBonusBalance(bool showForIdentity) {
    if(showForIdentity && identityBonusBalance != null) {
      return identityBonusBalance!;
    } else {
      return bonusBalance;
    }
  }

}
