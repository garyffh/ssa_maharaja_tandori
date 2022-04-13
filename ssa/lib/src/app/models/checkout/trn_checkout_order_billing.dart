import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';

import 'checkout_payment_method_add.dart';

part 'trn_checkout_order_billing.g.dart';

@JsonSerializable()
@immutable
class TrnCheckoutOrderBilling {
  const TrnCheckoutOrderBilling({
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
    required this.paymentMethodId,
    required this.userPaymentMethodAdd,
  });

  TrnCheckoutOrderBilling.fromCheckoutSubmit(
    TrnCheckout trnCheckout,
    UserBillingClient userBillingClient,
  )   : company = trnCheckout.trnCheckoutAddress!.company,
        companyNumber = trnCheckout.trnCheckoutAddress!.companyNumber,
        addressNote = trnCheckout.trnCheckoutAddress!.addressNote,
        street = trnCheckout.trnCheckoutAddress!.street,
        extended = trnCheckout.trnCheckoutAddress!.extended,
        locality = trnCheckout.trnCheckoutAddress!.locality,
        region = trnCheckout.trnCheckoutAddress!.region,
        postalCode = trnCheckout.trnCheckoutAddress!.postalCode,
        country = trnCheckout.trnCheckoutAddress!.country,
        lat = trnCheckout.trnCheckoutAddress!.lat,
        lng = trnCheckout.trnCheckoutAddress!.lng,
        distance = trnCheckout.trnCheckoutAddress!.distance,
        email = userBillingClient.email,
        emailConfirmed = true,
        phoneNumber = trnCheckout.trnCheckoutPhone!.phoneNumber,
        phoneNumberConfirmed = true,
        paymentMethodId = trnCheckout.trnCheckoutPaymentMethod.creditTransaction
            ? null
            : trnCheckout.trnCheckoutPaymentMethod
                .selectedPaymentMethod!.userPaymentMethodId,
        userPaymentMethodAdd = null;

  factory TrnCheckoutOrderBilling.fromJson(Map<String, dynamic> json) =>
      _$TrnCheckoutOrderBillingFromJson(json);

  Map<String, dynamic> toJson() => _$TrnCheckoutOrderBillingToJson(this);

  final String? company;
  final String? companyNumber;
  final String? addressNote;
  final String street;
  final String? extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final double? lat;
  final double? lng;
  final double? distance;
  final String email;
  final bool? emailConfirmed;
  final String phoneNumber;
  final bool? phoneNumberConfirmed;
  final String? paymentMethodId;
  final CheckoutPaymentMethodAdd? userPaymentMethodAdd;
}
