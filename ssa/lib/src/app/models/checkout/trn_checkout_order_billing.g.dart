// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_checkout_order_billing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnCheckoutOrderBilling _$TrnCheckoutOrderBillingFromJson(
        Map<String, dynamic> json) =>
    TrnCheckoutOrderBilling(
      company: json['company'] as String?,
      companyNumber: json['companyNumber'] as String?,
      addressNote: json['addressNote'] as String?,
      street: json['street'] as String,
      extended: json['extended'] as String?,
      locality: json['locality'] as String,
      region: json['region'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      email: json['email'] as String,
      emailConfirmed: json['emailConfirmed'] as bool?,
      phoneNumber: json['phoneNumber'] as String,
      phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool?,
      paymentMethodId: json['paymentMethodId'] as String?,
      userPaymentMethodAdd: json['userPaymentMethodAdd'] == null
          ? null
          : CheckoutPaymentMethodAdd.fromJson(
              json['userPaymentMethodAdd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrnCheckoutOrderBillingToJson(
        TrnCheckoutOrderBilling instance) =>
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
      'paymentMethodId': instance.paymentMethodId,
      'userPaymentMethodAdd': instance.userPaymentMethodAdd,
    };
