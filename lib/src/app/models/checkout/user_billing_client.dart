import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/checkout/user_member_group.dart';
import 'package:single_store_app/src/app/models/checkout/user_payment_method_read.dart';

part 'user_billing_client.g.dart';

@JsonSerializable()
class UserBillingClient {
  UserBillingClient({
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
    required this.email,
    required this.emailConfirmed,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.paymentGatewayProvider,
    required this.balance,
    required this.points,
    required this.bonusBalance,
    required this.bonusTrigger,
    required this.bonus,
    required this.nextBonusTrigger,
    required this.nextBonus,
    required this.orderCount,
    required this.deliveryCount,
    required this.promoTaken,
    required this.deliveryTaken,
    required this.businessType,
    required this.creditLimit,
    required this.allowCredit,
    required this.stopCredit,
    required this.enabled,
    required this.memberGroup,
    required this.paymentMethods,
  });

  factory UserBillingClient.fromJson(Map<String, dynamic> json) =>
      _$UserBillingClientFromJson(json);

  Map<String, dynamic> toJson() => _$UserBillingClientToJson(this);

  final String? company;
  final String? companyNumber;
  final String? addressNote;
  final String? street;
  final String? extended;
  final String? locality;
  final String? region;
  final String? postalCode;
  final String? country;
  final double? lat;
  final double? lng;
  final double? distance;
  final String email;
  final bool? emailConfirmed;
  final String? phoneNumber;
  final bool? phoneNumberConfirmed;
  final int? paymentGatewayProvider;
  final double balance;
  final int points;
  final int bonusBalance;
  final int? bonusTrigger;
  final int? bonus;
  final int? nextBonusTrigger;
  final int? nextBonus;
  final int orderCount;
  final int deliveryCount;
  final bool promoTaken;
  final bool deliveryTaken;
  final bool businessType;
  final double creditLimit;
  final bool allowCredit;
  final bool stopCredit;
  final bool enabled;
  final UserMemberGroup? memberGroup;
  final List<UserPaymentMethodRead> paymentMethods;

  bool get allowCreditTransaction => allowCredit && !stopCredit;
}
