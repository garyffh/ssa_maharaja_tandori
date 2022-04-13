// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_billing_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBillingClient _$UserBillingClientFromJson(Map<String, dynamic> json) =>
    UserBillingClient(
      company: json['company'] as String?,
      companyNumber: json['companyNumber'] as String?,
      addressNote: json['addressNote'] as String?,
      street: json['street'] as String?,
      extended: json['extended'] as String?,
      locality: json['locality'] as String?,
      region: json['region'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      email: json['email'] as String,
      emailConfirmed: json['emailConfirmed'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool?,
      paymentGatewayProvider: json['paymentGatewayProvider'] as int?,
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
      bonusBalance: json['bonusBalance'] as int,
      bonusTrigger: json['bonusTrigger'] as int?,
      bonus: json['bonus'] as int?,
      nextBonusTrigger: json['nextBonusTrigger'] as int?,
      nextBonus: json['nextBonus'] as int?,
      orderCount: json['orderCount'] as int,
      deliveryCount: json['deliveryCount'] as int,
      promoTaken: json['promoTaken'] as bool,
      deliveryTaken: json['deliveryTaken'] as bool,
      businessType: json['businessType'] as bool,
      creditLimit: (json['creditLimit'] as num).toDouble(),
      allowCredit: json['allowCredit'] as bool,
      stopCredit: json['stopCredit'] as bool,
      enabled: json['enabled'] as bool,
      memberGroup: json['memberGroup'] == null
          ? null
          : UserMemberGroup.fromJson(
              json['memberGroup'] as Map<String, dynamic>),
      paymentMethods: (json['paymentMethods'] as List<dynamic>)
          .map((e) => UserPaymentMethodRead.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserBillingClientToJson(UserBillingClient instance) =>
    <String, dynamic>{
      'company': instance.company,
      'companyNumber': instance.companyNumber,
      'addressNote': instance.addressNote,
      'street': instance.street,
      'extended': instance.extended,
      'locality': instance.locality,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'lat': instance.lat,
      'lng': instance.lng,
      'distance': instance.distance,
      'email': instance.email,
      'emailConfirmed': instance.emailConfirmed,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberConfirmed': instance.phoneNumberConfirmed,
      'paymentGatewayProvider': instance.paymentGatewayProvider,
      'balance': instance.balance,
      'points': instance.points,
      'bonusBalance': instance.bonusBalance,
      'bonusTrigger': instance.bonusTrigger,
      'bonus': instance.bonus,
      'nextBonusTrigger': instance.nextBonusTrigger,
      'nextBonus': instance.nextBonus,
      'orderCount': instance.orderCount,
      'deliveryCount': instance.deliveryCount,
      'promoTaken': instance.promoTaken,
      'deliveryTaken': instance.deliveryTaken,
      'businessType': instance.businessType,
      'creditLimit': instance.creditLimit,
      'allowCredit': instance.allowCredit,
      'stopCredit': instance.stopCredit,
      'enabled': instance.enabled,
      'memberGroup': instance.memberGroup,
      'paymentMethods': instance.paymentMethods,
    };
